//
//  RepositoriesNetworking.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 14.12.2022.
//

//import Foundation
//enum RepositoriesNetworking {
//    case getRepos(endPointName: String)
//}
//
//extension RepositoriesNetworking: TargetType {
//    var baseURL: String {
//        switch self {
//        default:
//            return "https://v1.basketball.api-sports.io/"
//        }
//    }
//    
//    var path: String {
//        switch self {
//        case .getRepos(let endPointName):
//            return "\(endPointName)"
//        }
//    }
//    
//    var method: HTTPMethod {
//        switch self {
//        case .getRepos:
//            return .get
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case .getRepos:
//            return .requestPlain
//        }
//    }
//    
//    var headers: [String : String]? {
//        switch self {
//        default:
//            return ["x-apisports-key" : "626f23c3584d8914d8e90a3683f68a67"]
//        }
//    }
//    
//}
