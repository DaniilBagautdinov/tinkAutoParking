//
//  DetailModel.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 13.04.2022.
//

import UIKit

final class PlaceModel {
    func setPlace(placeID: Int) {
        if let userID = AuthService.shared.currentUser?.uid {
            let user = DataBaseService.shared.usersRef.document("\(userID)")
            let place = DataBaseService.shared.placeRef.document("\(placeID)")
            user.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    let data = document.data()
                    place.updateData([
                        "taken" : true,
                        "name" : data!["name"] as! String,
                        "car" : data!["car"] as! String,
                        "time" : "\(Date())",
                        "id" : "\(userID)"
                    ])
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}
