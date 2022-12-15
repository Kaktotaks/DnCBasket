import Foundation

struct LeagueResponse: Codable {
	let id: Int?
	let name: String?
	let type: String?
	let logo: String?
	let country: Country?
	let seasons: [Seasons]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case type = "type"
		case logo = "logo"
		case country = "country"
		case seasons = "seasons"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		logo = try values.decodeIfPresent(String.self, forKey: .logo)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		seasons = try values.decodeIfPresent([Seasons].self, forKey: .seasons)
	}

}
