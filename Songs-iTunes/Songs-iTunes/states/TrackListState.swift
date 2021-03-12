import Foundation

struct TrackListViewState {
    
    let tracks: [Track]
    let searchBarText: String
    let searchBarShowsCancel: Bool
    let searchBarFirstResponder: Bool

    init(_ state: MainState) {
        tracks = state.tracksArray

        switch state.searchState {
            case .canceled:
                searchBarText = ""
                searchBarShowsCancel = false
                searchBarFirstResponder = false
            case .ready:
                searchBarText = ""
                searchBarShowsCancel = true
                searchBarFirstResponder = true
            case .searching(let text):
                searchBarText = text
                searchBarShowsCancel = true
                searchBarFirstResponder = true
        }
    }
}
