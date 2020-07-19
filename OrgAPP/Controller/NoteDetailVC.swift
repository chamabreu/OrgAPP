//
//  NoteDetailVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 27.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit
import Firebase

class NoteDetailVC: UIViewController {

	@IBOutlet weak var noteTitleField: UITextField!
	@IBOutlet weak var noteContentField: UITextView!
	@IBOutlet weak var deleteNoteButton: UIBarButtonItem!


	var thisNote: FBNote!
	var thisProjectRef: DatabaseReference!
	var thisNoteReference: DatabaseReference!


    override func viewDidLoad() {
		super.viewDidLoad()

		thisNoteReference = Database.database().reference().child(FBK.loggedInUserID).child("\(S.notes)/\(thisNote.uID)")
		S.Funcs.createKeyboardToolbar(style: .done, target: noteContentField, execute: #selector(doneEditing))
		S.Funcs.createKeyboardToolbar(style: .done, target: noteTitleField, execute: #selector(doneEditing))

		self.title = thisNote.name

		noteTitleField.text = thisNote.name
		noteContentField.text = thisNote.content

		noteTitleField.delegate = self
		noteContentField.delegate = self

		if noteTitleField.text == "" {
			noteTitleField.becomeFirstResponder()
		}

	}



	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		if noteTitleField.isFirstResponder {
			noteTitleField.resignFirstResponder()
		}
		if noteContentField.isFirstResponder {
			noteContentField.resignFirstResponder()
		}
		
		if thisNote.name == "MARKEDFORDELETION" {
			
			FBK.Notes.deleteNote(with: thisNote.uID, in: thisProjectRef.key!)
		}else {
			if thisNote.uID == "NewNote" {
				FBK.Notes.saveNew(note: thisNote, in: thisProjectRef.key!)
			}else {
				FBK.Notes.updateExisting(note: thisNote, in: thisProjectRef)
			}
		}

	}

	@objc func doneEditing() {
		if noteTitleField.isFirstResponder {
			noteTitleField.resignFirstResponder()
		}
		if noteContentField.isFirstResponder {
			noteContentField.resignFirstResponder()
		}

	}


	@IBAction func deleteNoteButtonPress(_ sender: UIBarButtonItem) {
		if noteTitleField.isFirstResponder {
			noteTitleField.resignFirstResponder()
		}
		if noteContentField.isFirstResponder {
			noteContentField.resignFirstResponder()
		}
		
		thisNote.name = "MARKEDFORDELETION"
		self.navigationController?.popViewController(animated: true)
	}



}

extension NoteDetailVC: UITextFieldDelegate, UITextViewDelegate {

	//MARK: -  Text FIELD is for Title
	func textFieldDidBeginEditing(_ textField: UITextField) {
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		noteContentField.becomeFirstResponder()
		return true
	}


	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == "" {
			thisNote.name = "Need Name!"
			textField.text = thisNote.name
			self.title = thisNote.name
		}else {
			thisNote.name = textField.text!
			self.title = thisNote.name
		}
		textField.resignFirstResponder()

	}







	//MARK: -  Text VIEW is for Content
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == "Input content here..." {
			textView.text = ""
		}

	}

	func textViewDidEndEditing(_ textView: UITextView) {
		thisNote.content = textView.text
		textView.resignFirstResponder()
	}


}
