
import Foundation

struct Scores: Codable {
	let homeScores: GenericScoresCount?
	let awayScores: GenericScoresCount?

	enum CodingKeys: String, CodingKey {
		case homeScores = "home"
		case awayScores = "away"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        homeScores = try values.decodeIfPresent(GenericScoresCount.self, forKey: .homeScores)
        awayScores = try values.decodeIfPresent(GenericScoresCount.self, forKey: .awayScores)
	}
}
