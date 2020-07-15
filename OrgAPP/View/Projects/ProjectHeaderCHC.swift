//
//  ProjectHeaderCHC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 20.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit

class ProjectHeaderCHC: UICollectionReusableView {
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var deleteCategory: UIButton!

	//	var thisCategory: Category!
		var thisCategory: FBCategory!

	var projectsVC: ProjectsVC!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func deleteCategory(_ sender: UIButton) {
//		RealmFuncs.Edit.deleteObject(thisCategory)
//		projectsVC.projectsCollectionView.reloadData()
		FBK.Categorys.deleteCategory(withID: thisCategory.uID)
//		print("DUMMY BUTTON DELETE CATEGORY")
	}

    
}
