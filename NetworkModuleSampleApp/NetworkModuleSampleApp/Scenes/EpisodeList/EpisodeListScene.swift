//
//  EpisodeListScene.swift
//  Netguru iOS Network Module
//

import SwiftUI
import NgNetworkModuleCore

struct EpisodeListScene<T: EpisodeListViewModelProtocol>: View {
    @StateObject var viewModel: T

    var body: some View {
        ZStack {
            Color("episode_background")
                .ignoresSafeArea()

            if isDataLoading {
                CircularProgressView(thickness: 10)
                    .frame(width: 100, height: 100)
            }

            if let error = isErrorLoaded {
                Text("Error: \(error)")
                    .networkError()
            }

            if let episodes = loadedEpisodeList {
                VStack {
                    ScrollView {
                        ForEach(episodes) {
                            EpisodeListRowView(data: $0)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
                    .scrollIndicators(.hidden)
                }
            }
        }
        .navigationTitle("Final Space Episode Lists")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("episode_background"),
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            viewModel.fetchData()
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

private extension EpisodeListScene {
    var isDataLoading: Bool {
        viewModel.viewState == .loading
    }

    var loadedEpisodeList: [EpisodeViewData]? {
        switch viewModel.viewState {
        case let .loaded(episodeList):
            return episodeList.map {
                EpisodeViewData(episode: $0, selectedNetworkApi: viewModel.selectedNetworkApi)
            }
        default:
            return nil
        }
    }

    var isErrorLoaded: String? {
        if case let .error(error) = viewModel.viewState {
            return error.localizedDescription
        }
        return nil
    }
}

struct EpisodeListScene_Previews: PreviewProvider {

    static var previews: some View {
        let viewModel = PreviewMocks.EpisodeListViewModelStub()
        viewModel.viewState = .loaded([PreviewMocks.mockEpisodeModel, PreviewMocks.mockEpisodeModel])
        return EpisodeListScene<PreviewMocks.EpisodeListViewModelStub>(viewModel: viewModel)
    }
}
