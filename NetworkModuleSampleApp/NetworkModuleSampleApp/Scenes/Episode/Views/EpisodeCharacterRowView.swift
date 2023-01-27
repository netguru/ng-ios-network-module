//
//  EpisodeCharacterRowView.swift
//  Netguru iOS Network Module
//

import SwiftUI

struct EpisodeCharacterRowView: View {
    let character: EpisodeCharacterRowModel
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.imageURL ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 150)
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                ImagePlaceHolder()
            }
            Text("\(character.name ?? "")")
                .font(.headline)
                .fontWeight(.thin)
                .foregroundColor(.white)
                .padding(.leading, 20)
        }.padding(.bottom, 20)
    }
}

struct EpisodeCharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCharacterRowView(character: PreviewMocks.mockCharacterRowModel)
    }
}
