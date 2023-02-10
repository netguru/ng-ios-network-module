//
//  EpisodeHeaderView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeHeaderView: View {
    let data: EpisodeViewData

    var body: some View {
        ZStack {
            Color("episode_background")
            VStack {
                ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                    AsyncImage(
                        url: data.imageURL,
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        },
                        placeholder: {
                            ImagePlaceHolder(size: .init(width: 200, height: 200), thickness: 8)
                        }
                    )

                    Text(data.name)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .singleLineScaledToFit()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                }

                VStack(alignment: .leading) {
                    Text("Information")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    Divider()
                        .background(.white)
                        .frame(height: 1)

                    Text("Director: \(data.director)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Text("Writer: \(data.writer)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Text("Air Date: \(data.airDate)")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Spacer()
                }
                .padding()
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct EpisodeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeHeaderView(data: PreviewMocks.mockEpisodeViewData)
    }
}
