import Foundation

class FBCategory {
	var uID: String
	var name: String
	var projects: [FBProject]

	init(uID: String, name: String) {
		self.uID = uID
		self.name = name
		self.projects = []
	}
}
