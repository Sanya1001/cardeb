//
//  CardDetail.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardDetail: View {
    var card: CardData
    
    var body: some View {
        ScrollView{
            
        }
        Card(card: card)
//        CircleImage(image: card.image)
//                    .offset(y: -130)
//                    .padding(.bottom, -130)
        VStack(alignment: .leading){
            Text(card.name)
                .font(.title)
            HStack{
                Text(card.affiliation)
                    .font(.subheadline)
                Spacer()
                Text(card.phone)
                    .font(.subheadline)
            }
            Text(card.email)
            
            Divider()
            Text(card.description)
            
        }
        .padding()
        .navigationTitle(card.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CardDetail(card: cards[0])
}
