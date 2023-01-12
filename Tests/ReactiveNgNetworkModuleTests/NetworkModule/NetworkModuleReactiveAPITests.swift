//
//  NetworkModuleReactiveAPITests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest
import Combine

@testable import NgNetworkModule
@testable import ReactiveNgNetworkModule

final class NetworkModuleReactiveAPITests: XCTestCase {
    var lastRecordedResponse: NetworkResponse?
    var lastRecordedDecodedResponse: Decodable?
    var lastRecordedError: NetworkError?
    var publisherDidFinish: Bool?
    var fixtureUrlRequest: URLRequest!
    var cancellables: Set<AnyCancellable>!
    var sut: NetworkModule!

    override func setUp() {
        fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/welcome")!)
        lastRecordedResponse = nil
        lastRecordedError = nil
        lastRecordedDecodedResponse = nil
        publisherDidFinish = nil
        cancellables = []

        //  Discussion: Although we're using `FakeNetworkModule` as SUT, we aim to test only the methods...
        //  ... added in the default implementation of the `NetworkModule` protocol.
        sut = FakeNetworkModule()
    }

    func testBasicSetup() {
        //  given:
        let fixtureData = Data()
        let fixtureNetworkResponse = NetworkResponse(
            data: fixtureData,
            networkResponse: HTTPURLResponse(
                url: URL(string: "https://ng.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )

        //  when:
        perform(urlRequest: fixtureUrlRequest)
        fakeNetworkModule.simulateUrlRequestSuccess(response: fixtureNetworkResponse)

        //  then:
        XCTAssertNil(lastRecordedError, "Should NOT return an error")
        XCTAssertEqual(lastRecordedResponse, fixtureNetworkResponse, "Should return a proper response")
        XCTAssertEqual(publisherDidFinish, true, "Should finish publishing after request completion")
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
}
