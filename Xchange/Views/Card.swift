//
//  Card.swift
//  Xchange
//
//  Created by Sania Sinha on 1/21/24.
//

import SwiftUI

struct Card: View {
    var card: CardData
    
    var body: some View {
        Image("bg1")
            .padding(100)
            .frame(width: 350, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .stroke(.white, lineWidth: 2)
            )
            .shadow(radius: 7)
            
    }

}

#Preview {
    Group{
        Card(card: cards[0])
        Card(card: cards[1])
    }
}
