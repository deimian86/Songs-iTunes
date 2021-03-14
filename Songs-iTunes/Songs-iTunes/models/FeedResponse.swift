import Foundation

class FeedResponse: Codable {
    
    let feed: Feed
    
    private enum CodingKeys: String, CodingKey {
        case feed
    }
    
    init(feed: Feed) {
        self.feed = feed
    }
}

