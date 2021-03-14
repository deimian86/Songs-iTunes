import Foundation

class Track : Codable {

    var id: String?
    var name: String?
    var trackName: String?
    var artistName: String
    var collectionName: String
    var artistUrl: String?
    var artworkUrl: String?
    var url: String?
    var trackViewUrl: String?
    var genres: [Genre]?
    
    public func getTitle() -> String? {
       return name != nil ? name : trackName
    }
    
    public func getUrl() -> String? {
       return url != nil ? url : trackViewUrl
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case trackName
        case artistName
        case collectionName
        case artistUrl
        case artworkUrl = "artworkUrl100"
        case url
        case trackViewUrl
        case genres
    }
        
    init(id: String, name: String, trackName: String, artistName: String, collectionName: String, artistUrl: String, artworkUrl: String, url: String, trackViewUrl: String, genres: [Genre]) {
        self.id = id
        self.name = name
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artistUrl = artistUrl
        self.artworkUrl = artworkUrl
        self.url = url
        self.trackViewUrl = trackViewUrl
        self.genres = genres
    }
    
}
