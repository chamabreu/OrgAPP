//
//  ToDoDetailVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 30.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//



import UIKit
import Firebase

class ToDoDetailVC: UIViewController {
	@IBOutlet weak var toDoDetailTableView: UITableView!

	@IBOutlet weak var saveButton: UIButton!

	var thisToDo: FBToDo!
	var toDosVC: ToDosVC!

	var toDoTitleTF: UITextField!
	var toDoDescriptionTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
		toDoDetailTableView.delegate = self
		toDoDetailTableView.dataSource = self
		toDoDetailTableView.register(UINib(nibName: S.CustomCells.toDoDetailCell, bundle: nil), forCellReuseIdentifier: S.CustomCells.toDoDetailCell)


    }

	@IBAction func saveButton(_ sender: UIButton) {
		toDoTitleTF.resignFirstResponder()
		toDoDescriptionTF.resignFirstResponder()
		let toDoRef = Database.database().reference().child("\(S.toDos)/\(thisToDo.uID)")
//		toDoRef.child(S.name).setValue(thisToDo.name)
//		toDoRef.child(S.toDoDescription).setValue(thisToDo.toDoDescription)
		toDoRef.updateChildValues([S.name: thisToDo.name, S.toDoDescription: thisToDo.toDoDescription])
//		RealmFuncs.Edit.renameToDo(thisToDo, newName: self.toDoTitleTF.text!)
//		RealmFuncs.Edit.changeToDoDescription(thisToDo, description: self.toDoDescriptionTF.text!)
//		toDosVC.toDosTableView.reloadData()
		self.dismiss(animated: true, completion: nil)
	}

}

//MARK: -  UITableView Delegate & DataSource
extension ToDoDetailVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}else {
			return 0
		}
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let derBalken = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
		derBalken.backgroundColor = .secondarySystemBackground
		return derBalken
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: S.CustomCells.toDoDetailCell, for: indexPath) as! ToDoDetailTCC
		self.toDoTitleTF = cell.toDoTitleTF
		self.toDoDescriptionTF = cell.toDoDescriptionTF
		cell.toDoTitleTF.text = thisToDo.name
		cell.toDoDescriptionTF.text = thisToDo.toDoDescription
		cell.toDoTitleTF.delegate = self
		cell.toDoDescriptionTF.delegate = self
		return cell
	}


}//MARK: -  UITextField Delegate
extension ToDoDetailVC: UITextFieldDelegate {
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == toDoTitleTF {
			toDoDescriptionTF.becomeFirstResponder()
		}else {
			textField.endEditing(true)
		}
		return true
	}

	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		print(#function)

		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField == toDoTitleTF {
			thisToDo.name = textField.text!
//			RealmFuncs.Edit.renameToDo(thisToDo, newName: textField.text!)
		}else if textField == toDoDescriptionTF {
			thisToDo.toDoDescription = textField.text!
//			RealmFuncs.Edit.changeToDoDescription(thisToDo, description: textField.text!)
		}
		textField.resignFirstResponder()


	}
}



