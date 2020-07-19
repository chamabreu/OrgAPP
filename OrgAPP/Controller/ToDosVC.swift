

import UIKit
import Firebase

class ToDosVC: UITableViewController {
	@IBOutlet weak var toDosTableView: UITableView!

	var tabBarVC: ProjectTabBarVC!
	var thisProject: DatabaseReference!
	var toDosDataBase: DatabaseReference!

	var allToDoUIDs: [String] = []
	var doneToDos: [FBToDo] = []
	var unDoneToDos: [FBToDo] = []

	var hideDone: Bool = false
	var activeCell: ToDoTCC?

	var optionsBarButton: UIBarButtonItem!
	var keyBoardToolBar = UIToolbar()

	var creationProcess: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
		tabBarVC = self.parent as? ProjectTabBarVC
		thisProject = tabBarVC.thisProject

		toDosDataBase = Database.database().reference().child(FBK.loggedInUserID).child(S.toDos)

		let singleLoadDispatcher = DispatchGroup()
		singleLoadDispatcher.enter()
		FBK.ToDos.loadAlltoDosSingleTime(of: thisProject, dispatcher: singleLoadDispatcher, toDoVC: self)
		singleLoadDispatcher.notify(queue: .main) {
			self.toDosTableView.reloadData()
			FBK.ToDos.childAddedObserver(allToDoUIDs: self.allToDoUIDs, toDoVC: self, thisProject: self.thisProject)
		}


		FBK.ToDos.childRemovedObserver(toDoVC: self)
		FBK.ToDos.toDoChangedObserver(toDoVC: self)

		toDosTableView.register(UINib(nibName: S.CustomCells.toDoCell, bundle: nil), forCellReuseIdentifier: S.CustomCells.toDoCell)

		let emptyTap = UITapGestureRecognizer(target: self, action: #selector(tapInTable))
		toDosTableView.addGestureRecognizer(emptyTap)

		keyBoardToolBar.sizeToFit()
		let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
		keyBoardToolBar.setItems([flexibleSpace,doneButton], animated: true)
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		self.parent?.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(optionsButton))]
		optionsBarButton = self.parent?.navigationItem.rightBarButtonItem
	}

	//MARK: -  Other Functions
	@objc func optionsButton() {
		if toDosTableView.isEditing {
			toDosTableView.isEditing = !toDosTableView.isEditing
			optionsBarButton.title = "Options"
			optionsBarButton.style = .plain

			for (index, toDo) in unDoneToDos.enumerated() {
				thisProject.child("\(S.toDos)/\(toDo.uID)").setValue("Undone #\(index)", andPriority: index)
			}

		}else {

			let optionsAlert = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
			let showHideDone = UIAlertAction(title: "Show Hide Done", style: .default) { (_) in
				self.hideDone = !self.hideDone
				self.toDosTableView.reloadData()
			}

			let rearrange = UIAlertAction(title: "Rearrange", style: .default) { (_) in
				self.optionsBarButton.title = "Done"
				self.optionsBarButton.style = .done
				self.toDosTableView.isEditing = !self.toDosTableView.isEditing

			}

			let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

			optionsAlert.addAction(showHideDone)
			optionsAlert.addAction(rearrange)
			optionsAlert.addAction(cancel)
			present(optionsAlert, animated: true, completion: nil)
		}




	}

	func switchCellDoneState(toDo: FBToDo, cell: ToDoTCC) {
		if activeCell == nil {
			if toDo.done {
				toDosDataBase.child("\(toDo.uID)/\(S.done)").setValue(!toDo.done)
				if let doneToDoIndex = doneToDos.firstIndex(where: { (toDoFromArray) -> Bool in
					if toDoFromArray.uID == toDo.uID {
						toDoFromArray.done = !toDoFromArray.done
						unDoneToDos.append(toDoFromArray)
					}
					return toDoFromArray.uID == toDo.uID
				}) {
					doneToDos.remove(at: doneToDoIndex)
				}
			}else {
				toDosDataBase.child("\(toDo.uID)/\(S.done)").setValue(!toDo.done)
				thisProject.child("\(S.toDos)/\(toDo.uID)").setValue("DONE")
				if let unDoneToDoIndex = unDoneToDos.firstIndex(where: { (toDoFromArray) -> Bool in
					if toDoFromArray.uID == toDo.uID {
						toDoFromArray.done = !toDoFromArray.done
						doneToDos.append(toDoFromArray)
					}
					return toDoFromArray.uID == toDo.uID
				}) {
					unDoneToDos.remove(at: unDoneToDoIndex)
				}
			}

			for (index, toDo) in unDoneToDos.enumerated() {
				thisProject.child("\(S.toDos)/\(toDo.uID)").setValue("Undone #\(index)", andPriority: index)
			}
			toDosTableView.reloadData()
		}
	}

	func toDoInfoButton(toDo: FBToDo){
		deactivateCell(resign: true)
		performSegue(withIdentifier: S.Segues.toDoDetail, sender: toDo)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is ToDoDetailVC {
			let dest = segue.destination as! ToDoDetailVC
			dest.thisToDo = sender as? FBToDo
			dest.toDosVC = self
		}
	}

	func deactivateCell(resign: Bool) {
		if activeCell != nil {
			if resign {
				activeCell?.toDoTitle.resignFirstResponder()
			}
			activeCell = nil
		}
	}

	@objc func doneButtonPressed() {
		if activeCell != nil {
			activeCell?.toDoTitle.resignFirstResponder()
			activeCell = nil
		}
	}

	//MARK: -  TABLE VIEW DELEGATE AND DATASOURCE
	override func numberOfSections(in tableView: UITableView) -> Int {
		return hideDone ? 1 : 2
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return unDoneToDos.count
		case 1:
			return doneToDos.count
		default:
			return 0
		}
	}


	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "To Do..."
		case 1:
			return hideDone ? "" : "...done!"
		default:
			return ""
		}

	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: S.CustomCells.toDoCell, for: indexPath) as! ToDoTCC
		cell.toDosVC = self
		switch indexPath.section {
		case 0:
			cell.showsReorderControl = tableView.isEditing ? true : false
			cell.thisToDo = unDoneToDos[indexPath.row] // give Cell a referenced ToDo from ToDoArray
			cell.toDoTitle.text = cell.thisToDo.name // set its title to the toDoName

			if cell.thisToDo.toDoDescription == "" { // If there is no description, hide it
				cell.descriptionLabel.isHidden = true
			}else { // Or fill it and unHide it
				cell.descriptionLabel.text = cell.thisToDo.toDoDescription
				cell.descriptionLabel.isHidden = false
			}

			cell.doneButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal) // Mark CellDoneButton as unfilled
			return cell

		case 1:
			cell.thisToDo = doneToDos[indexPath.row] // give Cell a referenced ToDo from ToDoarray
			cell.toDoTitle.text = cell.thisToDo.name // show Title

			if cell.thisToDo.toDoDescription == "" { // Description Hide
				cell.descriptionLabel.isHidden = true
			}else { // or noHide
				cell.descriptionLabel.text = cell.thisToDo.toDoDescription
				cell.descriptionLabel.isHidden = false
			}

			cell.doneButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal) // Fill DoneButton
			return cell
		default:
			return cell
		}

	}

	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		if activeCell != nil {
			return nil
		}else {
			let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
				if let cell = self.toDosTableView.cellForRow(at: indexPath) as? ToDoTCC {
					if let toDotoDelete = cell.thisToDo {
						FBK.ToDos.deleteToDo(with: toDotoDelete.uID, in: self.thisProject.key!)
					}

				}
			}

			let config = UISwipeActionsConfiguration(actions: [delete])
			return config
		}

	}

	override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .none
	}


	override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		return false
	}

	override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

		let toDo = unDoneToDos[sourceIndexPath.row]
		unDoneToDos.remove(at: sourceIndexPath.row)
		unDoneToDos.insert(toDo, at: destinationIndexPath.row)

	}

	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return true
	}


	@objc func tapInTable(gesture: UITapGestureRecognizer) {
		if toDosTableView.indexPathForRow(at: gesture.location(in: toDosTableView)) == nil {
			deactivateCell(resign: false)
			creationProcess = true
			FBK.ToDos.createNewToDo(in: thisProject.key!, unDoneToDosCountPlusOne: unDoneToDos.count + 1)
		}

	}
}



//MARK: -  UITEXTFIELD Functions
extension ToDosVC: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

		if toDosTableView.isEditing {
			return false
		}else {
			textField.inputAccessoryView = keyBoardToolBar
			return true
		}
	}

	func textFieldDidBeginEditing(_ textField: UITextField, toDo: FBToDo, cell: ToDoTCC) {
		cell.infoButton.isHidden = false
		optionsBarButton.isEnabled = false
		activeCell = cell
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			self.toDosTableView.scrollToRow(at: self.toDosTableView.indexPath(for: cell)!, at: .bottom, animated: false)
		}
	}



	func textFieldShouldReturn(_ textField: UITextField, toDo: FBToDo, cell: ToDoTCC) -> Bool {
		if toDosTableView.indexPath(for: cell) != nil { // wahrscheinlich wenn die Zelle sichtbar ist
			if textField.text == "" { // wenn darin kein Text
				deactivateCell(resign: true) // deaktiviere die Zelle, und erstelle keine Neue durch den resign
			}else {
				deactivateCell(resign: false) // Deaktiviere die Zelle, resigne NICHT und erstelle eine neue per createNewToDo
				creationProcess = true
				FBK.ToDos.createNewToDo(in: thisProject.key!, unDoneToDosCountPlusOne: unDoneToDos.count + 1)
			}
		}else {
			deactivateCell(resign: true)
		}
		return true
	}


	func textFieldDidEndEditing(_ textField: UITextField, toDo: FBToDo, cell: ToDoTCC) {
		cell.infoButton.isHidden = true

		if textField.text == "" {
			FBK.ToDos.deleteToDo(with: toDo.uID, in: thisProject.key!)
		}else {
			toDosDataBase.child("\(toDo.uID)/\(S.name)").setValue(textField.text!)
		}
		optionsBarButton.isEnabled = true

	}



}

