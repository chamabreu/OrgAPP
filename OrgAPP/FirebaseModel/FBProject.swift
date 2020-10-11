import Foundation


// Project Object
class FBProject {
	var uID: String
	var name: String
	// The Parent Category
	var parentCategoryUID: String

	init(uID: String, name: String, parentCategoryUID: String) {
		self.uID = uID
		self.name = name
		self.parentCategoryUID = parentCategoryUID
	}
}
