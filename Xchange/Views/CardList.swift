//
//  CardList.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardList: View {
    var body: some View {
        NavigationSplitView
        {
            List(cards) { card in
                NavigationLink {
                            
                } label: {
                    Card(card: card)
                }
            }
            .navigationTitle("Business Cards")
        } detail: {
            Text("Select a Card")
        }
    }
}

#Preview {
    CardList()
}
