//
//  EpisodeScene.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeScene<T: EpisodeViewModelProtocol>: View {
    @StateObject var viewModel: T

    var body: some View {
        ZStack {
            Color("episode_background")

            ScrollView {
                VStack(alignment: .leading) {

                    EpisodeHeaderView(data: episodeHeaderData)

                    Spacer()

                    Text("Characters")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding(.leading, 10)

                    if let error = isErrorLoaded {
                        Spacer()
                        Text("Error: \(error)")
                            .networkError()
                            .padding(.horizontal, 10)
                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(charactersData) { data in
                                // TODO: Add navigation to a Character Scene:
                                EpisodeCharacterRowView(data: data)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 10))
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(episodeHeaderData.name)
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

private extension EpisodeScene {

    var episodeHeaderData: EpisodeViewData {
        switch viewModel.viewState {
        case let .loading(episodeModel), let .error(episodeModel, _), let .loaded(episodeModel, _):
            return EpisodeViewData(episode: episodeModel, selectedNetworkApi: viewModel.selectedNetworkingAPI)
        }
    }

    var isDataLoading: Bool {
        switch viewModel.viewState {
        case .loading:
            return true
        default:
            return false
        }
    }

    var charactersData: [CharacterViewData] {
        switch viewModel.viewState {
        case let .loaded(_, characters):
            return characters.map(CharacterViewData.init)
        default:
            return []
        }
    }

    var isErrorLoaded: String? {
        if case let .error(_, error) = viewModel.viewState {
            return error.localizedDescription
        }
        return nil
    }
}

struct EpisodeSceneView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = PreviewMocks.EpisodeViewModelStub()
        mockViewModel.viewState = .loaded(PreviewMocks.mockEpisodeModel, [PreviewMocks.mockCharacterModel])
        return EpisodeScene<PreviewMocks.EpisodeViewModelStub>(viewModel: mockViewModel)
    }
}
