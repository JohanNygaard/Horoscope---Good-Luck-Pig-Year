import Foundation
struct Forecast: Decodable {
    var date: String?
    var week: String?
    var month: String?
    var year: String?
    let sunsign: String?
    let horoscope: String?
}
