//
//  SelectCategoryTCC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 21.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit

class SelectCategoryTCC: UITableViewCell {
	@IBOutlet weak var categoryLabel: UILabel!
	var thisCategory: FBCategory!
	@IBOutlet weak var addCatButton: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
//		categoryLabel.text = thisCategory.name
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	@IBAction func addNewCategory(_ sender: UIButton) {
	}
}
