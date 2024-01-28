//
//  ContentView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/20/24.
//

import UIKit
import SwiftUI
import PassKit

struct ContentView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var signedIn = false
    @State private var isSharePresented: Bool = false
    @State private var isPayPresented: Bool = false
    
    let paymentHandler = PaymentHandler()
    
    var body: some View {
//        if(signedIn)
//        {
            GeometryReader{
                proxy in
                ScrollView(.vertical){
                    Color.black
                    ZStack (alignment: .top) {
                        Color.black
                        VStack {
                            HStack(spacing: 0){
                                Text("Carde")
                                    .font(.custom(
                                        "SanFrancisco",
                                        fixedSize: 45)
                                        .weight(.bold))
                                    .foregroundColor(Color(red: 101 / 255, green: 115 / 255, blue: 255 / 255))
                                Text("B")
                                    .font(.custom(
                                    "SanFrancisco",
                                    fixedSize: 45)
                                    .weight(.bold))
                                .foregroundColor(Color(red: 247 / 255, green: 174 / 255, blue: 242 / 255))
                            }
                            
                            CardList()
                        }
                        .padding()
                        Spacer()
                        .frame(minHeight: proxy.size.height)
                    }
                }
            }
            Button("Share your Card") {
                self.isSharePresented = true
            }
            .sheet(isPresented: $isSharePresented, onDismiss: {
                print("Dismiss")
            }, content: {
                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=10")!])
            })
        
        Button(action: {
            self.isPayPresented = true
        }, label: {
            Text("REQUEST PAY WITH  APPLE")
                .font(Font.custom("HelveticaNeue-Bold", size: 16))
                .padding(10)
                .foregroundColor(.white)
        }
        )
        .sheet(isPresented: $isPayPresented, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=0")!])
        })
            
            
//            Button(action: {
//                self.paymentHandler.startPayment { (success) in
//                    if success {
//                        print("Success")
//                    } else {
//                        print("Failed")
//                    }
//                }
//            }, label: {
//                Text("PAY WITH  APPLE")
//                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
//                    .padding(10)
//                    .foregroundColor(.white)
//            }
//            )
//        }
//        else
//        {
//            SignInView(signedIn: $signedIn)
//        }
            
        }
    
//    @ViewBuilder func getView(view: String) -> {
//        switch view {
//        case "10":
//            Text(view)
//        default:
//            EmptyView()
//        }
//    }
}

#Preview {
    ContentView()
}
