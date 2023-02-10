//
//  HomeRowView.swift
//  Netguru iOS Network Module
//

import SwiftUI
struct HomeRowView: View {
    let rowType: HomeRowType

    var body: some View {
        NavigationLink(value: Route.episodeList(requestType: rowType.viewModelType)) {
            HStack {
                Image(systemName: rowType.rowImageName)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(rowType.rowImageColor)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)

                VStack(alignment: .leading) {
                    Text(rowType.rowTitle)
                        .fontWeight(.semibold)
                        .font(.headline)
                    Text(rowType.rowSubTitle)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                .padding(.leading, 15)

                Spacer()

                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .frame(maxHeight: .infinity)
                    .frame(width: 30)
                    .background(rowType.rowImageColor)
                    .cornerRadius(5)
                    .padding([.leading, .trailing], 10)
            }.frame(height: 100)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRowView(rowType: .combine)
    }
}
