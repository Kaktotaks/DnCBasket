
import Foundation

struct Scores: Codable {
	let home: Home?
	let away: Away?

	enum CodingKeys: String, CodingKey {

		case home = "home"
		case away = "away"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		home = try values.decodeIfPresent(Home.self, forKey: .home)
		away = try values.decodeIfPresent(Away.self, forKey: .away)
	}

}
