import Foundation

struct TeamResponse: Codable {
	let id: Int?
	let name: String?
	let logo: String?
	let nationnal: Bool?
	let country: Country?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case logo = "logo"
		case nationnal = "nationnal"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		logo = try values.decodeIfPresent(String.self, forKey: .logo)
		nationnal = try values.decodeIfPresent(Bool.self, forKey: .nationnal)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
	}

}
