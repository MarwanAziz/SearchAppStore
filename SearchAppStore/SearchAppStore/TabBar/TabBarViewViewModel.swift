//
//  TabBarViewViewModel.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation

enum TabViewTabs: Int {
    case search
    case favourite
}

class TabBarViewViewModel: ObservableObject {

    @Published var tabIndex: Int = 0

}
