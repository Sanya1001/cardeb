//
//  AppDelegate.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            // Initialization code
        setupMyApp()
            return true
        }
    
    private func setupMyApp() {
            // TODO: Add any intialization steps here.
            print("Application started up!")
        }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
          let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
          sceneConfig.delegateClass = SceneDelegate.self
          return sceneConfig
      }
    
    func application(_ app: UIApplication, open url: URL) -> Bool {
        print("got an url")
            // Parse the URL and extract parameters
//            if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
//               let queryItems = urlComponents.queryItems {
//                let indexValue = queryItems.first(where: { $0.name == "index" })?.value
//                print("Index: \(indexValue)")
//            }
            return true
    }

//    func application(_ scene: UIScene, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        // Handle URL and extract parameters here
//        print("URL: \(url)")
//        return true
//    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print(url)
//        // Determine who sent the URL.
//        let sendingAppID = options[.sourceApplication]
//        print("source application = \(sendingAppID ?? "Unknown")")
//
////            var blank: some View {
////                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////            }
//
//        // Process the URL.
//        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//            let albumPath = components.path,
//            let params = components.queryItems else {
//                print("Invalid URL or album path missing")
//            return false
//        }
//
//
//        if let requestPay = params.first(where: { $0.name == "index" })?.value {
//            print("amount = \(albumPath)")
//            print("pay? = \(requestPay)")
//
////                getView(view: "\(requestPay)")
//
//            return true
//
//        } else {
//            print("Photo index missing")
//            return false
//        }
//
//    }
}
