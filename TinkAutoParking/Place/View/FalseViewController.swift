//
//  DetailsViewController.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 03.04.2022.
//

import UIKit
import FirebaseAuth

class FalseViewController: UIViewController {
    
    let id: Int
    let placeModel = PlaceModel()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: "FalseViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func takePlaceButton(_ sender: Any) {
        placeModel.setPlace(placeID: id)
        dismiss(animated: true)
    }
}
