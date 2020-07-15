import UIKit
import Firebase

class NotesVC: UIViewController {
	@IBOutlet weak var notesTableView: UITableView!
	@IBOutlet weak var addNoteButton: UIButton!

	var tabBarVC: ProjectTabBarVC!

//	var notesDataBase: DatabaseReference!
	var thisProject: DatabaseReference!
	var notes: [FBNote] = []

	var hideContent: Bool = true
	var editNotesButton: UIBarButtonItem!



    override func viewDidLoad() {
        super.viewDidLoad()

		tabBarVC = self.parent as? ProjectTabBarVC
		thisProject = tabBarVC.thisProject

//		notesDataBase = Database.database().reference().child(S.notes)
		let mainDispatcher = DispatchGroup()
		mainDispatcher.enter()
		FBK.Notes.loadAllNotes(of: thisProject, mainDispatcher: mainDispatcher, noteVC: self)
		mainDispatcher.notify(queue: .main) {
			self.notesTableView.reloadData()
			FBK.Notes.childAddedObserver(notesVC: self)
			FBK.Notes.childChangedObserver(notesVC: self)
			FBK.Notes.childRemovedObserver(notesVC: self)
		}




		notesTableView.rowHeight = UITableView.automaticDimension
		notesTableView.estimatedRowHeight = 600
		notesTableView.delegate = self
		notesTableView.dataSource = self
		notesTableView.register(UINib(nibName: S.CustomCells.noteCell, bundle: nil), forCellReuseIdentifier: S.CustomCells.noteCell)

		let tableTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTableNil))
		notesTableView.addGestureRecognizer(tableTapRecognizer)
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		hideContent = true

		self.parent?.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Show note", style: .plain, target: self, action: #selector(previewNoteButton))]
		editNotesButton = self.parent?.navigationItem.rightBarButtonItem

	}


	@IBAction func addNoteAction(_ sender: UIButton) {
		performSegue(withIdentifier: S.Segues.showNote, sender: nil)
	}



	@objc func previewNoteButton() {
		hideContent = !hideContent
		if hideContent {
			editNotesButton.title = "Show note"

		}else {
			editNotesButton.title = "Hide note"
		}

		notesTableView.reloadData()
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == S.Segues.showNote {
			let noteDetail = segue.destination as! NoteDetailVC
			noteDetail.thisProjectRef = thisProject
			if sender is NoteTCC {
				noteDetail.thisNote = (sender as! NoteTCC).thisNote
			}else {
				noteDetail.thisNote = FBNote(uID: "NewNote", name: "", content: "", parentProjectUID: thisProject.key!)
			}


		}
	}

	@objc func tapTableNil(tap: UITapGestureRecognizer) {
		let tappedIndexPath: IndexPath? = notesTableView.indexPathForRow(at: tap.location(in: notesTableView))
		if tappedIndexPath == nil {
			performSegue(withIdentifier: S.Segues.showNote, sender: nil)

		}else {
			performSegue(withIdentifier: S.Segues.showNote, sender: notesTableView.cellForRow(at: tappedIndexPath!))

		}
	}



}

//MARK: -  TABLE VIEW DELEGATE AND DATASOURCE
extension NotesVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: S.CustomCells.noteCell, for: indexPath) as! NoteTCC

		cell.thisNote = notes[indexPath.row]
		cell.titleLabel.text = cell.thisNote.name
		cell.contentPreviewLabel.text = cell.thisNote.content

		if hideContent {
			cell.contentPreviewLabel.isHidden = true
		}else {
			cell.contentPreviewLabel.isHidden = false

		}

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		notesTableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: S.Segues.showNote, sender: notesTableView.cellForRow(at: indexPath))

	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
			let noteToDelete = (self.notesTableView.cellForRow(at: indexPath) as! NoteTCC).thisNote!
			FBK.Notes.deleteNote(with: noteToDelete.uID, in: self.thisProject.key!)

		}

		return UISwipeActionsConfiguration(actions: [delete])

	}



}



