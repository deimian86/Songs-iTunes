import Foundation
import Alamofire

class Search {

    static func searchTop100(completion: (([Track]) -> Void)? = nil) {
 
        let searchURL = "https://rss.itunes.apple.com/api/v1/es/apple-music/top-songs/all/100/explicit.json"

        AF.request(searchURL, method: .get, parameters: nil, encoding: JSONEncoding.default,  headers: nil).validate().responseDecodable{ (response: AFDataResponse<FeedResponse>) in
            let tracks = response.value?.feed.results ?? []
            completion!(tracks)
        }
    }
    
    static func searchByTerm(term: String, completion: (([Track]) -> Void)? = nil) {
 
        let searchURL = "https://itunes.apple.com/search"
        let params: Parameters = ["term": term, "media" : "music", "entity" : "song"]

        AF.request(searchURL, method: .get, parameters: params, encoding: URLEncoding.default,  headers: nil).validate().responseDecodable{ (response: AFDataResponse<SearchResponse>) in
            let tracks = response.value?.results ?? []
            completion!(tracks)
        }
    }
    
}
