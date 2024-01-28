//
//  XchangeApp.swift
//  Xchange
//
//  Created by Sania Sinha on 1/20/24.
//

import SwiftUI

struct UserApiResponse : Decodable{
    var userId : String
}
struct LinkUsersApiResponse : Decodable {

}

func ShareCard(documentId : String){
    func createLink(userIdInitiate : String, documentId : String){
        let userIdAccepting = GlobalData.shared.userId
        let body = ["userIdInitiate" : userIdInitiate, "userIdAccept" : userIdAccepting, "documentId" : documentId]
        let payload : [String : Dictionary] = ["data" : body]
        guard let url = URL(string: "https://api.cardeb.biz/api/v1/link/users"),
              let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            print("Invalid URL or JSON")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {  data, response, error in
            DispatchQueue.main.async {
                
                if let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(LinkUsersApiResponse.self, from: data)
                        
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
        
        
    }
    func fetchUserId(documentId : String){
        let docu = ["documentId" : documentId]
        let body : [String: Dictionary] = ["data" : docu]
        guard let url = URL(string: "https://api.cardeb.biz/api/v1/doc/getContent"),
              let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Invalid URL or JSON")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {  data, response, error in
            DispatchQueue.main.async {
                
                if let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(UserApiResponse.self, from: data)
                        createLink(userIdInitiate: apiResponse.userId, documentId: documentId)
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    fetchUserId(documentId: documentId)
}
@main
struct XchangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    let paymentHandler = PaymentHandler()
    @State var isNotPayment: Bool = false
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                .onOpenURL { incomingURL in
                    print("App was opened via URL: \(incomingURL)")
                    
                    if let urlComponents = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
                                   let queryItems = urlComponents.queryItems {
                                    let indexValue = queryItems.first(where: { $0.name == "index" })?.value
                                    print("Index: \(indexValue)")
                        
                                    if(Int(indexValue!) != 0)
                                    {
                                        
                                        self.isNotPayment = true
                                        ShareCard(documentId: indexValue!)
//                                        Card(card: cards[Int(indexValue!)!])
                                    }
                        
                        else{
                            self.isNotPayment = false
                        }
                        
                        let name = queryItems.first(where: { $0.name == "name" })?.value
                        let phone = queryItems.first(where: { $0.name == "phone" })?.value
                        let email = queryItems.first(where: { $0.name == "email" })?.value
                        GlobalData.shared.incomingName = name!
                        GlobalData.shared.incomingPhone = phone!
                        GlobalData.shared.incomingEmail = email!
                        
                        if(!isNotPayment)
                        {
                            self.paymentHandler.startPayment { (success) in
                                if success {
                                    print("Success")
                                } else {
                                    print("Failed")
                                }
                            }
                        }
    
                                }
                }
            .sheet(isPresented: $isNotPayment, onDismiss: {
                print("Dismiss")
            }, content: {
                CardDetail(name: GlobalData.shared.incomingName, email: GlobalData.shared.incomingEmail, phone: GlobalData.shared.incomingPhone)
            })
            
        }
        
    }

}
