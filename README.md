- TODO: add a logo

# Netguru Networking Module

Welcome to the **Netguru Networking Module**.\
**NgNetworkModule** is **simple**, **highly configurable** iOS and MacOS module to **execute** network **calls** and **parse** received **answers**.

## Main Features
* Pure Swift
* Intuitive, simple API
* Protocol-oriented implementation
* Almost 98% Unit Tests coverage
* Support for reactive programming (Combine)
* Support for modern Swift concurrency (async/await)
* Extendable with configurable actions

## Integration

### Requirements
* iOS 13+
* macOS 10.15+
* [Swift Package Manager](https://swift.org/package-manager/)

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
- Default API - a classic API to execute a network request and return an answer in a callback.
```
import NgNetworkModule
```
- Reactive API (Combine) - a reactive API emitting an answer as an event, or an error.
```
import ReactiveNgNetworkModule
```
- Concurrent API (async/await) - an API utilising modern Swift concurrency.
```
import ConcurrentNgNetworkModule
```

### Creating network module:
```
import NgNetworkModule / ReactiveNgNetworkModule / ConcurrentNgNetworkModule
...
let baseURL = URL(string: "https://your.base.url")!
let requestBuilder = DefaultRequestBuilder(baseURL: baseURL)
let networkModule = DefaultNetworkModule(requestBuilder: requestBuilder)
```

### Creating and using automatic request / response parsing:

In order to parse correctly, the request description must conform to **NetworkRequest** protocol:

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
- Reactive API (Combine) - a reactive API emitting an answer as an event, or an error:
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
- Concurrent API (async/await) - an API utilising modern Swift concurrency:
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
struct RetrieveAccessTokeAction: NetworkModuleAction {
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
let action = RetrieveAccessTokeAction()
let networkModule = DefaultNetworkModule(
	requestBuilder: requestBuilder,
	actions: [action] // <-- Include additional Actions here
)
```

### Running sample application

- TODO: project description

## Related repositories

- [Netguru Pinning Engine](https://github.com/netguru/pinning-engine-ios)
- [Highway](https://github.com/netguru/highway)
- [Response Detective](https://github.com/netguru/ResponseDetective)
