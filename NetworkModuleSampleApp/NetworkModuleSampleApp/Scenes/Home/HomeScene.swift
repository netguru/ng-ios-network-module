//
//  HomeScene.swift
//  Netguru iOS Network Module
//

import SwiftUI

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
                switch routes {
                case .home:
                    HomeScene()
                case let .episodeList(requestType):
                    let viewModel = EpisodeListViewModel(requestType: requestType)
                    EpisodeListScene<EpisodeListViewModel>(viewModel: viewModel)
                case let .episode(requestType, episodeId):
                    let viewModel = EpisodeViewModel(requestType: requestType, episodeId: episodeId)
                    EpisodeSceneView<EpisodeViewModel>(viewModel: viewModel)
                case .character:
                    CharacterScene()
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
