//
//  ProfileModel.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 10.04.2022.
//

import Foundation
import Firebase

class ProfileModel {
    
    func updateUser(name: String, car: String) {
        if let userID = AuthService.shared.currentUser?.uid {
            let user = DataBaseService.shared.usersRef.document("\(userID)")
            user.updateData([
                "car" : car,
                "name" : name
            ]
            )
        }
    }
    
    func getUserInfo() -> String {
        var result: String = ""
        if let userID = AuthService.shared.currentUser?.uid {
            let user = DataBaseService.shared.usersRef.document("\(userID)")
            user.getDocument { (document, error) in
                if let document = document, document.exists {
                    result = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(result)")
                } else {
                    print("Document does not exist")
                }
            }
        }
        return result
    }
}
