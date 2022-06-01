//
//  UserDB.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 01.06.2022.
//

import Foundation

struct UserDB: Identifiable {
    
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
