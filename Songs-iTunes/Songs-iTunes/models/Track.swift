import Foundation

class Track : Codable {

    let id: String?
    let title: String
    let collectionName: String?
    let releaseDate: String?
    let copyright: String?
    let artistUrl: String?
    let artworkUrl: String?
    let url: String?
    let genres: [Genre]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case collectionName
        case releaseDate
        case copyright
        case artistUrl
        case artworkUrl = "artworkUrl100"
        case url
        case genres
    }
    
    init(id: String, title: String, collectionName: String, releaseDate: String, copyright: String, artistUrl: String, artworkUrl: String, url: String, genres: [Genre]) {
        self.id = id
        self.title = title
        self.collectionName = collectionName
        self.releaseDate = releaseDate
        self.copyright = copyright
        self.artistUrl = artistUrl
        self.artworkUrl = artworkUrl
        self.url = url
        self.genres = genres
    }
    
}
