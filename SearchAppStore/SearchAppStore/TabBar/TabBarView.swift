//
//  TabBarView.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import SwiftUI

struct TabBarView: View {

    @StateObject var viewModel = TabBarViewViewModel()

    private var appsListView: some View {
        AppsSearchView()
            .tabItem({
                Label("Search", systemImage: SystemSymbols.searchIcon.value)
            })
            .tag(0)
    }

    private var favoriteAppsView: some View {
        FavouriteAppsView()
            .tabItem {
                Label("Favourite", systemImage: SystemSymbols.heartIcon.value)
            }
            .tag(1)
    }

    var body: some View {
        TabView(selection: $viewModel.tabIndex) {
            appsListView
            favoriteAppsView
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
