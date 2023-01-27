//
//  NetworkModulePrimaryReactiveAPITests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest
import Combine

@testable import NgNetworkModuleCore
@testable import ReactiveNgNetworkModule

final class NetworkModuleReactiveAPITests: XCTestCase {
    var lastRecordedResponse: NetworkResponse?
    var lastRecordedError: NetworkError?
    var publisherDidFinish: Bool?
    var fixtureUrlRequest: URLRequest!
    var fixtureNetworkRequest: NetworkRequest!
    var cancellables: Set<AnyCancellable>!
    var sut: NetworkModule!

    override func setUp() {
        fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/welcome")!)
        fixtureNetworkRequest = FakeGetNetworkRequest()
        lastRecordedResponse = nil
        lastRecordedError = nil
        publisherDidFinish = nil
        cancellables = []

        //  Discussion: Although we're using `FakeNetworkModule` as SUT, we aim to test only the methods...
        //  ... added in the default implementation of the `NetworkModule` protocol.
        sut = FakeNetworkModule()
    }

    // MARK: - Handling UrlRequest success:

    func test_whenExecutingUrlRequestWithSuccess_shouldEmitEventWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: Data(), code: 200)

        //  when:
        perform(urlRequest: fixtureUrlRequest)
        fakeNetworkModule.simulateUrlRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedResponse, fixtureNetworkResponse, "Should return a proper response")
        XCTAssertEqual(publisherDidFinish, true, "Should finish publishing after request completion")
    }

    // MARK: - Handling UrlRequest failure:

    func test_whenExecutingUrlRequestWithError_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkError = NetworkError.notFound

        //  when:
        perform(urlRequest: fixtureUrlRequest)
        fakeNetworkModule.simulateUrlRequestFailure(error: fixtureNetworkError)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedResponse, "Should NOT return a response")
    }

    // MARK: - Handling NetworkRequest success:

    func test_whenExecutingNetworkRequestWithSuccess_shouldEmitEventWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: Data(), code: 200)

        //  when:
        perform(request: fixtureNetworkRequest)
        fakeNetworkModule.simulateNetworkRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedResponse, fixtureNetworkResponse, "Should return a proper response")
        XCTAssertEqual(publisherDidFinish, true, "Should finish publishing after request completion")
    }

    // MARK: - Handling NetworkRequest failure:

    func test_whenExecutingNetworkRequestWithError_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkError = NetworkError.noResponseData

        //  when:
        perform(request: fixtureNetworkRequest)
        fakeNetworkModule.simulateNetworkRequestFailure(error: fixtureNetworkError)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedResponse, "Should NOT return a response")
    }
}

extension NetworkModuleReactiveAPITests {

    var fakeNetworkModule: FakeNetworkModule {
        sut as! FakeNetworkModule
    }

    func perform(urlRequest: URLRequest) {
        sut.perform(urlRequest: urlRequest)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.publisherDidFinish = true
                    case let .failure(error):
                        self.lastRecordedError = error
                    }
                },
                receiveValue: { response in
                    self.lastRecordedResponse = response
                })
            .store(in: &cancellables)
    }

    func perform(request: NetworkRequest) {
        sut.perform(request: request)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.publisherDidFinish = true
                    case let .failure(error):
                        self.lastRecordedError = error
                    }
                },
                receiveValue: { response in
                    self.lastRecordedResponse = response
                })
            .store(in: &cancellables)
    }

    func makeNetworkResponse(data: Data?, code: Int) -> NetworkResponse {
        NetworkResponse(
            data: data,
            networkResponse: HTTPURLResponse(
                url: URL(string: "https://ng.com")!,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
        )
    }
}
