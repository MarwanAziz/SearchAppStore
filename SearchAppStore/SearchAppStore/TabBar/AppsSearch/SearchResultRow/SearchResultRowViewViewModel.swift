//
//  SearchResultRowViewViewModel.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import Foundation
import Combine

struct AppRateInfo {
    let id: String = UUID().uuidString
    let systemImageName: String
}

class SearchResultRowViewViewModel: ObservableObject {
    let appId: String
    @Published var title: String
    @Published var subtitle: String
    @Published var iconURL: String
    @Published var rate: Double
    @Published private var rateCount: Int
    @Published var rateCountDisplay: String = ""
    @Published var screenShots: [String]
    private var appInfo: AppInfo?
    @Published var  favourited: Bool = false

    private var bag: Array<AnyCancellable> = []

    private var favouritedApps: [AppInfo] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.checkIfFavourited()
            }
        }
    }
    private let dataConnector: DataConnector = DataConnectorImp.shared

    init(appInfo: AppInfo? = nil) {
        let appScreenShots = Array(appInfo?.screenshotUrls?.prefix(3) ?? [])
        let appCategories = appInfo?.genres?.joined(separator: ", ") ?? ""

        self.appId = appInfo?.bundleId ?? ""
        self.title = appInfo?.trackName ?? ""
        self.subtitle = appCategories
        self.iconURL = appInfo?.artworkUrl100 ?? ""
        self.rate = appInfo?.averageUserRating ?? 0
        self.rateCount = appInfo?.userRatingCount ?? 0
        self.screenShots = appScreenShots
        self.appInfo = appInfo
        checkIfFavourited()
        observeStoredApps()
    }

    func updateFrom(appInfo: AppInfo) {
        self.title = appInfo.trackName ?? ""
        self.subtitle = appInfo.primaryGenreName ?? ""
        self.iconURL = appInfo.artworkUrl100 ?? ""
        self.rate = appInfo.averageUserRating ?? 0
        self.rateCount = 0
        self.screenShots = Array(appInfo.screenshotUrls?.prefix(2) ?? [])
        self.rateCountDisplay = self.userRateCountInDisplayFormat()
    }

    private func observeStoredApps() {
        dataConnector.storedApps.receive(on: DispatchQueue.main).sink { [weak self] storedApps in
            self?.favouritedApps = storedApps
        }.store(in: &bag)
    }

    private func checkIfFavourited() {
        favourited = favouritedApps.first(where: { $0.bundleId == appId }) != nil
        self.objectWillChange.send()
    }

    private func transformRatingValueToStarImageName(values: [Double]) -> [AppRateInfo] {
        values.map {
            AppRateInfo(systemImageName: starImageNameFromRatingValue(value: $0))
        }
    }

    private func ratingValuesFrom(rate: Double) -> [Double] {
        var ratingValues: [Double] = []
        func addStarValue(value: Double) {
            guard ratingValues.count < 6 else {
                return
            }

            ratingValues.append(value)
        }

        if rate > 0 {
            for index in 0...4 {
                let increase = rate - Double(index)
                if increase == 0 {
                    if Double(index + 1) > rate {
                        addStarValue(value: 0)
                    } else {
                        addStarValue(value: rate > 0.5 ? 1 : 0.5)
                    }
                } else if increase < 1 && increase >= 0.5 {
                    addStarValue(value: 0.5)
                } else if increase >= 1 {
                    addStarValue(value: 1)
                } else {
                    addStarValue(value: 0)
                }
            }
        } else {
            ratingValues = [0, 0, 0, 0, 0]
        }

        return ratingValues
    }

    private func starImageNameFromRatingValue(value: Double) -> String {
        if value >= 1 {
            return SystemSymbols.fullStar.value
        } else if value > 0 {
            return SystemSymbols.halfFullStar.value
        } else {
            return SystemSymbols.emptyStar.value
        }
    }

    func ratingStarts() -> [AppRateInfo] {
        let ratingValues = ratingValuesFrom(rate: rate)
        let ratingStars = transformRatingValueToStarImageName(values: ratingValues)
        return ratingStars
    }

    private func formatPoints(num: Double) -> String {
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))K")
            }
            return("\(thousandNum.roundToPlaces(places: 1))K")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))K")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }

    func userRateCountInDisplayFormat() -> String {
        if rateCount < 1 {
            return ""
        }
        return formatPoints(num: Double(rateCount))
    }

    private func removeAppInfoFromFavAndRefresh(appInfo: AppInfo) {
        Task {
            _ = await dataConnector.removeAppFromFavourite(appInfo: appInfo)
        }
    }

    private func addAppToFavAndRefresh(appInfo: AppInfo) {
        Task {
            _ = await dataConnector.addAppToFavourite(appInfo: appInfo)
        }
    }

    func AddRemoveButtonTapped() {
        if favourited {
            if let appInfo = favouritedApps.first(where: { $0.bundleId == appId }) {
                removeAppInfoFromFavAndRefresh(appInfo: appInfo)
            }
        } else if let appInfo {
            addAppToFavAndRefresh(appInfo: appInfo)
        }
    }
}
