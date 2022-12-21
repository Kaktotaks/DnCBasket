//
//  RestService.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import Foundation
import Alamofire

class RestService {
    static let shared: RestService = .init()

    private init() {}

    enum APIConstants {
        static let mainURL = "https://v1.basketball.api-sports.io/"
        static let apiKey = "626f23c3584d8914d8e90a3683f68a67"
        static let gamesEndPoint = "games?"
        static let leaguesEndPoint = "leagues?"
        static let headers = [
            "x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"
        ]
    }

    // MARK: CONTROL API RESPONSE
    private func getJsonResponse(
        _ path: String,
        params: [String: Any] = [:],
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders = ["x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"],
        completion: @escaping(AFDataResponse<Any>) -> Void
    ) {
        let url = "\(APIConstants.mainURL)\(path)"
        print(url)

        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {

            AF.request(
                encoded,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: headers
            ).responseJSON { response in
                print("Successfull request")
                completion(response)
            }
        }
    }

    // MARK: - Getting all matches
    func getAllGames(
        league: Int? = 10,
        season: String? = "2022-2023",
        completionHandler: @escaping(Result<[GameResponse], Error>) -> Void
    ) {
        var path = "\(APIConstants.gamesEndPoint)"

        if let leagueKey = league {
            path = "\(path)&league=\(leagueKey)"
        }

        if let seasonKey = season {
            path = "\(path)&season=\(seasonKey)"
        }
//        print(path)

        self.getJsonResponse(path) { response in

            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(GamesEntryPoint.self, from: response.data ?? Data()) {
                    let games = data.response ?? []
                    completionHandler(.success(games))
                    print("Games now count: \(games.count) ⛹🏻‍♂️")
                }
            case .failure(let error):
            completionHandler(.failure(error))
            }
        }
    }

    // MARK: - Getting all leagues
    func getAllleagues(
        season: String? = "2022-2023",
        completionHandler: @escaping(Result<[LeagueResponse], Error>) -> Void
    ) {
        var path = "\(APIConstants.leaguesEndPoint)"

        if let seasonKey = season {
            path = "\(path)season=\(seasonKey)"
        }
        print(path)

        self.getJsonResponse(path) { response in

            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(LeaguesEntryPoint.self, from: response.data ?? Data()) {
                    let leagues = data.leaguesResponse ?? []
                    completionHandler(.success(leagues))
                    print("Leagues now count: \(leagues.count) ⛹🏻‍♂️")
                }
            case .failure(let error):
            completionHandler(.failure(error))
            }
        }
    }
}
