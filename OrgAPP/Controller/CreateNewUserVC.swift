import UIKit
import FirebaseAuth

// ViewController for UserCreation
class CreateNewUserVC: UIViewController {
	// View References
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var passTF: UITextField!

	// The LoginVC which segues to here
	var logInVC: LoginVC!


    override func viewDidLoad() {
        super.viewDidLoad()
		// Transfer the entered emailadress if exists from loginVC
		if logInVC.emailTF.text != "" {
			emailTF.text = logInVC.emailTF.text!
		}

    }

	// User creates a new Account
	@IBAction func createNewPressed(_ sender: UIButton) {
		if let email = emailTF.text, let password = passTF.text {
			Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
				if let e = error {
					self.errorAlert(error: e)
				}else {
					// Notify the User
					self.successWindow()
				}
			}

		}



	}
	// UserFeedback of creationproces
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

	// Feedback of Errors
	func errorAlert(error: Error) {
		let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		let okButton = UIAlertAction(title: "Ok", style: .default,handler: nil)

		errorAlert.addAction(okButton)

		DispatchQueue.main.async {
			self.present(errorAlert, animated: true, completion: nil)
		}

	}

	// Cancel the creationprocess and return to LoginScreen
	@IBAction func cancelPressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
