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
        let userModel = UserDB(name: "", car: "")
        let presenter = UserPresenter(userModel: userModel)
        let viewController = AuthViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
