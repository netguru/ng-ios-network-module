//
//  ViewStyles.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeMiniatureImageModifier: ViewModifier {
    let size: CGSize
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .clipped()
            .cornerRadius(cornerRadius)
    }
}

extension View {

    func episodeMiniature(
        size: CGSize = Constants.Miniature.size,
        cornerRadius: CGFloat = Constants.Miniature.cornerRadius
    ) -> some View {
        modifier(EpisodeMiniatureImageModifier(size: size, cornerRadius: cornerRadius))
    }
}
