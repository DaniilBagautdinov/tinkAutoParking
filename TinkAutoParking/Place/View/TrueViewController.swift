//
//  TrueViewController.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 17.04.2022.
//

import UIKit

class TrueViewController: UIViewController {
    
    //MARK: - Properties
    
    let place: Place
    
    //MARK: - UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - init func
    
    init(place: Place) {
        self.place = place
        super.init(nibName: "TrueViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Private configure func
    
    private func configure() {
        nameLabel.text = place.name
        carLabel.text = place.car
        timeLabel.text = place.time
    }
}
