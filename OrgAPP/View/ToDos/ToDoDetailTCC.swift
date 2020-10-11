import UIKit

// The Detail-View of an ToDo - gets called if "i" button is pressed in ToDosVC
class ToDoDetailTCC: UITableViewCell {
	// References
	@IBOutlet weak var toDoTitleTF: UITextField!
	@IBOutlet weak var toDoDescriptionTF: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

	


    
}
