//
//  ProfileViewController.swift
//  TinkAutoParking
//
//  Created by Семён Соколов on 10.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carTextField: UITextField!
    
    let profileModel = ProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func saveButton(_ sender: Any) {
        profileModel.updateUser(name: nameTextField.text ?? "", car: carTextField.text ?? "")
    }
    
    private func configure() {
        let userInfo = profileModel.getUserInfo()
        nameTextField.text = userInfo
        carTextField.text = userInfo
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        dismiss(animated: true)
    }
    
}
