//
//  MapModel.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 25.03.2022.
//

import UIKit

protocol MapModelProtocol {
    func getPlace(id: Int, completion: @escaping ((Place) -> (Void)))
}

final class MapModel: MapModelProtocol {
    func getPlace(id: Int, completion: @escaping ((Place) -> (Void))) {
        var result: Place = Place(taken: false, name: "", car: "", time: "")
        let group = DispatchGroup()
        let place = DataBaseService.shared.placeRef.document("\(id)")
        group.enter()
        place.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                result = Place(taken: data!["taken"] as! Bool, name: data!["name"] as! String , car: data!["car"] as! String, time: data!["time"] as! String)
                print("Document data: \(result)")
                group.leave()
            } else {
                print("Document does not exist")
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(result)
        }
    }
}

struct Place {
    let taken: Bool
    let name: String
    let car: String
    let time: String
}
