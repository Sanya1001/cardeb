//
//  SceneDelegate.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let _ = (scene as? UIWindowScene) else { return }
        print("SceneDelegate is connected!")
        print(URLContexts)
    }

    

//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions, openURLContexts URLContexts: Set<UIOpenURLContext>) {
////        guard let _ = (scene as? UIWindowScene) else { return }
//        print("SceneDelegate is connected!")
//        print(URLContexts)
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("active now")
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("active now 2")
    }

    func sceneWillEnterForeground(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        print("active now 3")
        print(URLContexts)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}
