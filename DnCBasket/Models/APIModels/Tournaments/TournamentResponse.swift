import Foundation

struct TournamentResponse: Codable {
	let position: Int?
	let stage: String?
    let group: Group?
	let team: GenericTeam?
	let league: League?
	let country: Country?
	let games: Games?
	let points: Points?
	let form: String?
	let description: String?

	enum CodingKeys: String, CodingKey {

		case position = "position"
		case stage = "stage"
		case group = "group"
		case team = "team"
		case league = "league"
		case country = "country"
		case games = "games"
		case points = "points"
		case form = "form"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		position = try values.decodeIfPresent(Int.self, forKey: .position)
		stage = try values.decodeIfPresent(String.self, forKey: .stage)
		group = try values.decodeIfPresent(Group.self, forKey: .group)
		team = try values.decodeIfPresent(GenericTeam.self, forKey: .team)
		league = try values.decodeIfPresent(League.self, forKey: .league)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		games = try values.decodeIfPresent(Games.self, forKey: .games)
		points = try values.decodeIfPresent(Points.self, forKey: .points)
		form = try values.decodeIfPresent(String.self, forKey: .form)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}
}
