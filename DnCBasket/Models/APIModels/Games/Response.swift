import Foundation

struct Response: Codable {
	let id: Int?
	let date: String?
	let time: String?
	let timestamp: Int?
	let timezone: String?
	let stage: String?
	let week: String?
	let status: Status?
	let league: League?
	let country: Country?
	let teams: Teams?
	let scores: Scores?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case date = "date"
		case time = "time"
		case timestamp = "timestamp"
		case timezone = "timezone"
		case stage = "stage"
		case week = "week"
		case status = "status"
		case league = "league"
		case country = "country"
		case teams = "teams"
		case scores = "scores"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		time = try values.decodeIfPresent(String.self, forKey: .time)
		timestamp = try values.decodeIfPresent(Int.self, forKey: .timestamp)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		stage = try values.decodeIfPresent(String.self, forKey: .stage)
		week = try values.decodeIfPresent(String.self, forKey: .week)
		status = try values.decodeIfPresent(Status.self, forKey: .status)
		league = try values.decodeIfPresent(League.self, forKey: .league)
		country = try values.decodeIfPresent(Country.self, forKey: .country)
		teams = try values.decodeIfPresent(Teams.self, forKey: .teams)
		scores = try values.decodeIfPresent(Scores.self, forKey: .scores)
	}

}
