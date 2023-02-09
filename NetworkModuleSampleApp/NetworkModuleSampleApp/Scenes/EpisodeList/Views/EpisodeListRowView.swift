//
//  EpisodeListRowView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeListRowView: View {
    let episode: EpisodeRowModel
    let requestType: NetworkModuleApiType

    var body: some View {
        ZStack(alignment: .bottom) {

            Color("light_gray")
                .frame(height: 135)
                .padding(.bottom, 0)
                .cornerRadius(20)

            NavigationLink(value: Route.episode(requestType: requestType, episodeId: episode.id)) {
                HStack(alignment: .bottom) {
                    AsyncImage(
                        url: URL(string: episode.secureImageURL),
                        content: { image in
                            image
                                .resizable()
                                .episodeMiniature()
                                .padding(15)
                        },
                        placeholder: {
                            ImagePlaceHolder()
                                .padding(15)
                        }
                    )

                    VStack(alignment: .leading) {
                        Text(episode.name)
                            .foregroundColor(Color("white"))
                            .font(.title2)
                            .bold()
                            .singleLineScaledToFit()
                            .padding(.bottom, 20)
                        Text("Director: \(episode.director)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                        Text("Writer: \(episode.writer)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                        Text("Air Date: \(episode.airDate ?? "---")")
                            .foregroundColor(.yellow)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                    }
                    .padding(.bottom, 20)
                    .padding(.leading, 10)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.white)
                        .padding(.bottom, 70)
                        .padding(.trailing, 20)
                }
            }
        }
    }
}

struct EpisodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListRowView(episode: PreviewMocks.mockEpisodeRowModel, requestType: .classic)
            .previewLayout(.fixed(width: 400, height: 180))
    }
}
