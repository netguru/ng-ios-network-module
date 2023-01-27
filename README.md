# Netguru Networking Module

Welcome to the **Netguru Networking Module**.\
**NgNetworkModule** is **simple**, **highly configurable** iOS and MacOS module to **execute** network **calls** and **parse** received **answers**.

## Main Features
* Pure Swift
* Intuitive, simple API
* Protocol-oriented implementation
* Extensive Unit Tests coverage
* Support for reactive programming (`Combine`)
* Support for modern Swift concurrency (`async/await`)
* Extendable with configurable actions

## Integration

### Requirements
* iOS 13+
* macOS 10.15+

### Adding module to your app

**NgNetworkModule** is available through [Swift Package Manager](https://swift.org/package-manager/).

- When added as a package dependency:
```
dependencies: [
        .package(
            url: "https://github.com/netguru/ng-ios-network-module.git",
            from: "1.0.0"
        )
    ]
```
- When added as a project dependency:
```
1. Select File > Swift Packages > Add Package Dependency.
2. Enter the repository URL.
3. Wait until the dependencies are resolved.
```

## Using NgNetworkModule

### Available API variants:
The module is available in 3 variants:
- Network Module Core - a base module, leveraging callback-based API to execute a network request and return an answer in a callback. 
```
import NgNetworkModuleCore
```
- Reactive API (`Combine`) - a reactive API emitting an answer as an event, or an error. Requires importing `NgNetworkModuleCore` to work!
```
import ReactiveNgNetworkModule
```
- Concurrent API (`async/await`) - an API utilising modern Swift concurrency. Requires importing `NgNetworkModuleCore` to work!
```
import ConcurrentNgNetworkModule
```

### Creating network module:
```
import NgNetworkModuleCore
(optionally) import ReactiveNgNetworkModule / ConcurrentNgNetworkModule
...
let baseURL = URL(string: "https://your.base.url")!
let requestBuilder = DefaultRequestBuilder(baseURL: baseURL)
let networkModule = DefaultNetworkModule(requestBuilder: requestBuilder)
```

### Creating and using automatic request / response parsing:

In order to parse correctly, the request description must conform to `NetworkRequest` protocol:

```
struct SampleGetNetworkRequest: NetworkRequest {
    let path = "/welcome"
    let method = NetworkRequestType.get
}
```
or
```
struct SamplePostNetworkRequest: NetworkRequest {
    let method = NetworkRequestType.post
    let path = "/welcome"
    let body: Encodable? = ["foo": "bar"]
}
```
or
```
struct SamplePostNetworkRequest2: NetworkRequest {
    let method = NetworkRequestType.post
    let path = "/welcome2"
    let bodyData: Data? = Data()
}
```
Having defined such a request, you may use convenience API to **encode** and **call** it, (optionally) **decoding** received response:
```
struct ExpectedResponse: Decodable {}
...
let request = SampleGetRequest()
...
networkModule.performAndDecode(request: request, responseType: ExpectedResponse.self)
    switch result {
    case let .success(response):
        // Handle decoded response here
    case let .failure(error):
        // Handle error here
    }
}
```

### Available APIs
- Default API - a classic API to execute a network request and return an answer in a callback:
```
networkModule.perform(request: networkRequest) { result in
networkModule.perform(urlRequest: urlRequest) { result in
networkModule.performAndDecode(urlRequest: urlRequest, responseType: ExpectedResponse.self) { result in
networkModule.performAndDecode(request: networkRequest, responseType: ExpectedResponse.self) { result in
    switch result {
    case let .success(response):
        // Handle response here
    case let .failure(error):
        // Handle error here
    }
}
``` 
- Reactive API (`Combine`) - a reactive API emitting an answer as an event, or an error:
```
perform(request: networkRequest)
perform(urlRequest: urlRequest)
performAndDecode(request: networkRequest, responseType: ExpectedResponse.self)
performAndDecode(urlRequest: urlRequest, responseType: ExpectedResponse.self)
        .sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Handle completion here (optionally)
                case let .failure(error):
                    // Handle error here
                }
            },
            receiveValue: { response in
                // Handle response here
            })
        .store(in: &cancellables)
```
- Concurrent API (`async/await`) - an API utilising modern Swift concurrency:
```
do {
    let response = try await networkModule.perform(request: networkRequest)
    let response = try await networkModule.perform(urlRequest: urlRequest)
    let response = try await networkModule.performAndDecode(urlRequest: urlRequest, responseType: ExpectedResponse.self)
    let response = try await networkModule.performAndDecode(request: networkRequest, responseType: ExpectedResponse.self)
    // Handle response here
} catch {
    // Handle error here
}
```

### Advanced use cases
- Adding authentication token to the request:
```
let accessTokenProvider = ... // Implement AuthenticationTokenProvider or just use String
let accessTokenHeaderName = "Authorization"
addTokenAction = AddAuthenticationTokenNetworkModuleAction(
	authenticationTokenProvider: accessTokenProvider, 
	authenticationTokenHeaderFieldName: accessTokenHeaderName
)
...
let networkModule = DefaultNetworkModule(
    requestBuilder: requestBuilder,
    actions: [addTokenAction] // <-- Include additional Actions here
)
...
networkModule.perform(request: networkRequest) { ... }
```
- Defining custom pre/post execution request actions:
```
/// An Action extracting an updated Access Token from a received Network Response:
struct RetrieveAccessTokenAction: NetworkModuleAction {
    private let accessTokenHeaderName = "Access-token" 
        
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        // Noop
    }

    func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse) {
        guard let headerFields = networkResponse.networkResponse.allHeaderFields,
           let accessToken = headerFields[accessTokenHeaderName] as? String else {
            return
        }
        // Save retrieved access token
    }
}
```
Adding the Action to the Network Module:
```
let action = RetrieveAccessTokenAction()
let networkModule = DefaultNetworkModule(
	requestBuilder: requestBuilder,
	actions: [action] // <-- Include additional Actions here
)
```

### Error handling
- `NetworkError.requestParsingFailed`\
**Description**: The request builder failed to parse the `NetworkRequest` structure into an `URLRequest`.    
**Solution**: Ensure that the non-trivial request properties (especially `parameters`, `body` or `bodyData`) are properly defined.
- `NetworkError.responseParsingFailed`\
**Description**: Although the request succeeded, the `NetworkModule` failed to decoded received response into a provided data type.  
**Solution**: Ensure an expected response type matches what is returned from the backend. 
- `NetworkError.noResponseData`\
**Description**: Although the request succeeded, the received response contained no data to decode.     
**Solution**: Ensure the endpoint you try to call is supposed to return a non-empty response.
- `NetworkError.serverError(code:message:)`\
**Description**: The request caused a server error.     
**Solution**: Report the error to the backend team.
- `NetworkError.notFound`\
**Description**: The requested endpoint cannot be found.      
**Solution**: Ensure the request path is correct.
- `NetworkError.forbidden`\
**Description**: The requested endpoint requires authentication.      
**Solution**: Ensure that you included a valid Access Token in the request.
- `NetworkError.unauthorized`\
**Description**: The provided access token does not allow you to access the requested resource.      
**Solution**: Reach out to the backend team and verify access level for the resource.
- `NetworkError.invalidRequest(code:message:)`\
**Description**: Any other request-related error (4XX error code).      
**Solution**: Ensure the outgoing request is according to the backend specification.
- `NetworkError.cancelled`\
**Description**: The request has been cancelled by the user.      
**Solution**: Not treated as an error!

### Running sample application

Coming soon...

## Related repositories

- [Netguru Pinning Engine](https://github.com/netguru/pinning-engine-ios)
- [Highway](https://github.com/netguru/highway)
- [Response Detective](https://github.com/netguru/ResponseDetective)
