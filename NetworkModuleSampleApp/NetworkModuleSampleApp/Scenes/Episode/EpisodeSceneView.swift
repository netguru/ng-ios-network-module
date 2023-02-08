//
//  EpisodeSceneView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeSceneView<T: EpisodeViewModel>: View {
    @StateObject var viewModel: T

    var body: some View {
        EpisodeMainView(viewModel: viewModel)
    }
}

struct EpisodeSceneView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = EpisodeViewModel(requestType: .classic, episodeId: 1)
        EpisodeSceneView<EpisodeViewModel>(viewModel: mockViewModel)
    }
}
