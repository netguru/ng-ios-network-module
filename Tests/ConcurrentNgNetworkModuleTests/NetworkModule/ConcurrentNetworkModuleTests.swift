//
//  ConcurrentNetworkModuleTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest
import Combine

@testable import NgNetworkModuleCore
@testable import ConcurrentNgNetworkModule

final class ConcurrentNetworkModuleTests: XCTestCase {
    var lastRecordedResponse: NetworkResponse?
    var lastRecordedDecodedResponse: Decodable?
    var lastRecordedError: NetworkError?
    var fixtureUrlRequest: URLRequest!
    var fixtureNetworkRequest: NetworkRequest!
    var sut: NetworkModule!

    override func setUp() {
        fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/welcome")!)
        fixtureNetworkRequest = FakeDeleteNetworkRequest()
        lastRecordedResponse = nil
        lastRecordedDecodedResponse = nil
        lastRecordedError = nil

        //  Discussion: Although we're using `FakeNetworkModule` as SUT, we aim to test only the methods...
        //  ... added in the default implementation of the `NetworkModule` protocol.
        sut = FakeNetworkModule()
    }

    // MARK: - Handling successful UrlRequest:

    func test_whenExecutingUrlRequestWithSuccess_shouldReturnResponse() async {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: Data(), code: 200)
        fakeNetworkModule.simulatedNetworkResponse = fixtureNetworkResponse

        //  when:
        try? await perform(urlRequest: fixtureUrlRequest)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedResponse, fixtureNetworkResponse, "Should return a proper response")
    }

    func test_whenExecutingUrlRequestWithSuccess_andDecodingResponse_shouldReturnDecodedResponse() async {
        //  given:
        let fakeResponse = FakeEmptyNetworkResponse()
        let encodedResponse = try? JSONEncoder().encode(fakeResponse)
        let fixtureNetworkResponse = makeNetworkResponse(data: encodedResponse, code: 200)
        fakeNetworkModule.simulatedNetworkResponse = fixtureNetworkResponse

        //  when:
        try? await performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeEmptyNetworkResponse.self)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeEmptyNetworkResponse, fakeResponse, "Should return a proper response")
    }

    // MARK: - Handling failed UrlRequest:

    func test_whenExecutingUrlRequestWithError_shouldThrowError() async {
        //  given:
        let fixtureNetworkError = NetworkError.notFound
        fakeNetworkModule.simulatedNetworkError = fixtureNetworkError

        //  when:
        try? await perform(urlRequest: fixtureUrlRequest)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedResponse, "Should NOT return a response")
    }

    func test_whenExecutingUrlRequestWithError_withIntentionToDecodeResponse_shouldThrowError() async {
        //  given:
        let fixtureNetworkError = NetworkError.notFound
        fakeNetworkModule.simulatedNetworkError = fixtureNetworkError

        //  when:
        try? await performAndDecode(urlRequest: fixtureUrlRequest, responseType: FakeEmptyNetworkResponse.self)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }

    // MARK: - Handling successful NetworkRequest:

    func test_whenExecutingNetworkRequestWithSuccess_shouldReturnResponse() async {
        //  given:
        let fixtureNetworkResponse = makeNetworkResponse(data: Data(), code: 200)
        fakeNetworkModule.simulatedNetworkResponse = fixtureNetworkResponse

        //  when:
        try? await perform(request: fixtureNetworkRequest)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedResponse, fixtureNetworkResponse, "Should return a proper response")
    }

    func test_whenExecutingNetworkRequestWithSuccess_andDecodingResponse_shouldReturnDecodedResponse() async {
        //  given:
        let fakeResponse = FakeEmptyNetworkResponse()
        let encodedResponse = try? JSONEncoder().encode(fakeResponse)
        let fixtureNetworkResponse = makeNetworkResponse(data: encodedResponse, code: 200)
        fakeNetworkModule.simulatedNetworkResponse = fixtureNetworkResponse

        //  when:
        try? await performAndDecode(request: fixtureNetworkRequest, responseType: FakeEmptyNetworkResponse.self)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedDecodedResponse as? FakeEmptyNetworkResponse, fakeResponse, "Should return a proper response")
    }

    // MARK: - Handling failed NetworkRequest:

    func test_whenExecutingNetworkRequestWithError_shouldThrowError() async {
        //  given:
        let fixtureNetworkError = NetworkError.notFound
        fakeNetworkModule.simulatedNetworkError = fixtureNetworkError

        //  when:
        try? await perform(request: fixtureNetworkRequest)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedResponse, "Should NOT return a response")
    }

    func test_whenExecutingNetworkRequestWithError_withIntentionToDecodeResponse_shouldThrowError() async {
        //  given:
        let fixtureNetworkError = NetworkError.notFound
        fakeNetworkModule.simulatedNetworkError = fixtureNetworkError

        //  when:
        try? await performAndDecode(request: fixtureNetworkRequest, responseType: FakeEmptyNetworkResponse.self)

        //  then:
        XCTAssertEqual(lastRecordedError, fixtureNetworkError, "Should return an error")
        XCTAssertNil(lastRecordedDecodedResponse, "Should NOT return a response")
    }
}

extension ConcurrentNetworkModuleTests {

    struct FakeDeleteNetworkRequest: NetworkRequest {
        let path = "/user/1"
        let method = NetworkRequestType.delete
    }

    struct FakeEmptyNetworkResponse: Codable, Equatable {}

    var fakeNetworkModule: FakeNetworkModule {
        sut as! FakeNetworkModule
    }

    func perform(urlRequest: URLRequest) async throws {
        do {
            lastRecordedResponse = try await sut.perform(urlRequest: urlRequest)
        } catch {
            lastRecordedError = error as? NetworkError
        }
    }

    func performAndDecode<T: Decodable>(urlRequest: URLRequest, responseType: T.Type) async throws {
        do {
            lastRecordedDecodedResponse = try await sut.performAndDecode(urlRequest: urlRequest, responseType: responseType)
        } catch {
            lastRecordedError = error as? NetworkError
        }
    }

    func perform(request: NetworkRequest) async throws {
        do {
            lastRecordedResponse = try await sut.perform(request: request)
        } catch {
            lastRecordedError = error as? NetworkError
        }
    }

    func performAndDecode<T: Decodable>(request: NetworkRequest, responseType: T.Type) async throws {
        do {
            lastRecordedDecodedResponse = try await sut.performAndDecode(request: request, responseType: responseType)
        } catch {
            lastRecordedError = error as? NetworkError
        }
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
