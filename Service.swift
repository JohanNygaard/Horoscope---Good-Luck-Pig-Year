import Foundation
class Service {
    static let shared = Service()
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed fetching app data", error)
                completion(nil, error)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch let jsonError {
                print("Failed to decode JSON data")
                completion(nil, jsonError)
            }
        }.resume()
    }
    func fetchTodayForecast(for sign: SignType, completion: @escaping (Forecast?, Error?) -> Void) {
        let urlString = "https://horoscope-api.herokuapp.com/horoscope/today/\(sign.rawValue.lowercased())"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchWeekForecast(for sign: SignType, completion: @escaping (Forecast?, Error?) -> Void) {
        let urlString = "https://horoscope-api.herokuapp.com/horoscope/week/\(sign.rawValue.lowercased())"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchMonthForecast(for sign: SignType, completion: @escaping (Forecast?, Error?) -> Void) {
        let urlString = "https://horoscope-api.herokuapp.com/horoscope/month/\(sign.rawValue.lowercased())"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    func fetchYearForecast(for sign: SignType, completion: @escaping (Forecast?, Error?) -> Void) {
        let urlString = "https://horoscope-api.herokuapp.com/horoscope/year/\(sign.rawValue.lowercased())"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}
