//
//  SearchResultRowBottomSection.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import SwiftUI

struct SearchResultRowBottomSection: View {

    let viewModel: SearchResultRowViewViewModel

    private func rowBottomSection(geometry: GeometryProxy) -> some View {
        let spacing: Double = 8
        return HStack(spacing: 0) {
            ForEach(viewModel.screenShots, id: \.self) {
                AsyncImage(url: URL(string: $0),
                           content: { image in
                    image
                        .resizable()

                }, placeholder: {
                    Color.gray
                })
                .background(isPreview ? Color.red : .clear)
                .cornerRadius(5)
                if $0 != viewModel.screenShots.last {
                    Spacer().frame(width: spacing)
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            rowBottomSection(geometry: geometry)
        }
    }
}

struct SearchResultRowBottomSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchResultRowViewViewModel()
        SearchResultRowBottomSection(viewModel: viewModel)
    }
}
