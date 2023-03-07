import Foundation

struct Teams: Codable {
	let home: GenericTeam?
	let away: GenericTeam?

	enum CodingKeys: String, CodingKey {
		case home = "home"
		case away = "away"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		home = try values.decodeIfPresent(GenericTeam.self, forKey: .home)
		away = try values.decodeIfPresent(GenericTeam.self, forKey: .away)
	}
}
