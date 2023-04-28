//
//  DataModels.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 25/04/2023.
//

import Foundation

// MARK: - AppStoreResult
struct ApiConnectorAppStoreResult: Codable {
    let resultCount : Int?
    let results : [ApiConnectorResults]?

    enum CodingKeys: String, CodingKey {

        case resultCount = "resultCount"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([ApiConnectorResults].self, forKey: .results)
    }
}

// MARK: - AppInfo
struct ApiConnectorResults : Codable {
    let isGameCenterEnabled : Bool?
    let features : [String]?
    let advisories : [String]?
    let supportedDevices : [String]?
    let ipadScreenshotUrls : [String]?
    let appletvScreenshotUrls : [String]?
    let artworkUrl60 : String?
    let artworkUrl512 : String?
    let artworkUrl100 : String?
    let artistViewUrl : String?
    let screenshotUrls : [String]?
    let kind : String?
    let releaseNotes : String?
    let artistId : Int?
    let artistName : String?
    let genres : [String]?
    let price : Double?
    let description : String?
    let currentVersionReleaseDate : String?
    let trackId : Int?
    let trackName : String?
    let bundleId : String?
    let sellerName : String?
    let currency : String?
    let isVppDeviceBasedLicensingEnabled : Bool?
    let primaryGenreName : String?
    let primaryGenreId : Int?
    let trackViewUrl : String?
    let minimumOsVersion : String?
    let trackCensoredName : String?
    let languageCodesISO2A : [String]?
    let fileSizeBytes : String?
    let formattedPrice : String?
    let contentAdvisoryRating : String?
    let averageUserRatingForCurrentVersion : Double?
    let userRatingCountForCurrentVersion : Int?
    let averageUserRating : Double?
    let trackContentRating : String?
    let releaseDate : String?
    let genreIds : [String]?
    let version : String?
    let wrapperType : String?
    let userRatingCount : Int?

    enum CodingKeys: String, CodingKey {

        case isGameCenterEnabled = "isGameCenterEnabled"
        case features = "features"
        case advisories = "advisories"
        case supportedDevices = "supportedDevices"
        case ipadScreenshotUrls = "ipadScreenshotUrls"
        case appletvScreenshotUrls = "appletvScreenshotUrls"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl512 = "artworkUrl512"
        case artworkUrl100 = "artworkUrl100"
        case artistViewUrl = "artistViewUrl"
        case screenshotUrls = "screenshotUrls"
        case kind = "kind"
        case releaseNotes = "releaseNotes"
        case artistId = "artistId"
        case artistName = "artistName"
        case genres = "genres"
        case price = "price"
        case description = "description"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case trackId = "trackId"
        case trackName = "trackName"
        case bundleId = "bundleId"
        case sellerName = "sellerName"
        case currency = "currency"
        case isVppDeviceBasedLicensingEnabled = "isVppDeviceBasedLicensingEnabled"
        case primaryGenreName = "primaryGenreName"
        case primaryGenreId = "primaryGenreId"
        case trackViewUrl = "trackViewUrl"
        case minimumOsVersion = "minimumOsVersion"
        case trackCensoredName = "trackCensoredName"
        case languageCodesISO2A = "languageCodesISO2A"
        case fileSizeBytes = "fileSizeBytes"
        case formattedPrice = "formattedPrice"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case averageUserRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
        case averageUserRating = "averageUserRating"
        case trackContentRating = "trackContentRating"
        case releaseDate = "releaseDate"
        case genreIds = "genreIds"
        case version = "version"
        case wrapperType = "wrapperType"
        case userRatingCount = "userRatingCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isGameCenterEnabled = try values.decodeIfPresent(Bool.self, forKey: .isGameCenterEnabled)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        advisories = try values.decodeIfPresent([String].self, forKey: .advisories)
        supportedDevices = try values.decodeIfPresent([String].self, forKey: .supportedDevices)
        ipadScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .ipadScreenshotUrls)
        appletvScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .appletvScreenshotUrls)
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
        screenshotUrls = try values.decodeIfPresent([String].self, forKey: .screenshotUrls)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes)
        artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        genres = try values.decodeIfPresent([String].self, forKey: .genres)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        currentVersionReleaseDate = try values.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate)
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
        bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
        sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        isVppDeviceBasedLicensingEnabled = try values.decodeIfPresent(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled)
        primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
        primaryGenreId = try values.decodeIfPresent(Int.self, forKey: .primaryGenreId)
        trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
        minimumOsVersion = try values.decodeIfPresent(String.self, forKey: .minimumOsVersion)
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
        languageCodesISO2A = try values.decodeIfPresent([String].self, forKey: .languageCodesISO2A)
        fileSizeBytes = try values.decodeIfPresent(String.self, forKey: .fileSizeBytes)
        formattedPrice = try values.decodeIfPresent(String.self, forKey: .formattedPrice)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        averageUserRatingForCurrentVersion = try values.decodeIfPresent(Double.self, forKey: .averageUserRatingForCurrentVersion)
        userRatingCountForCurrentVersion = try values.decodeIfPresent(Int.self, forKey: .userRatingCountForCurrentVersion)
        averageUserRating = try values.decodeIfPresent(Double.self, forKey: .averageUserRating)
        trackContentRating = try values.decodeIfPresent(String.self, forKey: .trackContentRating)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        genreIds = try values.decodeIfPresent([String].self, forKey: .genreIds)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
        userRatingCount = try values.decodeIfPresent(Int.self, forKey: .userRatingCount)
    }

}
