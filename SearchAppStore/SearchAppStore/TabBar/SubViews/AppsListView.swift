//
//  AppsListView.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 28/04/2023.
//

import SwiftUI

struct AppsListView: View {
    var apps: [SearchResultRowViewViewModel]

    var body: some View {
        List(apps, id: \.appId) { rowViewModel in
            SearchResultRowView(viewModel: rowViewModel)
                .frame(maxWidth: .infinity, minHeight: 299, maxHeight: .infinity)
                .padding(.bottom, 50)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

struct AppsListView_Previews: PreviewProvider {
    static var previews: some View {
        AppsListView(apps: [])
    }
}
