import Foundation

// Note Object
class FBNote {
	var uID: String
	// The Note "Title"
	var name: String
	// The Note "Text"
	var content: String
	// The Parent Project
	var parentProjectUID: String


	// 2 Different inizializer
	init(uID: String, name: String, content: String,parentProjectUID: String) {
		self.uID = uID
		self.name = name
		self.content = content
		self.parentProjectUID = parentProjectUID
	}

	init(uID: String, data: [String: String]) {
		self.uID = uID
		self.name = data[S.name]!
		self.content = data[S.content]!
		self.parentProjectUID = data[S.parentProject]!
	}

	// Update the Data of the Note
	func updateData(name: String, content: String) {
		self.name = name
		self.content = content
	}
}
