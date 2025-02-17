//
//  SceneDelegate.swift
//  CustomStepper
//
//  Created by Seokho on 2020/01/03.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
    }
    
}

