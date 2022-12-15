import Foundation

struct Points: Codable {
	let selfPoints: Int?
	let againstPoints: Int?

	enum CodingKeys: String, CodingKey {

		case selfPoints = "for"
		case againstPoints = "against"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        selfPoints = try values.decodeIfPresent(Int.self, forKey: .selfPoints)
        againstPoints = try values.decodeIfPresent(Int.self, forKey: .againstPoints)
	}
}
