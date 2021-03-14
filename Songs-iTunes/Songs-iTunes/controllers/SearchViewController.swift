import UIKit
import SnapKit
import MaterialComponents.MaterialChips

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var trackCollectionView: UICollectionView!
    @IBOutlet weak var chipsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    var arrayTracks: [Track] = []
    var arrayTracksFiltered: [Track] = []
    
    var arraySearchTerms = ["top100", "agua", "mar", "sed", "oceano", "playa"]

    var scrollView: UIScrollView!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTop100()
        self.initChipsView()
        self.initSearchBar()
    }
    
    func initSearchBar() {
        self.searchBar.placeholder = NSLocalizedString("buscar", comment: "")
    }
    
    func initChipsView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        chipsView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
             make.edges.equalToSuperview()
        }
        var tagCount:Int = 0;
        for str in arraySearchTerms {
            let chipView = MDCChipView()
            chipView.titleLabel.text = NSLocalizedString(str, comment: "")
            chipView.sizeToFit()
            chipView.tag = tagCount
            chipView.addTarget(self, action: #selector(search), for: .touchUpInside)
            stackView.addArrangedSubview(chipView)
            tagCount+=1
        }
    }
    
    @IBAction func search(_ sender: UIView) {
        print(sender.tag)
        if(sender.tag == 0) {
            self.searchTop100()
        } else {
            self.searchByTerm(term: arraySearchTerms[sender.tag])
        }
    }
    
    func searchByTerm(term: String) {
        Search.searchByTerm(term: term, completion: { arrayTracks in
            self.arrayTracks = arrayTracks
            self.arrayTracksFiltered = arrayTracks
            self.trackCollectionView.reloadData()
        })
    }
        
    func searchTop100() {
        Search.searchTop100(completion: { arrayTracks in
            self.arrayTracks = arrayTracks
            self.arrayTracksFiltered = arrayTracks
            self.trackCollectionView.reloadData()
        })
    }
        
    // MARK: - UICollectionViewDataSource
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayTracksFiltered.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath as IndexPath) as! TrackCollectionViewCell
        cell.nameLabel.text = self.arrayTracksFiltered[indexPath.row].getTitle()
        cell.imageView.image = nil
        DispatchQueue.global(qos: .background).async {
            guard let strUrl = self.arrayTracksFiltered[indexPath.row].artworkUrl else { return }
            guard let url = URL(string: strUrl) else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: self.arrayTracksFiltered[indexPath.item].getUrl()!) else { return }
        UIApplication.shared.open(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    // MARK: - UISearchBarDelegate
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrayTracksFiltered.removeAll()
        for item in self.arrayTracks {
            if (self.checkFilters(item: item)) {
                self.arrayTracksFiltered.append(item)
            }
        }
        if (searchBar.text!.isEmpty) {
            self.arrayTracksFiltered = self.arrayTracks
        }
        self.trackCollectionView.reloadData()
    }
    
    
    func checkFilters(item: Track) -> Bool {
        if (item.getTitle()!.lowercased().contains(searchBar.text!.lowercased())) {
           return true;
        }
        if (item.collectionName.lowercased().contains(searchBar.text!.lowercased())) {
            return true;
        }
        if (item.artistName.lowercased().contains(searchBar.text!.lowercased())) {
            return true;
        }
        return false;
    }
          
}
