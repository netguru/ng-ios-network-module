//
//  EpisodeListScene.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeListScene<T: EpisodeListViewModel>: View {
    @StateObject var viewModel: T

    var body: some View {
        ZStack {
            Color("episodeBG")
                .ignoresSafeArea()
            if isDataLoading {
                Text("Loading....")
            }

            if let error = isErrorLoaded {
                Text("Error: \(error)")
            }

            if let episodes = loadedEpisodeList {
                VStack {
                    ScrollView {
                        ForEach(episodes) { episode in
                            EpisodeListRowView(episode: episode, requestType: viewModel.requestType)
                        }
                    }
                    .padding()
                    .scrollIndicators(.hidden)
                }
            }
        }
        .navigationTitle("Final Space Episode Lists")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("episodeBG"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

private extension EpisodeListScene {
    var isDataLoading: Bool {
        viewModel.viewState == .loading
    }

    var loadedEpisodeList: [EpisodeRowModel]? {
        switch viewModel.viewState {
        case let .loaded(episodeList):
            return episodeList.episodes.map(EpisodeRowModel.init)
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
        let viewModel = EpisodeListViewModel(requestType: .classic)
        EpisodeListScene<EpisodeListViewModel>(viewModel: viewModel)
    }
}
