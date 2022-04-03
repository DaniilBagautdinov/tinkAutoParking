//
//  UserPresenter.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 26.03.2022.
//

import Foundation

protocol UserPresenterProtocol {
    
}

final class UserPresenter {
    
    let userModel: UserDBProtocol
    weak var view: AuthViewControllerProtocol?
    
    init (userModel: UserDBProtocol) {
       self.userModel = userModel
    }
}

extension UserPresenter: UserPresenterProtocol {
    
}
