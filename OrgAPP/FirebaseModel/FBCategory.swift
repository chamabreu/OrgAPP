import Foundation


// Category Object
class FBCategory {
	var uID: String
	var name: String
	// Cotaining Projects Array
	var projects: [FBProject]

	init(uID: String, name: String) {
		self.uID = uID
		self.name = name
		self.projects = []
	}
}
