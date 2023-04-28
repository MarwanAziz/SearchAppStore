//
//  SystemImages.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 28/04/2023.
//

import Foundation

enum SystemSymbols: String {
    case searchIcon = "magnifyingglass"
    case heartIcon = "heart"
    case emptyStar = "star"
    case halfFullStar = "star.leadinghalf.filled"
    case fullStar = "star.fill"

    var value: String {
        self.rawValue
    }
}
