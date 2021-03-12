import Foundation
import ReSwift

enum MainStateAction: Action {

    case fetchTracks(tracks: [Track])
    
    case showTrackDetail(Track)
    case hideTrackDetail
    
    case readySearch
    case search(String)
    case cancelSearch
    
}
