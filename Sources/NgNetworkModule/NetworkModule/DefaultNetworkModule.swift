import Foundation

// MARK: - DefaultNetworkModule.

/// Default implementation of NetworkModule.
final public class DefaultNetworkModule: NetworkModule {
    private let requestBuilder: RequestBuilder
    private let urlSession: NetworkSession
    private let actions: [NetworkModuleAction]
    private let completionExecutor: AsynchronousOperationsExecutor

    /// A default initializer for DefaultNetworkModule.
    ///
    /// - Parameters:
    ///   - requestBuilder: a request builder.
    ///   - urlSession: an URL session.
    ///   - actions: a set of actions to be performed before or after a network call.
    ///   - completionExecutor: a completion callback executor.
    public init(
        requestBuilder: RequestBuilder,
        urlSession: NetworkSession = URLSession.shared,
        actions: [NetworkModuleAction] = [],
        completionExecutor: AsynchronousOperationsExecutor = MainQueueOperationsExecutor()
    ) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
        self.actions = actions
        self.completionExecutor = completionExecutor
    }

    /// - SeeAlso: NetworkModule.perform(request:completion:)
    @discardableResult public func perform(
        request: NetworkRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask? {
        guard let urlRequest = requestBuilder.build(request: request) else {
            executeOnMainThread(completionCallback: completion, result: .failure(.requestParsingFailed))
            return nil
        }

        return perform(urlRequest: urlRequest, withOptionalContext: request, completion: completion)
    }

    /// - SeeAlso: NetworkModule.perform(urlRequest:completion:)
    @discardableResult public func perform(
        urlRequest: URLRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask {
        perform(urlRequest: urlRequest, withOptionalContext: nil, completion: completion)
    }
}

// MARK: - Implementation details.

private extension DefaultNetworkModule {

    @discardableResult func perform(
        urlRequest: URLRequest,
        withOptionalContext networkRequest: NetworkRequest?,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask {
        var urlRequest = urlRequest

        performActionsBeforeNetworkCall(request: networkRequest, urlRequest: &urlRequest)

        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error as NSError? {
                self?.handle(error: error, completion: completion)
            } else if let response = response as? HTTPURLResponse {
                self?.handle(response: response, data: data, request: networkRequest, completion: completion)
            } else {
                self?.executeOnMainThread(completionCallback: completion, result: .failure(NetworkError.unknown))
            }
        }
        task.resume()

        return task
    }

    func handle(
        response: HTTPURLResponse,
        data: Data?,
        request: NetworkRequest?,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) {
        if let networkError = response.toNetworkError() {
            executeOnMainThread(completionCallback: completion, result: .failure(networkError))
            return
        }

        let networkResponse = NetworkResponse(data: data, networkResponse: response)
        performActionsAfterNetworkCall(request: request, response: networkResponse)
        executeOnMainThread(completionCallback: completion, result: .success(networkResponse))
    }

    func handle(error: NSError, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) {
        let networkError = NetworkError(error: error)
        guard networkError != .cancelled else {
            return
        }

        executeOnMainThread(completionCallback: completion, result: .failure(networkError))
    }

    func performActionsBeforeNetworkCall(request: NetworkRequest?, urlRequest: inout URLRequest) {
        actions.forEach { action in
            action.performBeforeExecutingNetworkRequest(request: request, urlRequest: &urlRequest)
        }
    }

    func performActionsAfterNetworkCall(request: NetworkRequest?, response: NetworkResponse) {
        actions.forEach { action in
            action.performAfterExecutingNetworkRequest(request: request, networkResponse: response)
        }
    }

    func executeOnMainThread(
        completionCallback callback: ((Result<NetworkResponse, NetworkError>) -> Void)?,
        result: Result<NetworkResponse, NetworkError>
    ) {
        completionExecutor.execute {
            callback?(result)
        }
    }
}
