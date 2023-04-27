//
//  RegisterViewController.swift
//  UserCoreData
//
//  Created by Yogesh Patel on 09/04/23.
//

import UIKit
import PhotosUI


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
    private var imageSelectedByUser: Bool = false

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

}

// MARK: - Action Methods
extension RegisterViewController{

    func configuration() {
        uiconfiguration()
        addGesture()
    }

    func uiconfiguration() {
        navigationItem.title = "Add User"
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }

    func addGesture() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.openGallery))
        profileImageView.addGestureRecognizer(imageTap)
    }


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

        if !imageSelectedByUser {
            openAlert(message: "Please choose your profile image.")
            return
        }

       // print("All validations are done!!! good to go...")
        let imageName = UUID().uuidString
        let user = UserModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            imageName: imageName
        )
        saveImageToDocumentDirectory(imageName: imageName)
        manager.addUser(user)
        navigationController?.popViewController(animated: true)
       // showAlert()
    }

    func saveImageToDocumentDirectory(imageName: String) {
        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        if let data = profileImageView.image?.pngData() {
            do {
                try data.write(to: fileURL) // Save
            }catch {
                print("Saving image to Document Directory error:", error)
            }
        }
    }




    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }

    @objc func openGallery() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // 0 - Unlimited

        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated: true)
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

extension RegisterViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            // Background Thread
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    // Main - UI related work
                    self.profileImageView.image = image
                    self.imageSelectedByUser = true
                }
            }
        }
    }
}
