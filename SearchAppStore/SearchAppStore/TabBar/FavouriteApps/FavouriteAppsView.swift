//
//  FavouriteAppsView.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import SwiftUI

// Favorite
struct FavouriteAppsView: View {
    @StateObject var viewModel = FavouriteAppsViewViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.storedApps.isEmpty {
                    Text("Nothing has been favourited")
                        .foregroundColor(.secondary)
                } else {
                    AppsListView(apps: viewModel.storedApps)
                }
            }
            .navigationTitle("Favourite")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FavouriteAppsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteAppsView()
    }
}
