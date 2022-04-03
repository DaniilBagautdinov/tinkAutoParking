//
//
//  Created by Даниил Багаутдинов on 09.03.2022.
//

import UIKit
import SpriteKit
import GameplayKit

protocol MapViewControllerProtocol: AnyObject {
    
}

class MapViewController: UIViewController {
    
    let presenter: MapPresenterProtocol
    
    init(presenter: MapPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "MapViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var demoScene: MapScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            demoScene = MapScene(size: view.bounds.size)
            demoScene.scaleMode = .resizeFill
            demoScene.delegatee = self
            // Present the scene.
            view.presentScene(demoScene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension MapViewController: MapViewControllerProtocol {
    
}

extension MapViewController: MapSceneDelegate {
    func showScreen() {
        present(DetailViewController(), animated: true)
    }
}
