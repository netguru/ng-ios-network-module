//
//  EpisodeListRowView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeListRowView: View {
    let data: EpisodeViewData

    var body: some View {
        ZStack(alignment: .bottom) {

            Color("light_gray")
                .frame(height: 135)
                .padding(.bottom, 0)
                .cornerRadius(20)

            NavigationLink(value: data.navigationRoute) {
                HStack(alignment: .bottom) {
                    AsyncImage(
                        url: data.imageURL,
                        content: { image in
                            image
                                .resizable()
                                .episodeMiniature()
                                .padding(15)
                        },
                        placeholder: {
                            ImagePlaceHolder(
                                size: Constants.Miniature.size,
                                thickness: Constants.Miniature.progressIndicatorThickness
                            )
                            .padding(15)
                        }
                    )

                    VStack(alignment: .leading) {
                        Text(data.name)
                            .foregroundColor(Color("white"))
                            .font(.title2)
                            .bold()
                            .singleLineScaledToFit()
                            .padding(.bottom, 5)
                        Text("Director: \(data.director)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                        Text("Writer: \(data.writer)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                        Text("Air Date: \(data.airDate)")
                            .foregroundColor(.yellow)
                            .font(.subheadline)
                            .singleLineScaledToFit()
                    }
                    .padding(.bottom, 20)

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
        EpisodeListRowView(data: PreviewMocks.mockEpisodeViewData)
            .previewLayout(.fixed(width: 400, height: 180))
    }
}
