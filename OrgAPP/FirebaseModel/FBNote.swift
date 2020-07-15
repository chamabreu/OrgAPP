
import Foundation
class FBNote {
	var uID: String
	var name: String
	var content: String
	var parentProjectUID: String

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

	func updateData(name: String, content: String) {
		self.name = name
		self.content = content
	}
}
