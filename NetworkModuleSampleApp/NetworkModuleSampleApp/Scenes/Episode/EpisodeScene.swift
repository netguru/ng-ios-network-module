//
//  EpisodeScene.swift
//  NetworkModuleSampleApp

import SwiftUI

struct EpisodeScene<T: EpisodeViewModel>: View {
    @StateObject var viewModel: T
    
    var body: some View {
      EpisodeMainView(viewModel: viewModel)
    }
}

struct EpisodeScene_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = EpisodeViewModel(requestType: .classic, episodeId: "1")
        EpisodeScene<EpisodeViewModel>(viewModel: mockViewModel)
    }
}
