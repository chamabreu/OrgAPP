//
//  CreateNewUserVC.swift
//  OrgAPP
//
//  Created by Jan Manuel Brenner on 18.07.20.
//  Copyright © 2020 Jan Manuel Brenner. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateNewUserVC: UIViewController {
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var passTF: UITextField!

	var logInVC: LoginVC!

    override func viewDidLoad() {
        super.viewDidLoad()
		if logInVC.emailTF.text != "" {
			emailTF.text = logInVC.emailTF.text!
		}

        // Do any additional setup after loading the view.
    }

	@IBAction func createNewPressed(_ sender: UIButton) {
		if let email = emailTF.text, let password = passTF.text {
			Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
				if let e = error {
					print("Error: \(e.localizedDescription)")
				}else {
					// Notify the User
					self.successWindow()
				}
			}

		}



	}

	func successWindow() {
		let successAlert = UIAlertController(title: "User Created", message: "A new User with e-Mail \(emailTF.text!) is created.", preferredStyle: .alert)
		let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
			// Pre-Set the email in the Loginscreen
			self.logInVC.emailTF.text = self.emailTF.text!
			self.logInVC.passTF.becomeFirstResponder()
			// And go Back to LoginScreen
			self.dismiss(animated: true, completion: nil)

		}

		successAlert.addAction(okButton)

		DispatchQueue.main.async {
			self.present(successAlert, animated: true, completion: nil)
		}

	}

	@IBAction func cancelPressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
