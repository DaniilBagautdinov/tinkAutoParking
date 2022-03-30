//
//  RegViewController.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 28.03.2022.
//

import UIKit
import FirebaseAuth

class RegViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstPassTextField: UITextField!
    @IBOutlet weak var secondPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Show alert func
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Validate e-mail and password
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z]{1,64}@[A-Za-z0-9]{1,64}\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return true
        } else {
            showAlert(title: "E-mail validation alert", message: "Wrong email format. Write the correct e-mail")
            return false
        }
    }
    
    func isValidPassword(_ pass: String?) -> Bool {
        let passRegEx = "(?=.*[0-9])[a-zA-Z0-9]{6,64}"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        if passPred.evaluate(with: pass) {
            return true
        } else {
            showAlert(title: "Password validation alert", message: "Wrong password format. Password should contains only latin letters, have atleast 1 digit and have more than 6 signs. ")
            return false
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard isValidEmail(emailTextField.text) && isValidPassword(firstPassTextField.text) else { return }
        guard (firstPassTextField.text == secondPassTextField.text) else {
            showAlert(title: "Password validation alert", message: "Пароли не совпадают")
            return
        }
        AuthService.shared.signUp(email: emailTextField.text ?? "", password: firstPassTextField.text ?? "") { result in
            switch result {
            case .success(let user):
                self.showAlert(title: "Регистрация прошла успешно", message: "Вы зарегистрировались с email: \(self.emailTextField.text ?? "")")
                self.emailTextField.text = ""
                self.secondPassTextField.text = ""
                self.firstPassTextField.text = ""
            case .failure(let error):
                self.showAlert(title: "Ошибка регистрации", message: "Что-то пошло не так. Повторите попытку снова")
            }
            self.dismiss(animated: true)
        }
    }
    
    
}


