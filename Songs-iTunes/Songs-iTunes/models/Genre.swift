import Foundation

class Genre: Codable {
    
    let genreId: String?
    let name: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case genreId
        case name
        case url
    }
    
    init(genreId: String, name: String, url: String) {
        self.genreId = genreId
        self.name = name
        self.url = url
    }
    
}
