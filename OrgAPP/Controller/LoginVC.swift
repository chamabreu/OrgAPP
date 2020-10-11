import UIKit
import FirebaseAuth

// LoginScreen opens if not Login State is found or User logged out
class LoginVC: UIViewController {
	// View References
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var passTF: UITextField!
	@IBOutlet weak var logInButton: UIButton!
	@IBOutlet weak var createUserButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

		emailTF.delegate = self
		passTF.delegate = self
		// Instantiate the KeyboardToolbar
		S.Funcs.createKeyboardToolbar(style: .done, target: emailTF, execute: #selector(keyBoardDone))
		S.Funcs.createKeyboardToolbar(style: .done, target: passTF, execute: #selector(keyBoardDone))

    }

	// Reset Window and Textfields on Disappear
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		emailTF.text?.removeAll()
		passTF.text?.removeAll()
	}

	// User Logs in
	@IBAction func logInButtonPressed(_ sender: UIButton) {
		// Manual verification???
		//......
		//......
		//......
		//......



		// OR Serverbased verification?
		if let email = emailTF.text, let password = passTF.text {
			Auth.auth().signIn(withEmail: email, password: password) { (userData, error) in
				if let e = error {
					self.errorAlert(error: e)
				}
				// If no Error - Scenedelegate roots to ProjectsVC on Login
				// See SceneDelegate.swift -> Auth.auth().addStateDidChangeListener
			}
		}

	}

	// Error Message
	func errorAlert(error: Error) {
		let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		let okButton = UIAlertAction(title: "Ok", style: .default,handler: nil)

		errorAlert.addAction(okButton)

		DispatchQueue.main.async {
			self.present(errorAlert, animated: true, completion: nil)
		}

	}

	// Route to CreateNewUserVC
	@IBAction func createUserButtonPressed(_ sender: UIButton) {
		self.performSegue(withIdentifier: S.Segues.createUser, sender: nil)
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the CreateNewUserVC as Variable
		if let createNewVC = segue.destination as? CreateNewUserVC {
			createNewVC.logInVC = self
		}
	}

	// Keyboard Toolbar DoneButton
	@objc func keyBoardDone() {
		if emailTF.isFirstResponder {
			emailTF.resignFirstResponder()
		}else if passTF.isFirstResponder {
			passTF.resignFirstResponder()
		}
	}

}


//MARK: -  UITextField Delegate
extension LoginVC: UITextFieldDelegate {
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {

	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField === emailTF {
			passTF.becomeFirstResponder()
		}else if textField === passTF {
			passTF.endEditing(true)
		}
		return true
	}

	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {

	}
}
