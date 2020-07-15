import Foundation


class FBProject {
	var uID: String
	var name: String
	var parentCategoryUID: String

	init(uID: String, name: String, parentCategoryUID: String) {
		self.uID = uID
		self.name = name
		self.parentCategoryUID = parentCategoryUID
	}
}
