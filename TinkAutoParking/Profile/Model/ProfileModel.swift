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
    
    func getUserInfo(completion: @escaping (([String: Any]?) -> (Void))) {
        var result: [String: Any]?
        let group = DispatchGroup()
        if let userID = AuthService.shared.currentUser?.uid {
            let user = DataBaseService.shared.usersRef.document("\(userID)")
            group.enter()
            user.getDocument { (document, error) in
                if let document = document, document.exists {
                    result = document.data()
                    print("Document data: \(String(describing: result))")
                    group.leave()
                } else {
                    print("Document does not exist")
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completion(result)
        }
    }
}
