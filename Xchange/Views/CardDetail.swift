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
        .foregroundColor(Color(red: 55 / 255, green: 5 / 255, blue: 181 / 255))
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
            .foregroundColor(Color(red: 232 / 255, green: 188 / 255, blue: 232 / 255))
            Text(card.email)
                .foregroundColor(Color(red: 232 / 255, green: 188 / 255, blue: 232 / 255))
            
            Divider()
            Text(card.description)
            
        }
        .padding()
        .navigationTitle(card.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func openView(){
        NavigationLink {
                CardDetail(card: card)
                    
        } label: {
                Card(card: card)
                .foregroundColor(Color(red: 55 / 255, green: 5 / 255, blue: 181 / 255))
//                        .frame(minHeight: proxy.size.width/2)
            
        }
    }
}

#Preview {
    CardDetail(card: cards[0])
}
