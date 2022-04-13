//
//  DetailsViewController.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 03.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: "DetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func takePlaceButton(_ sender: Any) {
        
    }
}
