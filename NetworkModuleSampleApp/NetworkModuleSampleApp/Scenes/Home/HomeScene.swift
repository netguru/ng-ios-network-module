//
//  HomeScene.swift
//  Netguru iOS Network Module
//

import SwiftUI
import NgNetworkModuleCore

struct HomeScene: View {
    /// Pre-configured HomeRow Types and Datas
    private let methodTypes: [HomeRowType] = [.classic, .combine, .asyncawait]

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Welcome to NG Network Module")
                    .font(.title)
                    .bold()

                ForEach(methodTypes, id: \.self) { rowType in
                    HomeRowView(rowType: rowType)
                        .padding([.leading, .trailing], 10)
                }
                Spacer()
                Text("Copyright Netguru 2023")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .navigationDestination(for: Route.self) { routes in
                let baseUrl = URL(string: "https://finalspaceapi.com/api")!
                let requestBuilder = DefaultRequestBuilder(baseURL: baseUrl)
                let networkModule = DefaultNetworkModule(requestBuilder: requestBuilder)

                switch routes {
                case .home:
                    HomeScene()
                case let .episodeList(requestType):
                    let viewModel = EpisodeListViewModel(
                        requestType: requestType,
                        networkModule: networkModule
                    )
                    EpisodeListScene<EpisodeListViewModel>(viewModel: viewModel)
                case let .episode(requestType, episode):
                    let viewModel = EpisodeViewModel(
                        selectedNetworkingAPI: requestType,
                        episode: episode,
                        networkModule: networkModule
                    )
                    EpisodeScene<EpisodeViewModel>(viewModel: viewModel)
                }
            }
        }
    }
}

struct HomeScene_Previews: PreviewProvider {
    static var previews: some View {
        HomeScene()
    }
}
