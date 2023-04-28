//
//  AppInfoSupperViewModel.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 28/04/2023.
//

import Foundation
import Combine

class AppInfoSupperViewModel {

    var dataConnector: DataConnector = DataConnectorImp.shared
    var bag: [AnyCancellable] = []

    func transform(appInfo: AppInfo) -> SearchResultRowViewViewModel {
        return SearchResultRowViewViewModel(appInfo: appInfo)
    }
}
