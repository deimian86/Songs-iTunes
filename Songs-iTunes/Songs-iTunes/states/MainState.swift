import Foundation
import ReSwift
import ReSwiftThunk

enum SearchState: Equatable {
    case canceled
    case ready
    case searching(String)
}

enum TrackListState {
    
    case hideDetail
    case showDetail(Track)
    case loadTracks(values: [Track])

    var track: Track? {
        switch self {
            case .hideDetail:
                return nil
            case .showDetail(let track):
                return track
            case .loadTracks:
                return nil
        }
    }
}

struct MainState: StateType {
    var searchState: SearchState = .canceled
    var trackState: TrackListState = .hideDetail
    var tracksArray: Array<Track> = Array<Track>()
}

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {

        case .fetchTracks(tracks: let tracks):
            state.trackState = .loadTracks(values: tracks)
    
        case .hideTrackDetail:
            state.trackState = .hideDetail
            
        case .showTrackDetail(let track):
            state.trackState = .showDetail(track)
            
        case .cancelSearch:
            state.searchState = .canceled
            
        case .readySearch:
            state.searchState = .ready
            
        case .search(let query):
            state.searchState = .searching(query)
    
    }

    return state
}

let thunksMiddleware: Middleware<MainState> = createThunkMiddleware()

let mainStore = Store(
    reducer: mainReducer,
    state: MainState(),
    middleware: [thunksMiddleware]
)
