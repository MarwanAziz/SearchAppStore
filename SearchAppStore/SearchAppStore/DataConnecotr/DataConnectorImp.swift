//
//  DataConnectorImp.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation
import Combine

class DataConnectorImp: DataConnector {

    static let shared: DataConnector = DataConnectorImp()
    private var apiConnector = ApiConnectorImp.shared
    private var persistentConnector: PersistentConnector = PersistentConnectorImp.shared
    @Published var storedApps = CurrentValueSubject<[AppInfo], Never>([])
    private var bag: Array<AnyCancellable> = []

    private init() {
        persistentConnector.storedApps.sink { [weak self] storedApps in
            let storedAppInfo = self?.transform(jsonAppInfo: Array(storedApps)) ?? []
            self?.storedApps.send(storedAppInfo)
        }.store(in: &bag)
    }

    var returnApiTestingData: Bool = false {
        didSet {
            apiConnector.returnTestingData = returnApiTestingData
        }
    }

    private func transform(apiResult: ApiConnectorAppStoreResult) -> SearchResult? {
        if let data = try? JSONEncoder().encode(apiResult) {
            do {
                let localModel = try JSONDecoder().decode(SearchResult.self, from: data)
                return localModel
            } catch {
                print("Error decoding SearchResult", error.localizedDescription)
                return nil
            }
        }

        return nil
    }

    func fetchResultForSearchTerms(searchTerms: [String], resultLimit: Int) async -> (error: DataConnectorError?, searchResult: SearchResult?) {
        let apiResult = await apiConnector.searchForApps(terms: searchTerms, resultLimit: resultLimit)

        if let apiSearchResult = apiResult.result {
            let searchResult = transform(apiResult: apiSearchResult)
            return (nil, searchResult)
        } else if let apiError = apiResult.error {
            var error: DataConnectorError? = nil
            switch apiError {
            case .noResult:
                error = .noResultFound
            case .failedToParse:
                error = .failedToParseData
            case .responseError(_):
                error = .serverError
            }

            return (error, nil)
        } else {
            return(DataConnectorError.noResultFound, nil)
        }
    }

    // MARK: - Persistent

    private lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()

    private func transform(appInfoJson: String) -> AppInfo? {
        if let appData = appInfoJson.data(using: .utf8) {
            do {
                let appInfo = try jsonDecoder.decode(AppInfo.self, from: appData)
                return appInfo
            } catch {
                return nil
            }
        }

        return nil
    }

    private func transform(jsonAppInfo: [String]) -> [AppInfo] {
        var apps: [AppInfo] = []
        if !jsonAppInfo.isEmpty {
            jsonAppInfo.forEach { app in
                if let appInfo = transform(appInfoJson: app) {
                    apps.append(appInfo)
                }
            }
            return apps
        }
        return apps
    }

    func favouritedApps() async -> [AppInfo] {
        let storedApps = await persistentConnector.favouritedApps()
        return transform(jsonAppInfo: storedApps)
    }

    private func encodeAppInfo(appInfo: AppInfo) -> String? {
        let appData = try? JSONEncoder().encode(appInfo)
        if let appData, let appJson = String(data: appData, encoding: .utf8) {
            return appJson
        }

        return nil
    }

    func addAppToFavourite(appInfo: AppInfo) async -> Bool {
        if let appJson = encodeAppInfo(appInfo: appInfo) {
            let result = await persistentConnector.addAppToFavourite(appInfo: appJson)
            return result
        }
        return false
    }

    func removeAppFromFavourite(appInfo: AppInfo) async -> Bool {
        if let appJson = encodeAppInfo(appInfo: appInfo) {
            let result = await persistentConnector.removeAppFromFavourite(appInfo: appJson)
            return result
        }

        return false
    }
}
