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

class AuthViewController: UIViewController {
    
    //MARK: - UI
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dontHaveAccountButton: UIButton!
    
    //MARK: - Properties
    
    private var isAuth = true
    
    //MARK: - Init
    
    init() {
        super.init(nibName: "AuthViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Buttons
    @IBAction func signInButton(_ sender: Any) {
        AuthService.shared.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
            case .success(let user):
                let mapViewController = MapAssembly().assemble()
                mapViewController.modalPresentationStyle = .fullScreen
                self.present(mapViewController, animated: true)
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func dontHaveAccButton(_ sender: Any) {
        let regViewController = RegViewController()
        regViewController.modalPresentationStyle = .fullScreen
        present(regViewController, animated: true)
    }
    
}
