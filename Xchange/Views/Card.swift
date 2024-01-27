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
        GeometryReader{
            proxy in
            HStack{
                Spacer()
                    Image("bg1")
                        .padding(100)
                        .frame(width: (3*proxy.size.width)/4, height: (proxy.size.width)/2)
//                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        .overlay(
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .stroke(.white, lineWidth: 2)
                        )
                        .shadow(radius: 7)
                        .padding()
                        .overlay(
                            CardInfo(card: card)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding()
                        )
                Spacer()
            }
            
        }
            
    }

}

#Preview {
    Group{
        Card(card: cards[0])
        Card(card: cards[1])
    }
}
