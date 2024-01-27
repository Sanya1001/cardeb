//
//  CardList.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import SwiftUI

struct CardList: View {
    var body: some View {
        GeometryReader{
            proxy in
            NavigationSplitView
            {
                ScrollView{
                    ForEach(cards) { card in
                        NavigationLink {
                                CardDetail(card: card)
                                    
                        } label: {
                                Card(card: card)
    //                        .frame(minHeight: proxy.size.width/2)
                            
                        }
                        .frame(minHeight: proxy.size.height/5)
                    }
                    .frame(minWidth: proxy.size.width)
                }
                .navigationTitle("Business Cards")
            } detail: {
                Text("Select a Card")
            }
        }
        
    }
}

#Preview {
    CardList()
}
