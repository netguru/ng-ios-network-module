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
            .frame(width: size.width, height: size.height)
            .scaledToFill()
            .cornerRadius(cornerRadius)
    }
}

extension View {

    func episodeMiniature(
        size: CGSize = CGSize(width: 100, height: 100),
        cornerRadius: CGFloat = 5
    ) -> some View {
        modifier(EpisodeMiniatureImageModifier(size: size, cornerRadius: cornerRadius))
    }
}
