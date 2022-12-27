//
//  OfflineLegues.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 27.12.2022.
//

import Foundation

struct OfflineLeagues {
    static var offlineLeaguesList: [OfflineLeague] = [
        OfflineLeague(id: 12, name: "NBA", logo: "https://media-1.api-sports.io/basketball/leagues/12.png", countryName: "USA"),
        OfflineLeague(id: 2, name: "LNB", logo: "https://media.api-sports.io/basketball/leagues/2.png", countryName: "France"),
        OfflineLeague(id: 117, name: "ACB", logo: "https://media-1.api-sports.io/basketball/leagues/117.png", countryName: "Spain"),
        OfflineLeague(id: 52, name: "Lega A", logo: "https://media-2.api-sports.io/basketball/leagues/52.png", countryName: "Italy"),
        OfflineLeague(id: 40, name: "BBL", logo: "https://media-1.api-sports.io/basketball/leagues/40.png", countryName: "Germany"),
        OfflineLeague(id: 104, name: "Super Ligi", logo: "https://media-2.api-sports.io/basketball/leagues/104.png", countryName: "Turkey"),
        OfflineLeague(id: 106, name: "Super League", logo: "https://media.api-sports.io/basketball/leagues/106.png", countryName: "Ukraine")
    ]
}

struct OfflineLeague {
    let id: Int?
    let name: String?
    let logo: String?
    let countryName: String?
}

struct OfflineSeasons {
    static var offlineSeasonsList: [OfflineSeason] = [
        OfflineSeason(season: "2022"),
        OfflineSeason(season: "2021"),
        OfflineSeason(season: "2020"),
        OfflineSeason(season: "2019"),
        OfflineSeason(season: "2018"),
        OfflineSeason(season: "2017"),
        OfflineSeason(season: "2016"),
        OfflineSeason(season: "2015")
        ]
}

struct OfflineSeason {
    var season: String?
}
