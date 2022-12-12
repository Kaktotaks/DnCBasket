import Foundation

struct Home: Codable {
	let quarter1: Int?
	let quarter2: Int?
	let quarter3: Int?
	let quarter4: Int?
	let overTime: String?
	let total: Int?

	enum CodingKeys: String, CodingKey {

		case quarter1 = "quarter_1"
		case quarter2 = "quarter_2"
		case quarter3 = "quarter_3"
		case quarter4 = "quarter_4"
		case overTime = "over_time"
		case total = "total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		quarter1 = try values.decodeIfPresent(Int.self, forKey: .quarter1)
		quarter2 = try values.decodeIfPresent(Int.self, forKey: .quarter2)
		quarter3 = try values.decodeIfPresent(Int.self, forKey: .quarter3)
		quarter4 = try values.decodeIfPresent(Int.self, forKey: .quarter4)
		overTime = try values.decodeIfPresent(String.self, forKey: .overTime)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}

}
