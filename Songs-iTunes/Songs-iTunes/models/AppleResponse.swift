import Foundation

class AppleResponse: Codable {
    
    let feed: Feed
    
    private enum CodingKeys: String, CodingKey {
        case feed
    }
    
    init(feed: Feed) {
        self.feed = feed
    }
}

