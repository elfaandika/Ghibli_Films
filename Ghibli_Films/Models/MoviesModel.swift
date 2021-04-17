// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let filmsMode = try? newJSONDecoder().decode(FilmsMode.self, from: jsonData)

import Foundation

// MARK: - MoviesMode
struct MoviesModel: Codable {
    var id: String
    var title: String
    var description: String
    var director: String
    var producer: String
    var release_date: String
}
