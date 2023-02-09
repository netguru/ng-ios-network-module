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

extension Text {
    func singleLineScaledToFit() -> some View {
        modifier(SingleLineScaledToFitTextModifier())
    }
}
