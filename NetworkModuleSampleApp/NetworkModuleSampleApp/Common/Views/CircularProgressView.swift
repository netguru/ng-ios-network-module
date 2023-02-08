//
//  CircularProgressView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct CircularProgressView: View {
    let thickness: CGFloat
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {

            // MARK: Background circle

            Circle()
                .stroke(
                    Color("red").opacity(0.5),
                    lineWidth: thickness
                )

            // MARK: Foreground circle fragment

            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(
                    Color("red").opacity(1),
                    style: .init(lineWidth: thickness, lineCap: .round)
                )
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(
                        .linear(duration: 1)
                            .speed(1)
                            .repeatForever(autoreverses: false)
                    ) {
                        rotation = 360
                    }
                }
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(thickness: 30)
            .padding(50)
    }
}
