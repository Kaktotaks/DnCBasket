//
//  RestService.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import Foundation
import Alamofire

class RestService {
    private enum APIConstants {
        static let mainURL = "https://v1.basketball.api-sports.io/"
        static let apiKey = "626f23c3584d8914d8e90a3683f68a67"
        static let gamesEndPoint = "games?"
        static let headers = [
            "x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"
        ]
    }

    static let shared: RestService = .init()

    private init() {}

    // MARK: CONTROL API RESPONSE
    private func getJsonResponse(
        _ path: String,
        params: [String: Any] = [:],
        method: HTTPMethod = .get,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders = ["x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"],
        completion: @escaping((Result<[GameResponse], Error>) -> Void)
    ) {
        let url = "\(APIConstants.mainURL)\(path)"

        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {

            AF.request(
                encoded,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: headers
            ).responseJSON { response in
                switch response.result {
                case .success:
                    print("Successfull request")
                    print(url)

                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(GamesEntryPoint.self, from: response.data ?? Data()) {
                        let games = data.response ?? []
                        completion(.success(games))
                        print("TOTAL REZULTS: \(data.results)")
                    }

                case .failure(let error):
                    completion(.failure(error))
                    print("Error while getting TopArticles request: \(error.localizedDescription)")
                }
            }
        }
    }

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
        print(path)

        self.getJsonResponse(path) { result in
            switch result {
            case .success(let games):
                completionHandler(.success(games))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
