//
//  CardInfo.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardInfo: View {
//    var card: CardData
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Text(email)
        }
    }
}

//#Preview {
//    CardInfo(card: cards[0])
//}
