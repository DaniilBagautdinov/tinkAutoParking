//
//  FireBaseService.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 27.03.2022.
//

import Foundation
import FirebaseFirestore

final class DataBaseService {
    
    static let shared = DataBaseService()
    private let dataBase = Firestore.firestore()
    
    var usersRef: CollectionReference {
        return dataBase.collection("users")
    }
    
    private init() { }
    
    func setUser(user: UserDB, completion: @escaping (Result<UserDB, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
