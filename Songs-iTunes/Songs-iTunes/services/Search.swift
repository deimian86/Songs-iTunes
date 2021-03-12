import Foundation
import Alamofire

class Search {

    static func search(completion: (([Track]) -> Void)? = nil) {
 
        let searchURL = "https://rss.itunes.apple.com/api/v1/es/apple-music/top-songs/all/100/explicit.json"

        AF.request(searchURL, method: .get, parameters: nil, encoding: JSONEncoding.default,  headers: nil).validate().responseDecodable{ (response: AFDataResponse<AppleResponse>) in
            let tracks = response.value?.feed.results ?? []
            for track in tracks {
                print(track.title)
            }
        }
    }
}
