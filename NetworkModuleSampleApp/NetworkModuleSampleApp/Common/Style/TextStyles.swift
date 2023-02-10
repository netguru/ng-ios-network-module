//
//  TextStyles.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct SingleLineScaledToFitTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct NetworkErrorTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .lineLimit(3)
            .font(.body)
            .foregroundColor(Color("white"))
            .bold()
    }
}

extension Text {
    func singleLineScaledToFit() -> some View {
        modifier(SingleLineScaledToFitTextModifier())
    }

    func networkError() -> some View {
        modifier(NetworkErrorTextModifier())
    }
}
