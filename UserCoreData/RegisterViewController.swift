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

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

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

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userEntity = UserEntity(context: context)
        userEntity.firstName = firstName
        userEntity.lastName = lastName
        userEntity.email = email
        userEntity.password = password

        // Database mai reflect karne ke liye - IMP

        do {
            try context.save() // MIMP
        }catch {
            print("User saving error:", error)
        }
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
