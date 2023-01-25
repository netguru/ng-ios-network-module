//
//  EpisodeScene.swift
//  NetworkModuleSampleApp

import SwiftUI

struct EpisodeScene<T: EpisodeViewModel>: View {
    @StateObject var viewModel: T
    
    var body: some View {
        ZStack {
            Color("episodeBG")
            VStack(alignment: .leading) {
                EpisodeHeaderView(episode: viewModel.episode)
                Spacer()
                Text("Characters")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .padding(.leading, 10)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(value: Route.character) {
                                EpisodeCharacterRowView(character: character)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("\(viewModel.episode.name ?? "")")
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        
        .toolbarBackground(
            Color("episodeBG"),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct EpisodeScene_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = EpisodeViewModel(requestType: .classic, episodeId: "1")
        EpisodeScene<EpisodeViewModel>(viewModel: mockViewModel)
    }
}
