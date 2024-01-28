//
//  ListCards.swift
//  Xchange
//
//  Created by Sania Sinha on 1/28/24.
//

import SwiftUI

struct Document: Decodable, Identifiable {
    let documentId: Int
    let documentName: String
    let documentType: String
    let documentContent: [String: String]

    var id: Int {
        return documentId
    }
}

struct ApiResponse: Decodable {
    let docs: [Document]
}

class ViewCardsModel: ObservableObject {
    let userId: String

    @Published var data: [Document] = []
    @Published var isLoading = false

    init(userId: String) {
        self.userId = userId
        fetchData()
    }

    func fetchData() {
        isLoading = true
        let user = ["userId": userId]
        let body: [String: Any] = ["data": user]
        guard let url = URL(string: "https://api.cardeb.biz/api/v1/user/getAllDocumentContent"),
              let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Invalid URL or JSON")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let data = data {
                    do {
                        print(response)
                        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
//                        GlobalData.shared.cardData = apiResponse
                        self?.data = apiResponse.docs
                        print(self?.data)
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct ListCards: View {
    @StateObject var viewModel: ViewCardsModel
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: ViewCardsModel(userId: userId))
    }
    @State private var isSharePresented: Bool = false
    @State private var isPayPresented: Bool = false
    
    let paymentHandler = PaymentHandler()
    var name: String = ""
    
    var body: some View {
     
        if (viewModel.data.isEmpty){
            GeometryReader{
                proxy in
                ScrollView(.vertical){
                    Color.black
                    ZStack (alignment: .top) {
                        Color.black
                        VStack {
                            HStack(spacing: 0){
                                Text("Carde")
                                    .font(.custom(
                                        "SanFrancisco",
                                        fixedSize: 45)
                                        .weight(.bold))
                                    .foregroundColor(Color(red: 101 / 255, green: 115 / 255, blue: 255 / 255))
                                Text("B")
                                    .font(.custom(
                                        "SanFrancisco",
                                        fixedSize: 45)
                                        .weight(.bold))
                                    .foregroundColor(Color(red: 247 / 255, green: 174 / 255, blue: 242 / 255))
                            }
                            
                            //                            CardList()
                            
                            Button("Share your Card") {
                                self.isSharePresented = true
                            }
                            .sheet(isPresented: $isSharePresented, onDismiss: {
                                print("Dismiss")
                            }, content: {
                                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=2")!])
                            })
                            
                            Button(action: {
                                self.isPayPresented = true
                            }, label: {
                                Text("REQUEST PAY WITH  APPLE")
                                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                                    .padding(10)
                                    .foregroundColor(.white)
                            }
                            )
                            .sheet(isPresented: $isPayPresented, onDismiss: {
                                print("Dismiss")
                            }, content: {
                                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=0")!])
                            })
                        }
                        .padding()
                        Spacer()
                            .frame(minHeight: proxy.size.height)
                        
                        
                    }
                }
            
            }
            
        }
        else
        {
            GeometryReader{
                proxy in
                
                ScrollView(.vertical){
                    Color.black
                    ZStack (alignment: .top) {
                        Color.black
                        VStack {
                            HStack(spacing: 0){
                                Text("Carde")
                                    .font(.custom(
                                        "SanFrancisco",
                                        fixedSize: 45)
                                        .weight(.bold))
                                    .foregroundColor(Color(red: 101 / 255, green: 115 / 255, blue: 255 / 255))
                                Text("B")
                                    .font(.custom(
                                        "SanFrancisco",
                                        fixedSize: 45)
                                        .weight(.bold))
                                    .foregroundColor(Color(red: 247 / 255, green: 174 / 255, blue: 242 / 255))
                            }
                            
                            //                            CardList()
                            
                            NavigationSplitView{
                                ScrollView(){
                                        ForEach(viewModel.data, id: \.id) { document in
                                            
                                            NavigationLink{
                                                CardDetail(name: document.documentContent["firstName"]!, email: document.documentContent["email"]!, phone: document.documentContent["phoneNumber"]!)
                                            } label: {
                                                Card(name: document.documentContent["firstName"]!, email: document.documentContent["email"]!, phone: document.documentContent["phoneNumber"]!)

                                            }
                                            .frame(minHeight: proxy.size.height/5)
                                            
                                        } // end of outer for each
                                        .frame(minWidth: proxy.size.width)

                                    
                                    
                                }
                                .navigationTitle("Business Cards")
                            } detail: {
                                Text("Select a Card")
                            }
                            
//                            Button("Share your Card") {
//                                self.isSharePresented = true
//                            }
//                            .sheet(isPresented: $isSharePresented, onDismiss: {
//                                print("Dismiss")
//                            }, content: {
//                                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=2")!])
//                            })
                            
                            Button(action: {
                                self.isPayPresented = true
                            }, label: {
                                Text("REQUEST PAY WITH  APPLE")
                                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
                                    .padding(10)
                                    .foregroundColor(.white)
                            }
                            )
                            .sheet(isPresented: $isPayPresented, onDismiss: {
                                print("Dismiss")
                            }, content: {
                                ActivityViewController(activityItems: [URL(string: "cardeb://Working?index=0")!])
                            })
                            
                        }
                        .padding()
                        
                        
                        Spacer()
                            .frame(minHeight: proxy.size.height)
                    }
                }
                    
                
            }
        }
        
    }
}

#Preview {
    ListCards(userId: GlobalData.shared.userId)
}
