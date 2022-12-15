import Foundation

struct Win: Codable {
	let total: Int?
	let percentage: String?

	enum CodingKeys: String, CodingKey {

		case total = "total"
		case percentage = "percentage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		percentage = try values.decodeIfPresent(String.self, forKey: .percentage)
	}
}
