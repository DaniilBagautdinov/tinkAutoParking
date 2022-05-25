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
        configure()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        profileModel.updateUser(name: nameTextField.text ?? "", car: carTextField.text ?? "")
        dismiss(animated: true)
    }
    
    private func configure() {
        profileModel.getUserInfo { [self] userInfo in
            nameTextField.text = userInfo!["name"] as? String
            carTextField.text = userInfo!["car"] as? String
        }
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func outOfPlacesButton(_ sender: Any) {
        DataBaseService.shared.placeRef.whereField("id", isEqualTo: "\(AuthService.shared.currentUser?.uid ?? "a")")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.updateData(["taken" : 0])
                    }
                }
            }
        dismiss(animated: true)
    }
}
