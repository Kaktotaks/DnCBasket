import Foundation

struct Group: Codable {
	let name: String?
	let points: Int?

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case points = "points"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
	}
}
