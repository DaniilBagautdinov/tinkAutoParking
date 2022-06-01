//
//  MapAssembly.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 25.03.2022.
//

import UIKit

protocol MapAssemblyProtocol: AnyObject {
    func assemble() -> UIViewController
}

final class MapAssembly: MapAssemblyProtocol {
    
    func assemble() -> UIViewController {
        let viewController = MapViewController()
        
        return viewController
    }
}
