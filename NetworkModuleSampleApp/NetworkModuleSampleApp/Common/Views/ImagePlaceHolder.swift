//
//  ImagePlaceHolder.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct ImagePlaceHolder: View {
    var body: some View {
        Image("mock_episode_image")
            .resizable()
            .scaledToFill()
            .frame(width: 140, height: 180)
            .clipped()
            .padding(.bottom, 20)
            .padding(.leading, 10)
    }
}

struct ImagePlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceHolder()
    }
}
