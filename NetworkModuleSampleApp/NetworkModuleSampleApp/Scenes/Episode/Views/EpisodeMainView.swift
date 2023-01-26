//
//  EpisodeMainView.swift
//  NetworkModuleSampleApp
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
                if let episode = loadedEpisode {
                    EpisodeHeaderView(episode: episode)
                    Spacer()
                }
                
                if let characters = loadedCharacter {
                    Text("Characters")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding(.leading, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false){
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
        .navigationTitle("\(loadedEpisode?.name ?? "")")
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
    
    var loadedEpisode: EpisodeModel? {
        switch viewModel.viewState {
        case .loadedEpisode(let episode):
            return episode
        default:
            return nil
        }
    }
    
    var loadedCharacter: [EpisodeCharacterRowModel]? {
        switch viewModel.viewState {
        case .loadedCharacters(let characters):
            return characters.map(EpisodeCharacterRowModel.init)
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

struct EpisodeMainView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = EpisodeViewModel(requestType: .classic, episodeId: "1")
        EpisodeMainView(viewModel: mockViewModel)
    }
}
