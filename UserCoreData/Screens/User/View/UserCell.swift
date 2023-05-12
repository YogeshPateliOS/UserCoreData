//
//  UserCell.swift
//  UserCoreData
//
//  Created by Yogesh Patel on 09/05/23.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    var user: UserEntity? {
        didSet { // Property Observer
            userConfiguration()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func userConfiguration() {
        guard let user else { return }
        fullNameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "") // title
        emailLabel.text = "Email: \(user.email ?? "")" // subTitle

        let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
        profileImageView.image = UIImage(contentsOfFile: imageURL.path)
    }
    
}
