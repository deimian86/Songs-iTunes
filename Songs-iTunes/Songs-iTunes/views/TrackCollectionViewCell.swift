import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var outerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCoverStyle()
    }
    
    func setCoverStyle() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.5
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 4
        outerView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 10).cgPath
    }
    
}
