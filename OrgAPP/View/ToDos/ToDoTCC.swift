//
//  ToDoTCC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 20.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit

class ToDoTCC: UITableViewCell {
	@IBOutlet weak var doneButton: UIButton!
	@IBOutlet weak var toDoTitle: UITextField!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var infoButton: UIButton!
	
	var toDosVC: ToDosVC!
	var thisToDo: FBToDo!

	override func awakeFromNib() {
        super.awakeFromNib()
		toDoTitle.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	@IBAction func markAsDone(_ sender: UIButton) {
		toDosVC.switchCellDoneState(toDo: thisToDo, cell: self)
	}


	@IBAction func infoButton(_ sender: UIButton) {
		toDosVC.toDoInfoButton(toDo: thisToDo)
	}
}


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

