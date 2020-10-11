import UIKit

// A Project Costum-CollectionCell
class ProjectCCC: UICollectionViewCell {
	// The Textview of the Project Title
	@IBOutlet weak var projectTitle: UITextView!
	// Gets its projectsVC from the instantiator
	var projectsVC: ProjectsVC!
	// References a Project in the FB-Database
	var thisProject: FBProject!

    override func awakeFromNib() {
        super.awakeFromNib()
		// Sets Textview Delegate
		projectTitle.delegate = self
		// Default to interaction of title is false
		// It can be set true in the projectsVC via press+hold menu
		projectTitle.isUserInteractionEnabled = false

    }

}



extension ProjectCCC: UITextViewDelegate {

	func textViewDidEndEditing(_ textView: UITextView) {
		// After Editing set editmode back to false
		textView.isUserInteractionEnabled = false
		// And check for text, undo if empty or save if not
		if textView.text == "" {
			textView.text = thisProject.name
		}else {
			FBK.Projects.renameProject(project: thisProject, to: textView.text!)
		}
	}

	// Safety check if a linebreak exists in text and check how to save the text.
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
