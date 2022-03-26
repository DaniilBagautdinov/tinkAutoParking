//
//  AuthAssembly.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 26.03.2022.
//

import Foundation
import UIKit

protocol AuthAssemblyProtocol: AnyObject {
    func assemble() -> UIViewController
}

final class AuthAssembly: AuthAssemblyProtocol {
    
    func assemble() -> UIViewController {
        let interactor = UserInteractor()
        let presenter = UserPresenter(interactor: interactor)
        let viewController = AuthViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
