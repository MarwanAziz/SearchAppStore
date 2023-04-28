//
//  FavouriteAppsViewViewModel.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 28/04/2023.
//

import Foundation

class FavouriteAppsViewViewModel: AppInfoSupperViewModel, ObservableObject {

    @Published var storedApps: [SearchResultRowViewViewModel] = []

    override init() {
        super.init()
        observeStoredAppUpdates()
    }

    private func observeStoredAppUpdates() {
        dataConnector.storedApps.receive(on: DispatchQueue.main).sink { [weak self] apps in
            guard let self else { return }
            self.storedApps = apps.map { self.transform(appInfo: $0)}
        }.store(in: &bag)
    }
}
