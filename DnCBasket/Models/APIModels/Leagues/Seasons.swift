import Foundation

struct Seasons: Codable {
	let season: String?
	let start: String?
	let end: String?

	enum CodingKeys: String, CodingKey {

		case season = "season"
		case start = "start"
		case end = "end"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		season = try values.decodeIfPresent(String.self, forKey: .season)
		start = try values.decodeIfPresent(String.self, forKey: .start)
		end = try values.decodeIfPresent(String.self, forKey: .end)
	}

}
