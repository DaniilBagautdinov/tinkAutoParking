//
//  AppDelegate.swift
//  TinkAutoParking
//
//  Created by Даниил Багаутдинов on 04.03.2022.
//

import UIKit
import CoreData
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        if let _ = AuthService.shared.currentUser?.uid {
            let mapViewController = MapAssembly().assemble()
            window?.rootViewController = mapViewController
        } else {
            let authViewController = AuthAssembly().assemble()
            window?.rootViewController = authViewController
        }
        window?.makeKeyAndVisible()
        return true
    }
}

