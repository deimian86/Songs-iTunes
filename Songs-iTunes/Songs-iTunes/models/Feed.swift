import Foundation

class Feed: Codable {
    
    let title: String?
    let id: String?
    let copyright: String?
    let icon: String?
    let updated: String?
    let results: [Track]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case id
        case copyright
        case icon
        case updated
        case results
    }
    
    init(title: String, id: String, copyright: String, icon: String, updated: String, results: [Track]) {
        self.title = title
        self.id = id
        self.copyright = copyright
        self.icon = icon
        self.updated = updated
        self.results = results
    }
}
    
