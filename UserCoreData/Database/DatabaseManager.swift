//
//  DatabaseManager.swift
//  UserCoreData
//
//  Created by Yogesh Patel on 22/04/23.
//

import UIKit
import CoreData

class DatabaseManager {

    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func addUser(_ user: UserModel) {
        let userEntity = UserEntity(context: context)
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.imageName = user.imageName
        // Database mai reflect karne ke liye - IMP

        do {
            try context.save() // MIMP
        }catch {
            print("User saving error:", error)
        }
    }

    func fetchUsers() -> [UserEntity] {
        var users: [UserEntity] = []

        do {
            users = try context.fetch(UserEntity.fetchRequest())
        }catch {
            print("Fetch user error", error)
        }

        return users
    }








}
