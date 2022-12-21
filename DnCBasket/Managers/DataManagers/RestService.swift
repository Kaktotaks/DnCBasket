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
        static let headers = [
            "x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"
        ]
    }

    // MARK: CONTROL API RESPONSE
    func getJsonResponse(
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
                        print("Total Results: \(data.results)")
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

// MARK: - NEW version

enum EndPointType {
    case callingAllGames
    case calingAllLeagues
    case calingTeams
}

protocol RequestParameters {
    var url: String { get }
    var headers: HTTPHeaders { get }
    var httpMethod: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

extension EndPointType: RequestParameters {
    var url: String {
        switch self {
        case .callingAllGames:
            return "https://v1.basketball.api-sports.io/games?league=10&season=2022-2023&timezone=ua"
        case .calingAllLeagues:
            return "https://v1.basketball.api-sports.io/leagues"
        case .calingTeams:
            return "https://v1.basketball.api-sports.io/standings?"
        }
 
    }

    var headers: Alamofire.HTTPHeaders {
        switch self {
        default:
            return ["x-apisports-key": "626f23c3584d8914d8e90a3683f68a67"]
        }
    }

    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var encoding: Alamofire.ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

class APIHandler {
    static let shared: APIHandler = .init()

    private init() {}
    
    func genericAPICalling<T: Codable>(endPointType: EndPointType, parametrs: [String: Any]? = nil, handler: @escaping(Result<[T], Error>) -> (Void)) {
        
        AF.request(endPointType.url, method: endPointType.httpMethod, parameters: parametrs, encoding: endPointType.encoding, headers: endPointType.headers).response { response in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(jsonObject)
                    guard
                        let decode = try? JSONDecoder().decode([T].self, from: data)
                    else {
                        return
                    }

                    handler(.success(decode))
                }
            case .failure(let error):
                handler(.failure(error))
                print("Error while getting objects request: \(error.localizedDescription)")
            }
        }
    }
    
//    func getAllGames(
//        league: Int? = 10,
//        season: String? = "2022-2023",
//        completionHandler: @escaping(Result<[T], Error>) -> Void
//    ) {
//        var path = "\(EndPointType.callingAllGames)"
//
//        if let leagueKey = league {
//            path = "\(path)&league=\(leagueKey)"
//        }
//
//        if let seasonKey = season {
//            path = "\(path)&season=\(seasonKey)"
//        }
//        print(path)

//        self.getJsonResponse(path) { result in
//            switch result {
//            case .success(let games):
//                completionHandler(.success(games))
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
}
