//
//  SceneDelegate.swift
//  EstateHub
//
//  Created by Unit27 on 25/07/2025.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let window = UIWindow(windowScene: scene as! UIWindowScene)
           
           let rootVC: UIViewController
           if Auth.auth().currentUser != nil {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
               rootVC = dashboardVC
           } else {
               rootVC = StartViewController()
           }

           window.rootViewController = UINavigationController(rootViewController: rootVC)
           self.window = window
           window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

