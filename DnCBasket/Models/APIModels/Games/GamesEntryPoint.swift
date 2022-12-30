import Foundation

struct GamesEntryPoint: Codable {
	let get: String?
	let parameters: Parameters?
	let errors: [String]?
	let results: Int?
	let response: [GameResponse]?

	enum CodingKeys: String, CodingKey {
		case get = "get"
		case parameters = "parameters"
		case errors = "errors"
		case results = "results"
		case response = "response"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		get = try values.decodeIfPresent(String.self, forKey: .get)
		parameters = try values.decodeIfPresent(Parameters.self, forKey: .parameters)
		errors = try values.decodeIfPresent([String].self, forKey: .errors)
		results = try values.decodeIfPresent(Int.self, forKey: .results)
		response = try values.decodeIfPresent([GameResponse].self, forKey: .response)
	}
}
