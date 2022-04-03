//
//  AlertFactory.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 02.04.2022.
//

import Foundation
import UIKit

protocol ValidationAlertFactory {
    func buildCheckValidEmailAlert(okClosure: (() -> Void)?) -> UIAlertController
    func buildCheckValidPasswordAlert(okClosure: (() -> Void)?) -> UIAlertController
    func buildRegSuccessAlert(email: String) -> UIAlertController
    func buildRegUnSuccessAlert() -> UIAlertController
    func buildPasswordDoNotMatchAlert() -> UIAlertController
}

final class AlertFactory: ValidationAlertFactory {
    
    func buildPasswordDoNotMatchAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка совпадения паролей", message: "Пароли не совпадают.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        return alert
    }
    
    func buildRegUnSuccessAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка регистрации", message: "Что-то пошло не так. Повторите попытку снова.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        return alert
    }
    
    func buildRegSuccessAlert(email: String) -> UIAlertController {
        let alert = UIAlertController(title: "Регистрация прошла успешно", message: "Вы зарегистрировались с email: ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        return alert
    }
    
    func buildCheckValidEmailAlert(okClosure: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка формата электронной почты", message: "Неверный формат почты. Введите почту снова.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in okClosure?() }
        alert.addAction(okAction)
        return alert
    }
    
    func buildCheckValidPasswordAlert(okClosure: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка формата пароля", message: "Неверный формат пароля. Пароль должен включать только латинские буквы, иметь хотя бы 1 цифру и содержать не менее 6 символов", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in okClosure?() }
        alert.addAction(okAction)
        return alert
    }
}
