//
//  AppsSearchViewViewModel.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation

class AppsSearchViewViewModel: AppInfoSupperViewModel, ObservableObject {

    private let searchResultLimit: Int = 20
    private var isSearching: Bool = false
    private var lastSearchTimeStamp: CGFloat?

    @Published var searchResult: [SearchResultRowViewViewModel] = [] {
        didSet {
            isSearching = false
        }
    }

    @Published var searchText: String = "" {
        didSet {
            updateResult()
        }
    }

    @Published var searchBarPrompt: String = "Search App Store"

    private var canSearch: Bool {
        guard !isSearching else {
            return false
        }

        if let lastSearchTimeStamp {
            if Date().timeIntervalSince1970 - lastSearchTimeStamp > 0.5 {
                return true
            }

            return false
        }

        return true
    }

    private func reset() {
        isSearching = false
        lastSearchTimeStamp = nil
    }

    private func searchAppStore(for searchTerms: [String]) {
        Task {
            let searchResult = await dataConnector.fetchResultForSearchTerms(searchTerms: searchTerms, resultLimit: searchResultLimit)
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.searchResult = (searchResult.searchResult?.results ?? []).map(self.transform(appInfo:))
                }
                self?.reset()
            }
        }
    }

    private func updateResult() {
        if searchText.isEmpty {
            return
        }

        if canSearch {
            // As we keeping last result if the user cleaned the search box, make the prompt as the last search text.
            searchBarPrompt = searchText
            isSearching = true
            lastSearchTimeStamp = Date().timeIntervalSince1970
            let searchTerms = searchText.split(separator: ",").map({ String($0)})
            searchAppStore(for: searchTerms)
        }
    }

    func updateSearchResultIfNeeded() {
        updateResult()
    }

    func forceLoadTestData() {
        dataConnector.returnApiTestingData = true
        searchAppStore(for: [])
    }
}
