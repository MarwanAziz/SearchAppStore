//
//  PersistentConnectorImp.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import Foundation
import Combine

class PersistentConnectorImp: PersistentConnector {
    static let shared: PersistentConnector = PersistentConnectorImp()
    @Published var storedApps = CurrentValueSubject<Set<String>, Never>([])
    private init(){}

    func favouritedApps() async-> [String] {
        return Array(storedApps.value)
    }

    func addAppToFavourite(appInfo: String) async -> Bool {
        if storedApps.value.contains(appInfo) {
            return false
        }
        storedApps.value.insert(appInfo)
        return true
    }

    func removeAppFromFavourite(appInfo: String) async -> Bool {
        if storedApps.value.contains(appInfo) {
            storedApps.value.remove(appInfo)
            return true
        }

        return false
    }
}
