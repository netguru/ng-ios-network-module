//
//  EpisodeListRowView.swift
//  NetworkModuleSampleApp


import SwiftUI

struct EpisodeListRowView: View {
    var episode: EpisodeRowModel
    var requestType: NetworkRequestType
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("light_gray")
                .frame(height: 140)
                .padding(.bottom, 0)
                .cornerRadius(20)
            
            HStack(alignment: .bottom) {
                
                AsyncImage(url: URL(string: episode.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 140, height: 180)
                        .scaledToFill()
                        .clipped()
                        .padding(.bottom, 20)
                        .padding(.leading, 10)
                } placeholder: {
                    ImagePlaceHolder()
                }
                
                VStack(alignment: .leading) {
                    Text("\(episode.name ?? "")")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 20)
                    Text("Director: \(episode.director ?? "")")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Text("Writer: \(episode.writer ?? "")")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Text("Air Date: \(episode.airDate ?? "")")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                    
                }.padding(.bottom, 20)
                    .padding(.leading, 10)
                
                Spacer()
                
                NavigationLink(value: Route.episode(requestType: requestType, episodeId: episode.id ?? "")) {
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
