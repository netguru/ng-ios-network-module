//
//  EpisodeListScene.swift
//  NetworkModuleSampleApp


import SwiftUI

struct EpisodeListScene<T: EpisodeListViewModel>: View {
    @StateObject var viewModel: T
    
    var body: some View {
        ZStack {
            Color("episodeBG")
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    ForEach(viewModel.episodeList.episodes) { episode in
                        EpisodeListRowView(episode: episode, requestType: viewModel.requestType)
                    }
                }
                
                .padding()
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("Final Space Episode Lists")
                    .toolbar {
                        Button {
                           //TODO: Refresh Action
                        } label: {
                            Image(systemName: "goforward")
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
    }
}


struct EpisodeListScene_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EpisodeListViewModel(requestType: .classic)
        EpisodeListScene<EpisodeListViewModel>(viewModel: viewModel)
    }
}
