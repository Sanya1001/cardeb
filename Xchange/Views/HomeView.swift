//
//  HomeView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = UserViewModel()

    var body: some View{
        TabView{
            ContactsView(userId: GlobalData.shared.userId)
                .tabItem{
                Label("Contacts", systemImage: "person.fill.badge.plus")
            }
            AddCardView()
                .tabItem{
                Label("Add Card", systemImage: "doc.fill.badge.plus")
            }

            ListCards(userId: GlobalData.shared.userId).tabItem { Label("List Cards", systemImage: "square.and.at.rectangle.fill") }
        }
    }
}
