import UIKit
import ReSwift
import RxCocoa
import RxSwift
import RxKeyboard

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var trackCollectionView: UICollectionView!
    @IBOutlet weak var btnLogout: UIButton!

    var arrayTracks: [Track] = []
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RxKeyboard.instance.visibleHeight.drive(onNext: { height in
            self.additionalSafeAreaInsets.bottom = height
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self, transform: {
            $0.select(TrackListViewState.init)
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    @IBAction func searchButton(_ sender: Any) {
        NSLog("CLICK searchButton")
        Search.search(completion: { arrayTracks in
            NSLog("EXITO")
        })
    }
    
    // MARK: - UICollectionViewDataSource
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath as IndexPath) as! TrackCollectionViewCell
        cell.nameLabel.text = self.arrayTracks[indexPath.row].title
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
    // MARK: - UISearchBarDelegate
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {  }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) { }
    
    
}

// MARK: StoreSubscriber

extension SearchViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = TrackListViewState

    func newState(state: TrackListViewState) {

        searchBar.text = state.searchBarText
        searchBar.showsCancelButton = state.searchBarShowsCancel

        switch (searchBar.isFirstResponder, state.searchBarFirstResponder) {
            case (true, false): searchBar.resignFirstResponder()
            case (false, true): searchBar.becomeFirstResponder()
            default: break
        }
    }
}
