//
//  AddCard.swift
//  cardeB
//
//  Created by Mateja Milicevic on 1/27/24.
//

import SwiftUI

struct AddCardView:View{
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var cardName = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToHomePage = false
    @State private var website = ""
    var body: some View{
        if navigateToHomePage {
            HomeView()
        }else{
            NavigationView {
                Form {
                    Section(header: Text("Card Info")) {
                        TextField("Card Name", text: $cardName)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Full Name", text: $firstName)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
//                        TextField("Last Name", text: $lastName)
//                            .autocapitalization(.none)
//                            .disableAutocorrection(true)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Website", text: $website)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        
                    }
                    
                    Section {
                        Button("Add Card") {
                            // Add your sign in logic here
                            
                            addCard(email:email, phoneNumber:phoneNumber, cardName:cardName, firstName:firstName, lastName:lastName,
                                website:website)
                        }
                    }
                }
                .navigationBarTitle("Add Card").alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            
                    }
    }
    private func addCard(email:String, phoneNumber:String, cardName:String, firstName:String, lastName:String, website:String) {
            guard let url = URL(string: "https://api.cardeb.biz/api/v1/doc/createDocument") else {
                print("Invalid URL")
                return
            }
            let content = ["email" : email, "phoneNumber" : phoneNumber, "firstName" : firstName, "lastName":lastName]
        let data: [String: Any] = ["userId" : GlobalData.shared.userId, "name" : cardName, "content" : content, "type" : "default"]
            let body: [String: Any] = ["data": data]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                print("Failed to encode credentials")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        if let data = data, let responseJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let docId = responseJson["docId"] as? Int {
                                self.alertMessage = "Added card with ID \(docId)"
                                self.showAlert = true
                                self.navigateToHomePage = true
        
                            } else {
                                self.alertMessage = "Failed to add card"
                                self.showAlert = true
                            }
                        } else if let error = error {
                            self.alertMessage = error.localizedDescription
                            self.showAlert = true
                        } else {
                            self.alertMessage = "Unknown error occurred"
                            self.showAlert = true
                        }
                    }
                }.resume()
    }
}


#Preview {
    AddCardView()
}
