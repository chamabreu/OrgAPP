import UIKit

// The Header of a Category Section
class ProjectHeaderCHC: UICollectionReusableView {
	// Title of Category
	@IBOutlet weak var headerLabel: UILabel!
	// A Button to delete Categorys if empty
	@IBOutlet weak var deleteCategory: UIButton!

	// get the own category on instantiation
	var thisCategory: FBCategory!
	//
	var projectsVC: ProjectsVC!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func deleteCategory(_ sender: UIButton) {
		FBK.Categorys.deleteCategory(withID: thisCategory.uID)
//		print("DUMMY BUTTON DELETE CATEGORY")
	}

    
}
