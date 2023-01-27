//
//  EpisodeMainView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeMainView<T: EpisodeViewModel>: View {
    @StateObject var viewModel: T
    var body: some View {
        ZStack {
            Color("episodeBG")

            if isDataLoading {
                Text("Loading....")
            }

            if let error = isErrorLoaded {
                Text("Error: \(error)")
            }

            VStack(alignment: .leading) {
                if let episode = loadedEpisode.episode {
                    EpisodeHeaderView(episode: episode)
                    Spacer()
                }

                if let characters = loadedEpisode.character {
                    Text("Characters")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding(.leading, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(characters) { character in
                                NavigationLink(value: Route.character) {
                                    EpisodeCharacterRowView(character: character)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("\(loadedEpisode.episode?.name ?? "")")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color("episodeBG"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .edgesIgnoringSafeArea(.bottom)
    }
}

private extension EpisodeMainView {
    var isDataLoading: Bool {
        viewModel.viewState == .loading
    }

    var loadedEpisode: (episode: EpisodeModel?,
                        character: [EpisodeCharacterRowModel]?) {
        switch viewModel.viewState {
        case let .loadedEpisode(episode, characters):
            let characterRow = characters.map(EpisodeCharacterRowModel.init)
            return (episode, characterRow)
        default:
            return (nil, nil)
        }
    }

    var isErrorLoaded: String? {
        if case let .error(error) = viewModel.viewState {
            return error.localizedDescription
        }
        return nil
    }
}

struct EpisodeMainView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = EpisodeViewModel(requestType: .classic, episodeId: "1")
        EpisodeMainView(viewModel: mockViewModel)
    }
}
