//
//  CardDetail.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardDetail: View {
//    var card: CardData
    var name: String = "Sanya"
    var email: String = "xyzz"
    var phone: String = "123456"
    var affiliation: String = "MSU"
    var description: String = "I am a SpartaHack participant!"
    @State var isSharePresented = false
    var body: some View {
        ScrollView{
            
        }
        Card(name: name, email: email, phone: phone)
        .foregroundColor(Color(red: 55 / 255, green: 5 / 255, blue: 181 / 255))
//        CircleImage(image: card.image)
//                    .offset(y: -130)
//                    .padding(.bottom, -130)
        VStack(alignment: .leading){
            Text(name)
                .font(.title)
            HStack{
                Text(affiliation)
                    .font(.subheadline)
                Spacer()
                Text(phone)
                    .font(.subheadline)
            }
            .foregroundColor(Color(red: 232 / 255, green: 188 / 255, blue: 232 / 255))
            Text(email)
                .foregroundColor(Color(red: 232 / 255, green: 188 / 255, blue: 232 / 255))
            
            Divider()
            Text(description)
            
            Button("Share your Card") {
                self.isSharePresented = true
            }
            .sheet(isPresented: $isSharePresented, onDismiss: {
                print("Dismiss")
            }, content: {
                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=1&name=\(name)&phone=\(phone)&email=\(email)")!])
            })
            
        }
        .padding()
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        
       
        
//        Button(action: {
//            self.isPayPresented = true
//        }
    }
    
//    func openView(){
//        NavigationLink {
//                CardDetail(card: card)
//                    
//        } label: {
//                Card(card: card)
//                .foregroundColor(Color(red: 55 / 255, green: 5 / 255, blue: 181 / 255))
////                        .frame(minHeight: proxy.size.width/2)
//            
//        }
//    }
}

//#Preview {
//    CardDetail(card: cards[0])
//}
