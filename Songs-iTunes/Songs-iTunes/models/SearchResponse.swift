import Foundation

class SearchResponse: Codable {
    
    let results: [Track]

    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(results: [Track]) {
        self.results = results
    }
}

