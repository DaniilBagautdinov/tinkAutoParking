//
//  RegViewController.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 28.03.2022.
//

import UIKit
import FirebaseAuth

protocol ValidateEmailAndPassProtocol {
    func isValidEmail(_ email: String?) -> Bool
    func isValidPassword(_ pass: String?) -> Bool
}

class RegViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstPassTextField: UITextField!
    @IBOutlet weak var secondPassTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    let alertFactory = AlertFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard isValidEmail(emailTextField.text) && isValidPassword(firstPassTextField.text) else { return }
        guard (firstPassTextField.text == secondPassTextField.text) else {
            self.present(self.alertFactory.buildPasswordDoNotMatchAlert(), animated: true)
            return
        }
        AuthService.shared.signUp(email: emailTextField.text ?? "", password: firstPassTextField.text ?? "") { result in
            switch result {
            case .success(let user):
                self.present(self.alertFactory.buildRegSuccessAlert(email: self.emailTextField.text ?? ""), animated: true)
                self.emailTextField.text = ""
                self.secondPassTextField.text = ""
                self.firstPassTextField.text = ""
            case .failure(let error):
                self.present(self.alertFactory.buildRegUnSuccessAlert(), animated: true)
            }
        }
    }
    
    @IBAction func alreadyHaveAccountButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: - Validate e-mail and password
extension RegViewController: ValidateEmailAndPassProtocol {
    
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z]{1,64}@[A-Za-z0-9]{1,64}\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return true
        } else {
            self.present(alertFactory.buildCheckValidEmailAlert(okClosure: nil), animated: true)
            return false
        }
    }
    
    func isValidPassword(_ pass: String?) -> Bool {
        let passRegEx = "(?=.*[0-9])[a-zA-Z0-9]{6,64}"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        if passPred.evaluate(with: pass) {
            return true
        } else {
            self.present(alertFactory.buildCheckValidPasswordAlert(okClosure: nil), animated: true)
            return false
        }
    }
}


