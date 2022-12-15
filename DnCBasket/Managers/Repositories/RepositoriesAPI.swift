//
//  RepositoriesAPI.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 14.12.2022.
//

import Foundation

// 2
//protocol RepositoriesAPIProtocol {
//    func getAllGames(
//        league: Int?,
//        season: String?,
//        completionHandler: @escaping(Result<[GameResponse], Error>) -> Void
//    )
//}
//
//// 3
//class RepositoriesAPI: BaseAPI<RepositoriesNetworking>, RepositoriesAPIProtocol {
//    private enum APIConstants {
//        static let mainURL = "https://v1.basketball.api-sports.io/"
//        static let apiKey = "626f23c3584d8914d8e90a3683f68a67"
//        static let gamesEndPoint = "games?"
//        static let headers = [
//            "x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"
//        ]
//    }
//    
//    func getAllGames(
//        league: Int? = 10,
//        season: String? = "2022-2023",
//        completionHandler: @escaping(Result<[GameResponse], Error>) -> Void
//    ) {
////        var path = "\(APIConstants.gamesEndPoint)"
////
////        if let leagueKey = league {
////            path = "\(path)&league=\(leagueKey)"
////        }
////
////        if let seasonKey = season {
////            path = "\(path)&season=\(seasonKey)"
////        }
////        print(path)
////
////        self.getJsonResponse(path) { [weak self] result in
////            switch result {
////            case .success(let games):
////                completionHandler(.success(games))
////            case .failure(let error):
////                completionHandler(.failure(error))
////            }
////        }
//        
//        self.fetchData(target: .getRepos(endPointName: "" ), responseClass: [GameResponse].self) { result in
//            switch result {
//            case .success(let success):
//                <#code#>
//            case .failure(let failure):
//                <#code#>
//            }
//        }
//    }
//    
//}
