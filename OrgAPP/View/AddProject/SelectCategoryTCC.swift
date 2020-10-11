import UIKit

// A Custom Table View Cell for selecting a existing Category in ProjectCreation-Process
class SelectCategoryTCC: UITableViewCell {
	// The category Title
	@IBOutlet weak var categoryLabel: UILabel!
	// The button which appears if a category name is given of no existing category
	@IBOutlet weak var addCatButton: UIButton!
	// A Reference to a category
	var thisCategory: FBCategory!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
