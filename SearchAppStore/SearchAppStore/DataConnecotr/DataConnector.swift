//
//  DataConnector.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation
import Combine

enum DataConnectorError: Error {
    case noResultFound
    case failedToParseData
    case serverError
}

protocol DataConnector {
    var storedApps: CurrentValueSubject<[AppInfo], Never> { get }
    var returnApiTestingData: Bool { get set }
    func fetchResultForSearchTerms(searchTerms: [String], resultLimit: Int) async -> (error: DataConnectorError?, searchResult: SearchResult?)
    func favouritedApps() async-> [AppInfo]
    func addAppToFavourite(appInfo: AppInfo) async -> Bool
    func removeAppFromFavourite(appInfo: AppInfo) async -> Bool
}
