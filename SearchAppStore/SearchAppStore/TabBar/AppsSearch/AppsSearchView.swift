//
//  AppsSearchView.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import SwiftUI

struct AppsSearchView: View {

    @StateObject private var viewModel: AppsSearchViewViewModel = AppsSearchViewViewModel()

    var body: some View {
        NavigationView {
            AppsListView(apps: viewModel.searchResult)
            .searchable(text: $viewModel.searchText, prompt: viewModel.searchBarPrompt)
            .onSubmit(of: .search) {
                viewModel.updateSearchResultIfNeeded()
            }
            .onTapGesture {
                if isPreview {
                    viewModel.forceLoadTestData()
                }
            }
        }
    }
}

struct AppsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AppsSearchView()
            .preferredColorScheme(.dark)
    }
}
