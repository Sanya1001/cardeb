//
//  XchangeApp.swift
//  Xchange
//
//  Created by Sania Sinha on 1/20/24.
//

import SwiftUI

@main
struct XchangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    let paymentHandler = PaymentHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { incomingURL in
                    print("App was opened via URL: \(incomingURL)")
                    self.paymentHandler.startPayment { (success) in
                        if success {
                            print("Success")
                        } else {
                            print("Failed")
                        }
                    }
                }
            
        }
        
    }

}
