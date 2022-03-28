//
//  ViewController.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 04.03.2022.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

protocol AuthViewControllerProtocol: AnyObject {
    
}

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
     private var isAuth = true

//    let presenter: UserPresenterProtocol
    
//    init(presenter: UserPresenterProtocol) {
//        self.presenter = presenter
//        super.init()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        AuthService.shared.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
                
            case .success(let user):
                self.performSegue(withIdentifier: "map", sender: nil)
                print(user)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

extension AuthViewController: AuthViewControllerProtocol {
    
}
