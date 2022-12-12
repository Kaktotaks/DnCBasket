import Foundation

struct League: Codable {
	let id: Int?
	let name: String?
	let type: String?
	let season: String?
	let logo: String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case type = "type"
		case season = "season"
		case logo = "logo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		season = try values.decodeIfPresent(String.self, forKey: .season)
		logo = try values.decodeIfPresent(String.self, forKey: .logo)
	}

}
