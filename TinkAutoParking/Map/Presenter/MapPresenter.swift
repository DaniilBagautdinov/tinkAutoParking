//
//  MapPresenter.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 25.03.2022.
//

import UIKit

protocol MapPresenterProtocol {
    
}

final class MapPresenter {
    let model: MapModelProtocol
    weak var view: MapViewControllerProtocol?
    
    init (model: MapModelProtocol) {
        self.model = model
    }
}

extension MapPresenter: MapPresenterProtocol {
    
}
