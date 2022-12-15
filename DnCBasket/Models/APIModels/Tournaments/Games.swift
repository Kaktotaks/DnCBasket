import Foundation

struct Games: Codable {
	let played: Int?
	let win: Win?
	let lose: Lose?

	enum CodingKeys: String, CodingKey {

		case played = "played"
		case win = "win"
		case lose = "lose"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		played = try values.decodeIfPresent(Int.self, forKey: .played)
		win = try values.decodeIfPresent(Win.self, forKey: .win)
		lose = try values.decodeIfPresent(Lose.self, forKey: .lose)
	}

}
