import Foundation

class FBToDo {
	var uID: String
	var name: String
	var toDoDescription: String
	var parentProjectUID : String
	var done: Bool
	

	init(uID: String, name: String, toDoDescription: String, parentProjectUID: String, done: Bool) {
		self.uID = uID
		self.name = name
		self.toDoDescription = toDoDescription
		self.parentProjectUID = parentProjectUID
		self.done = done
	}

	init(uID: String, data: [String: AnyObject]) {
		self.uID = uID
		self.name = data[S.name] as! String
		self.toDoDescription = data[S.toDoDescription] as! String
		self.parentProjectUID = data[S.parentProject] as! String
		self.done = data[S.done] as! Bool
	}

	func updateData(uID: String, data: [String: AnyObject]) {
		self.uID = uID
		self.name = data[S.name] as! String
		self.toDoDescription = data[S.toDoDescription] as! String
		self.parentProjectUID = data[S.parentProject] as! String
		self.done = data[S.done] as! Bool
	}
}
