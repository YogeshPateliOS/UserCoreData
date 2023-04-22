//
//  RegisterViewController.swift
//  UserCoreData
//
//  Created by Yogesh Patel on 09/04/23.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!

    private let manager =  DatabaseManager()

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add User"
    }

}

// MARK: - Action Methods
extension RegisterViewController{

    @IBAction func registerButtonTapped(_ sender: UIButton){
        guard let firstName = firstNameField.text, !firstName.isEmpty else {
            openAlert(message: "Please enter your first name")
            return
        }
        guard let lastName = lastNameField.text, !lastName.isEmpty else {
            openAlert(message: "Please enter your last name")
            return
        }
        guard let email = emailField.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address")
            return
        }

        guard let password = passwordField.text, !password.isEmpty else {
            openAlert(message: "Please enter your password")
            return
        }
        let user = UserModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
        manager.addUser(user)
        navigationController?.popViewController(animated: true)
       // showAlert()
    }

    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }

}

extension RegisterViewController {

    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }

}
