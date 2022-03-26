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
    
    let interactor: UserInteractorServiceProtocol
    weak var view: AuthViewControllerProtocol?
    
    init (interactor: UserInteractorServiceProtocol) {
    self.interactor = interactor
    }
    
}

extension UserPresenter: UserPresenterProtocol {
    
}
