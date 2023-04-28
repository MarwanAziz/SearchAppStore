//
//  PersistentConnector.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import Foundation
import Combine

protocol PersistentConnector {
    var storedApps: CurrentValueSubject<Set<String>, Never> { get }
    func favouritedApps() async-> [String]
    func addAppToFavourite(appInfo: String) async -> Bool
    func removeAppFromFavourite(appInfo: String) async -> Bool
}
