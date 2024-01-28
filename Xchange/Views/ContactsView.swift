//
//  Contacts.swift
//  cardeB
//
//  Created by Mateja Milicevic on 1/27/24.
//
import SwiftUI
struct DocumentSingle: Decodable {
    let name: String
    let content: DocumentContent
    let type: String

    var id: String { name } // Assuming name is unique and can be used as an ID
}
struct DocumentContent: Decodable {
    let email: String
    let phoneNumber: String
    let firstName: String
    let lastName: String
}

struct AcceptedData : Decodable {
    let linkId : Int
    let userIdInitiate : Int
    let documentId : Int
    let date : String
}

struct InitiatedData : Decodable {
    let linkId : Int
    let userIdAccept : Int
    let documentId : Int
    let date : String

}

struct LinksData : Decodable {
    
    let initiated : InitiatedData
    let accepted : AcceptedData
    
}

struct LinksApiResponse : Decodable{
    let accepted : [AcceptedData]
    let initiated : [InitiatedData]
    
}
struct DocumentDetailView: View {
    @ObservedObject var viewModelCard: ViewCardModel

    init(documentId: Int) {
        _viewModelCard = ObservedObject(wrappedValue: ViewCardModel(documentId: String(documentId)))
    }

    var body: some View {
        VStack(alignment: .leading) {
            if viewModelCard.isLoading {
                Text("Loading document...")
            } else if let doc = viewModelCard.doc {
                Text("Name: \(doc.name)")
                // Display other document details
            } else {
                Text("Document not available")
            }
        }
    }
}

class ViewCardModel: ObservableObject {
    let documentId: String

    @Published var doc: DocumentSingle? // Changed to optional Document
    @Published var isLoading = false

    init(documentId: String) {
        self.documentId = documentId
        fetchData()
    }

    func fetchData() {
        isLoading = true
        let document = ["documentId": documentId]
        let body: [String: Any] = ["data": document]
        guard let url = URL(string: "http://localhost:8000/api/v1/doc/getContent"),
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
                        let document = try JSONDecoder().decode(DocumentSingle.self, from: data)
                        self?.doc = document // Assign the decoded Document
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
struct TempApiResponse :Decodable {
    
}

class ContactsViewModel: ObservableObject {
    let userId: String

    @Published var acceptedLinks: [AcceptedData] = []
    @Published var initiatedLinks: [InitiatedData] = []
    @Published var isLoading = false

    init(userId: String) {
        self.userId = userId
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        
        let user = ["userId": userId]
        let body: [String: Any] = ["data": user]
        guard let url = URL(string: "http://localhost:8000/api/v1/link/getLinks"),
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
                        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid JSON string"
                                        print("JSON String: \(jsonString)")
                        let apiResponse = try JSONDecoder().decode(LinksApiResponse.self, from: data)
                        print("ApiResponse: \(apiResponse)")
                        self?.acceptedLinks = apiResponse.accepted
                        self?.initiatedLinks = apiResponse.initiated
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

struct ContactsView: View {
    @StateObject var viewModel: ContactsViewModel
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: ContactsViewModel(userId: userId))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                Text("Loading...")
            } else if viewModel.acceptedLinks.isEmpty && viewModel.initiatedLinks.isEmpty {
                Text("No contacts available.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List {
                    Section(header: Text("Accepted")) {
                        ForEach(viewModel.acceptedLinks, id: \.linkId) { link in
                            DocumentDetailView(documentId: link.documentId)
                            }
                        }
                    }
                }
            }
        }
    }



//#Preview {
//    ContactsView()
//}
