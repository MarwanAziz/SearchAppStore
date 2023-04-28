//
//  ApiConnector.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation

enum ApiConnectorError: Error {
    case noResult
    case failedToParse
    case responseError(String)
}

protocol ApiConnector {
    var returnTestingData: Bool { get set }
    func searchForApps(terms: [String], resultLimit: Int) async -> (error: ApiConnectorError? ,result: ApiConnectorAppStoreResult?)
}
