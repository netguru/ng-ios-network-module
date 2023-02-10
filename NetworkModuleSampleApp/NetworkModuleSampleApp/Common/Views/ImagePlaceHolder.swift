//
//  ImagePlaceHolder.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct ImagePlaceHolder: View {
    let size: CGSize
    let thickness: CGFloat

    var body: some View {
        ZStack {
            Color("episode_background")
                .episodeMiniature(size: size, cornerRadius: floor(size.width / 10))

            CircularProgressView(thickness: thickness)
                .frame(width: size.width / 3, height: size.height / 3)
        }
    }
}

struct ImagePlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceHolder(
            size: .init(width: 300, height: 300),
            thickness: 10
        )
    }
}
