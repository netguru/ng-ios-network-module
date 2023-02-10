//
//  EpisodeCharacterRowView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeCharacterRowView: View {
    let data: CharacterViewData

    var body: some View {
        VStack {
            AsyncImage(
                url: data.imageURL,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250)
                },
                placeholder: {
                    ImagePlaceHolder(
                        size: .init(width: 250, height: 250),
                        thickness: 10
                    )
                }
            )

            Text(data.name)
                .font(.headline)
                .fontWeight(.thin)
                .foregroundColor(.white)
                .padding(.leading, 20)
        }
    }
}

struct EpisodeCharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCharacterRowView(data: PreviewMocks.mockCharacterRowModel)
    }
}
