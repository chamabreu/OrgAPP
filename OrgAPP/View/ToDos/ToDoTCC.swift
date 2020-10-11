import UIKit

// The Costum Table View Cell for a ToDo in the ToDosVC
class ToDoTCC: UITableViewCell {
	// Properties of the Cell
	@IBOutlet weak var doneButton: UIButton!
	@IBOutlet weak var toDoTitle: UITextField!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var infoButton: UIButton!

	// References
	var toDosVC: ToDosVC!
	var thisToDo: FBToDo!

	override func awakeFromNib() {
        super.awakeFromNib()
		// Sets delegate of Textfield to self
		toDoTitle.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

	// Button click to check a ToDo
	@IBAction func markAsDone(_ sender: UIButton) {
		// Database Call to toggle "done" propertie of FBToDo
		toDosVC.switchCellDoneState(toDo: thisToDo, cell: self)
	}

	// Go to the Detail View "ToDoDetailVC" of selected ToDo
	@IBAction func infoButton(_ sender: UIButton) {
		// Reference the selected ToDo
		toDosVC.toDoInfoButton(toDo: thisToDo)
	}
}

// calling TextDelegate Methods from here in the toDosVC
extension ToDoTCC: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		toDosVC.textFieldDidBeginEditing(textField, toDo: thisToDo, cell: self)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		toDosVC.textFieldShouldReturn(textField, toDo: thisToDo, cell: self)
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		return toDosVC.textFieldDidEndEditing(textField, toDo: thisToDo, cell: self)
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return toDosVC.textFieldShouldBeginEditing(textField)
	}

}

