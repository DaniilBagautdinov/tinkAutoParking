//
//  AuthService.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 27.03.2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    
    private let auth = Auth.auth()
    
    private var currentUser: User? {
        return auth.currentUser
    }
    
    func signUp(email: String, password: String, completion: @escaping(Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let userDB = UserDB(id: result.user.uid, name: "", car: "")
                DataBaseService.shared.setUser(user: userDB) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping(Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}

