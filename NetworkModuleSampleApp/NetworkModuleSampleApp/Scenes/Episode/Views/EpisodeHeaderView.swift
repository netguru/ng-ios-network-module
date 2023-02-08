//
//  EpisodeHeaderView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeHeaderView: View {
    let episode: EpisodeHeaderViewModel

    var body: some View {
        ZStack {
            Color("episode_background")
            VStack {
                AsyncImage(
                    url: URL(string: episode.imageURL),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    },
                    placeholder: {
                        ImagePlaceHolder()
                    }
                )

                VStack(alignment: .leading) {
                    Text(episode.name)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 20)
                    Text("Information")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    Divider()
                        .background(.white)
                        .frame(height: 1)

                    Text("Director: \(episode.director)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Text("Writer: \(episode.writer)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Text("Air Date: \(episode.airDate ?? "---")")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    Spacer()
                }
                .padding(.leading, 20)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct EpisodeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeHeaderView(episode: PreviewMocks.mockEpisodeHeaderModel)
    }
}
