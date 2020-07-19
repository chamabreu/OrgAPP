//
//  ProjectsCCC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 20.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit

class ProjectCCC: UICollectionViewCell {
	@IBOutlet weak var projectTitle: UITextView!
	var projectsVC: ProjectsVC!

	var thisProject: FBProject!

    override func awakeFromNib() {
        super.awakeFromNib()

		projectTitle.delegate = self
		projectTitle.isUserInteractionEnabled = false

    }

}



extension ProjectCCC: UITextViewDelegate {

	func textViewDidEndEditing(_ textView: UITextView) {
		textView.isUserInteractionEnabled = false
		if textView.text == "" {
			textView.text = thisProject.name
		}else {
			FBK.Projects.renameProject(project: thisProject, to: textView.text!)
		}
	}

	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			if textView.text != "" {
				textView.endEditing(true)
				return false
			}else {
				textView.text = thisProject.name
				textView.endEditing(true)
				return false
			}
		}else {
			return true
		}
	}

}
