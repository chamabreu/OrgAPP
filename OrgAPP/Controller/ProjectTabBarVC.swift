//
//  ProjectTabBarVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 25.04.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit
import Firebase

class ProjectTabBarVC: UITabBarController {
	var projectsVC: ProjectsVC!
	var thisProject: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

//		self.title = (thisProject.value(forKey: S.name) as! String) ---- Geht so nicht. braucht einen Observer. Eventeull Title woanders einstellen

        // Do any additional setup after loading the view.
    }


}
