import Foundation

struct Country: Codable {
	let id: Int?
	let name: String?
	let code: String?
	let flag: String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case code = "code"
		case flag = "flag"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		flag = try values.decodeIfPresent(String.self, forKey: .flag)
	}

}
