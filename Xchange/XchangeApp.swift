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
    @State private var currentCard: Int = 0
    @State var isNotPayment: Bool = false
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                .onOpenURL { incomingURL in
                    print("App was opened via URL: \(incomingURL)")
                    
                    if let urlComponents = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
                                   let queryItems = urlComponents.queryItems {
                                    let indexValue = queryItems.first(where: { $0.name == "index" })?.value
                                    print("Index: \(indexValue)")
                        
                                    if(indexValue == "10")
                                    {
                                        self.currentCard = 10
                                        self.isNotPayment = true
                                        print(self.isNotPayment)
//                                        Card(card: cards[Int(indexValue!)!])
                                    }
                        else{
                            self.isNotPayment = false
                        }
                        
                        if(!isNotPayment)
                        {
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
            .sheet(isPresented: $isNotPayment, onDismiss: {
                print("Dismiss")
            }, content: {
                CardDetail(card: cards[0])
            })
            
        }
        
    }

}
