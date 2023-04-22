//
//  UserListViewController.swift
//  UserCoreData
//
//  Created by Yogesh Patel on 22/04/23.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    private var users: [UserEntity] = []
    private let manager = DatabaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = manager.fetchUsers()
        userTableView.reloadData()
    }
    
    @IBAction func addUserButtonTapped(_ sender: UIBarButtonItem) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        navigationController?.pushViewController(registerVC, animated: true)
    }

}

extension UserListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = (user.firstName ?? "") + " " + (user.lastName ?? "") // title
        content.secondaryText = "Email: \(user.email ?? "")" // subTitle

        cell.contentConfiguration = content // MIMP
        return cell
    }
}
