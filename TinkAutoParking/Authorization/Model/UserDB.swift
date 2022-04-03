//
//  User.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 27.03.2022.
//

import Foundation

protocol UserDBProtocol {
     
}

struct UserDB: Identifiable, UserDBProtocol {
    
    var id: String = UUID().uuidString
    var name: String
    var car: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["car"] = self.car
        return repres
    }
}
