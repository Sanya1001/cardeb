//
//  ContentView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/20/24.
//

import UIKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack (alignment: .top) {
            Color.black
            VStack {
                Text("XChange")
                    .font(.title)
                
            }
            .foregroundColor(.pink)
            .padding()
            Spacer()
        }
        
            
    }
    
}

#Preview {
    ContentView()
}
