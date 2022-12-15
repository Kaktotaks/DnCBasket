import Foundation

struct LeaguesEntryPoint: Codable {
	let get: String?
	let parameters: [String]?
	let errors: [String]?
	let results: Int?
	let leaguesResponse: [LeagueResponse]?

	enum CodingKeys: String, CodingKey {

		case get = "get"
		case parameters = "parameters"
		case errors = "errors"
		case results = "results"
		case leaguesResponse = "response"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		get = try values.decodeIfPresent(String.self, forKey: .get)
		parameters = try values.decodeIfPresent([String].self, forKey: .parameters)
		errors = try values.decodeIfPresent([String].self, forKey: .errors)
		results = try values.decodeIfPresent(Int.self, forKey: .results)
        leaguesResponse = try values.decodeIfPresent([LeagueResponse].self, forKey: .leaguesResponse)
	}

}
