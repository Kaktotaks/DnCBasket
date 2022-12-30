import Foundation

struct Status: Codable {
	let long: String?
	let short: String?
	let timer: String?

	enum CodingKeys: String, CodingKey {
		case long = "long"
		case short = "short"
		case timer = "timer"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		long = try values.decodeIfPresent(String.self, forKey: .long)
		short = try values.decodeIfPresent(String.self, forKey: .short)
		timer = try values.decodeIfPresent(String.self, forKey: .timer)
	}
}
