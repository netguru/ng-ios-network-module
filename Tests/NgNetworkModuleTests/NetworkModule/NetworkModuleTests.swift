//
//  NetworkModuleTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class DefaultNetworkModuleTest: XCTestCase {
    var fakeRequestBuilder: FakeRequestBuilder!
    var fakeNetworkSession: FakeNetworkSession!
    var fakeNetworkModuleAction: FakeNetworkModuleAction!
    var fixtureUrlRequest: URLRequest!
    var lastRecordedResponse: NetworkResponse?
    var lastRecordedDecodedResponse: Decodable?
    var lastRecordedError: NetworkError?
    var lastRecordedNetworkTask: URLSessionTask?
    var sut: DefaultNetworkModule!

    override func setUp() {
        fakeRequestBuilder = FakeRequestBuilder()
        fakeNetworkSession = FakeNetworkSession()
        fakeNetworkModuleAction = FakeNetworkModuleAction()
        fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/welcome")!)
        lastRecordedResponse = nil
        lastRecordedError = nil
        lastRecordedNetworkTask = nil
        lastRecordedDecodedResponse = nil
        sut = DefaultNetworkModule(
            requestBuilder: fakeRequestBuilder,
            urlSession: fakeNetworkSession,
            actions: [fakeNetworkModuleAction],
            completionExecutor: FakeAsynchronousOperationsExecutor()
        )
    }

    // MARK: - Handling NetworkRequest:

    func test_whenRequestFailsToParse_shouldNotExecuteIt_andReturnProperError() {
        //  given:
        fakeRequestBuilder.simulatedUrlRequest = nil

        //  when:
        perform(request: fakeNetworkRequest)

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.requestParsingFailed, "Should return proper error")
        XCTAssertNil(lastRecordedResponse, "Should return no response")
        XCTAssertNil(lastRecordedNetworkTask, "Should not return a task")
    }

    func test_whenRequestBuildsProperly_shouldExecuteIt() {
        // given:
        fakeRequestBuilder.simulatedUrlRequest = fixtureUrlRequest

        // when:
        perform(request: fakeNetworkRequest)

        // then:
        XCTAssertEqual(lastRecordedNetworkTask?.state, URLSessionTask.State.running, "Should create a network task")
        XCTAssertEqual(fakeNetworkModuleAction.lastRequestPreExecutionActionPerformedOn, fixtureUrlRequest, "Should execute proper action")
    }

    func test_whenExecutingNetworkRequest_andSuccessResponseIsReturned_shouldDecodeAndReturnIt() {
        //  given:
        let fixtureResponse = makeURLResponse()
        let fakeDecodedResponse = FakeDecodedResponse(foo: "bar")
        let fakeResponseData = fakeDecodedResponse.encoded()!
        fakeRequestBuilder.simulatedUrlRequest = fixtureUrlRequest

        //  when:
        performAndDecode(request: fakeNetworkRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateSuccess(data: fakeResponseData, response: fixtureResponse)

        //  then:
        let expectedNetworkResponse = NetworkResponse(data: fakeResponseData, networkResponse: fixtureResponse)
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeDecodedResponse, fakeDecodedResponse, "Should decode received data into proper response")
        XCTAssertEqual(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, expectedNetworkResponse, "Should execute proper action")
    }

    func test_whenExecutingNetworkRequest_andSuccessButNotMatchingResponseIsReturned_shouldReturnProperError() {
        //  given:
        fakeRequestBuilder.simulatedUrlRequest = fixtureUrlRequest

        //  when:
        performAndDecode(request: fakeNetworkRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateSuccess(data: Data(), response: makeURLResponse())

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.responseParsingFailed, "Should return a proper error")
    }

    func test_whenExecutingNetworkRequest_andGenericErrorIsReturned_shouldReturnProperError() {
        // given:
        let fixtureErrorCode = 420
        let fixtureError = NSError(domain: "fixtureDomain", code: fixtureErrorCode)
        fakeRequestBuilder.simulatedUrlRequest = fixtureUrlRequest

        // when:
        performAndDecode(request: fakeNetworkRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateFailure(response: makeURLResponse(code: fixtureErrorCode), error: fixtureError)

        // then:
        XCTAssertEqual(lastRecordedError, NetworkError.invalidRequest(code: fixtureErrorCode, message: fixtureError.localizedDescription), "Should return a proper error")
        XCTAssertNil(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, "Should NOT trigger any post-execution actions")
    }

    // MARK: - Handling UrlRequest:

    func test_whenProvidingUrlRequest_shouldExecuteIt() {
        // when:
        perform(request: fixtureUrlRequest)

        // then:
        XCTAssertEqual(lastRecordedNetworkTask?.state, URLSessionTask.State.running, "Should create a network task")
        XCTAssertEqual(fakeNetworkModuleAction.lastRequestPreExecutionActionPerformedOn, fixtureUrlRequest, "Should execute proper action")
    }

    func test_whenExecutingUrlRequest_andSuccessResponseIsReturned_shouldDecodeAndReturnIt() {
        //  given:
        let fixtureResponse = makeURLResponse()
        let fakeDecodedResponse = FakeDecodedResponse(foo: "bar")
        let fakeResponseData = fakeDecodedResponse.encoded()!

        //  when:
        performAndDecode(request: fixtureUrlRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateSuccess(data: fakeResponseData, response: fixtureResponse)

        //  then:
        let expectedNetworkResponse = NetworkResponse(data: fakeResponseData, networkResponse: fixtureResponse)
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeDecodedResponse, fakeDecodedResponse, "Should decode received data into proper response")
        XCTAssertEqual(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, expectedNetworkResponse, "Should execute proper action")
    }

    func test_whenExecutingUrlRequest_andSuccessButNotMatchingResponseIsReturned_shouldReturnProperError() {
        //  when:
        performAndDecode(request: fixtureUrlRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateSuccess(data: Data(), response: makeURLResponse())

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.responseParsingFailed, "Should return a proper error")
    }

    func test_whenExecutingUrlRequest_andGenericErrorIsReturned_shouldReturnProperError() {
        // given:
        let fixtureErrorCode = 420
        let fixtureError = NSError(domain: "fixtureDomain", code: fixtureErrorCode)

        // when:
        performAndDecode(request: fixtureUrlRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateFailure(response: makeURLResponse(code: fixtureErrorCode), error: fixtureError)

        // then:
        XCTAssertEqual(lastRecordedError, NetworkError.invalidRequest(code: fixtureErrorCode, message: fixtureError.localizedDescription), "Should return a proper error")
        XCTAssertNil(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, "Should NOT trigger any post-execution actions")
    }

    func test_whenExecutingUrlRequest_andCancelledErrorIsReturned_shouldNotReturnAnything() {
        // given:
        let fixtureError = NSError(domain: "fixtureDomain", code: -999)

        // when:
        performAndDecode(request: fixtureUrlRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateFailure(response: nil, error: fixtureError)

        // then:
        XCTAssertNil(lastRecordedError, "Should return no error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should return no response")
        XCTAssertEqual(fakeNetworkModuleAction.lastRequestPreExecutionActionPerformedOn, fixtureUrlRequest, "Should execute proper per-execution action")
        XCTAssertNil(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, "Should NOT trigger any post-execution actions")
    }

    func test_whenExecutingUrlRequest_andResponseWithErrorIsReturned_shouldReturnProperError() {
        // given:
        let fixtureErrorCode = 420

        // when:
        performAndDecode(request: fixtureUrlRequest, responseType: FakeDecodedResponse.self)
        fakeNetworkSession.simulateFailure(response: makeURLResponse(code: fixtureErrorCode), error: nil)

        // then:
        let expectedErrorMessage = HTTPURLResponse.localizedString(forStatusCode: fixtureErrorCode)
        XCTAssertEqual(lastRecordedError, NetworkError.invalidRequest(code: fixtureErrorCode, message: expectedErrorMessage), "Should return a proper error")
        XCTAssertNil(fakeNetworkModuleAction.lastResponsePostExecutionActionPerformedOn, "Should NOT trigger any post-execution actions")
    }
}

extension DefaultNetworkModuleTest {

    var fakeNetworkRequest: FakeGetNetworkRequest {
        FakeGetNetworkRequest(path: "/welcome")
    }

    func makeURLResponse(url: URL? = nil, code: Int = 200) -> HTTPURLResponse {
        let url = url ?? fixtureUrlRequest.url!
        return HTTPURLResponse(url: url, statusCode: code, httpVersion: nil, headerFields: nil)!
    }

    func perform(request: NetworkRequest) {
        lastRecordedNetworkTask = sut.perform(request: request) { result in
            switch result {
            case let .success(response):
                self.lastRecordedResponse = response
            case let .failure(error):
                self.lastRecordedError = error
            }
        }
    }

    func perform(request: URLRequest) {
        lastRecordedNetworkTask = sut.perform(urlRequest: request) { result in
            switch result {
            case let .success(response):
                self.lastRecordedResponse = response
            case let .failure(error):
                self.lastRecordedError = error
            }
        }
    }

    func performAndDecode<T: Decodable>(request: NetworkRequest, responseType: T.Type) {
        lastRecordedNetworkTask = sut.performAndDecode(request: request, responseType: T.self) { result in
            switch result {
            case let .success(response):
                self.lastRecordedDecodedResponse = response
            case let .failure(error):
                self.lastRecordedError = error
            }
        }
    }

    func performAndDecode<T: Decodable>(request: URLRequest, responseType: T.Type) {
        lastRecordedNetworkTask = sut.performAndDecode(urlRequest: request, responseType: T.self) { result in
            switch result {
            case let .success(response):
                self.lastRecordedDecodedResponse = response
            case let .failure(error):
                self.lastRecordedError = error
            }
        }
    }
}

private struct FakeDecodedResponse: Codable, Equatable {
    let foo: String
}
