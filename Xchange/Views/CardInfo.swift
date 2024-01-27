//
//  CardInfo.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardInfo: View {
    var card: CardData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.name)
            Text(card.affiliation)
        }
    }
}

#Preview {
    CardInfo(card: cards[0])
}
