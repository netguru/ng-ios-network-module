//
//  ImagePlaceHolder.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct ImagePlaceHolder: View {
    var body: some View {
        ZStack {
            Color("episode_background")
                .episodeMiniature()

            CircularProgressView(thickness: 4)
                .frame(width: 40, height: 40)
        }
    }
}

struct ImagePlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceHolder()
    }
}
