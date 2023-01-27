//
//  NetworkModuleSupplementaryReactiveAPITests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest
import Combine

@testable import NgNetworkModuleCore
@testable import ReactiveNgNetworkModule

final class NetworkModuleSupplementaryReactiveAPITests: XCTestCase {
    var lastRecordedDecodedResponse: Decodable?
    var lastRecordedError: NetworkError?
    var publisherDidFinish: Bool?
    var fixtureUrlRequest: URLRequest!
    var fixtureNetworkRequest: NetworkRequest!
    var cancellables: Set<AnyCancellable>!
    var sut: NetworkModule!

    override func setUp() {
        fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/welcome")!)
        fixtureNetworkRequest = FakeGetNetworkRequest()
        lastRecordedError = nil
        lastRecordedDecodedResponse = nil
        publisherDidFinish = nil
        cancellables = []

        //  Discussion: Although we're using `FakeNetworkModule` as SUT, we aim to test only the methods...
        //  ... added in the default implementation of the `NetworkModule` protocol.
        sut = FakeNetworkModule()
    }

    // MARK: - Handling UrlRequest success:

    func test_whenExecutingUrlRequestWithSuccess_shouldDecodeResponse_andEmitEventWithPublisher() {
        //  given:
        let fakeResponse = FakeNetworkResponse(foo: "bar", bar: 1)
        let encodedResponse = try? JSONEncoder().encode(fakeResponse)
        let fixtureNetworkResponse = makeNetworkResponse(data: encodedResponse, code: 200)

        //  when:
        performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateUrlRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeNetworkResponse, fakeResponse, "Should return a proper response")
        XCTAssertEqual(publisherDidFinish, true, "Should finish publishing after request completion")
    }

    // MARK: - Handling UrlRequest failures:

    func test_whenExecutingUrlRequestWithNetworkError_shouldFailToDecodeResponse_andEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkError = NetworkError.notFound

        //  when:
        performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateUrlRequestFailure(error: fixtureNetworkError)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    func test_whenExecutingUrlRequest_andEmptyResponseIsReceived_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: nil, code: 200)

        //  when:
        performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateUrlRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.noResponseData, "Should return proper error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    func test_whenExecutingUrlRequest_andResponseParsingFailed_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: "nil".encoded(), code: 200)

        //  when:
        performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateUrlRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.responseParsingFailed, "Should return proper error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    // MARK: - Handling NetworkRequest success:

    func test_whenExecutingNetworkRequestWithSuccess_shouldDecodeResponse_andEmitEventWithPublisher() {
        //  given:
        let fakeResponse = FakeNetworkResponse(foo: "bar", bar: 1)
        let encodedResponse = try? JSONEncoder().encode(fakeResponse)
        let fixtureNetworkResponse = makeNetworkResponse(data: encodedResponse, code: 200)

        //  when:
        performAndDecode(request: fixtureNetworkRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateNetworkRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeNetworkResponse, fakeResponse, "Should return a proper response")
        XCTAssertEqual(publisherDidFinish, true, "Should finish publishing after request completion")
    }

    // MARK: - Handling NetworkRequest failures:

    func test_whenExecutingNetworkRequestWithNetworkError_shouldFailToDecodeResponse_andEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkError = NetworkError.notFound

        //  when:
        performAndDecode(request: fixtureNetworkRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateNetworkRequestFailure(error: fixtureNetworkError)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    func test_whenExecutingNetworkRequest_andEmptyResponseIsReceived_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: nil, code: 200)

        //  when:
        performAndDecode(request: fixtureNetworkRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateNetworkRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.noResponseData, "Should return proper error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    func test_whenExecutingNetworkRequest_andResponseParsingFailed_shouldEmitFailureWithPublisher() {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: "nil".encoded(), code: 200)

        //  when:
        performAndDecode(request: fixtureNetworkRequest, responseType: FakeNetworkResponse.self)
        fakeNetworkModule.simulateNetworkRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertEqual(lastRecordedError, NetworkError.responseParsingFailed, "Should return proper error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }
}

extension NetworkModuleSupplementaryReactiveAPITests {

    var fakeNetworkModule: FakeNetworkModule {
        sut as! FakeNetworkModule
    }

    func performAndDecode<T: Decodable>(urlRequest: URLRequest, responseType: T.Type) {
        sut.performAndDecode(urlRequest: urlRequest, responseType: responseType)
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
                    self.lastRecordedDecodedResponse = response
                })
            .store(in: &cancellables)
    }

    func performAndDecode<T: Decodable>(request: NetworkRequest, responseType: T.Type) {
        sut.performAndDecode(request: request, responseType: responseType)
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
                    self.lastRecordedDecodedResponse = response
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
