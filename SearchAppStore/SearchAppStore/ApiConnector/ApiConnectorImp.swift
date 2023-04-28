//
//  ApiConnectorImp.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation

class ApiConnectorImp: ApiConnector {

    static let shared: ApiConnector = ApiConnectorImp()
    private let apiUrl: String = "https://itunes.apple.com/search"
    private let session = URLSession.shared
    var returnTestingData: Bool = false

    private init() {
    }


    private func getStoredAppInfo() -> Data? {
        if let url = Bundle.main.url(forResource: "AppInfo", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
                return nil
            }
        }
        return nil
    }

    func searchForApps(terms: [String], resultLimit: Int) async -> (error: ApiConnectorError? ,result: ApiConnectorAppStoreResult?) {

        if returnTestingData, let storedData = getStoredAppInfo() {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ApiConnectorAppStoreResult.self, from: storedData)

                return (nil, result)
            } catch {
                return (ApiConnectorError.failedToParse, nil)
            }
        }
        
        var urlComponent = URLComponents(string: apiUrl)!
        let searchTerms: String = terms.joined(separator: "&")
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: searchTerms),
            URLQueryItem(name: "country", value: "no"),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "limit", value: String(resultLimit))
        ]

        do {
            let (data, response) = try await session.data(from: urlComponent.url!)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return (ApiConnectorError.responseError("Failed to fetch data"), nil)
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(ApiConnectorAppStoreResult.self, from: data)

            return (nil, result)

        } catch {
            print(error)
            return (ApiConnectorError.failedToParse, nil)
        }
    }
}
