//
//  SearchResultRowView.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 26/04/2023.
//

import SwiftUI

struct SearchResultRowView: View {
    let viewModel: SearchResultRowViewViewModel

    var rowTopSection: some View {
        SearchResultRowTopSection(viewModel: viewModel)
    }

    private var rowBottomSection: some View {
        SearchResultRowBottomSection(viewModel: viewModel)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                rowTopSection
                rowBottomSection
            }
        }
    }
}

struct SearchResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchResultRowViewViewModel()
        SearchResultRowView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
