//
//  ContentView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/20/24.
//

import UIKit
import SwiftUI
import PassKit
import Foundation

struct ContentView: View {
    @State private var signedIn = false

    
    var body: some View {
        if(signedIn)
        {
            HomeView()
        }
        else
        {
            SignInView(signedIn: $signedIn)
        }
            
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
