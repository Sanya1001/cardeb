//
//  SignInView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var signedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    private func signIn(email: String, password: String)
    {
                guard let url = URL(string: "http://localhost:8000/api/v1/user/getUserId") else {
                    print("Invalid URL")
                    return
                }
                
                let credentials = ["userEmail": email, "userPassword": password]
                let body: [String: Any] = ["data": credentials]
                guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                    print("Failed to encode credentials")
                    return
                }

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request)
            { data, response, error in
                        DispatchQueue.main.async {
                            if let data = data, let responseJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                if let userId = responseJson["userId"] as? Int {
                                    self.signedIn = true
                                    self.alertMessage = "Signed in successfully. User ID: \(userId)"
                                } else {
                                    self.alertMessage = "Invalid email or password"
                                }
                            } else if let error = error {
                                self.alertMessage = "Error: \(error.localizedDescription)"
                            } else {
                                self.alertMessage = "Unknown error"
                            }
                            self.isShowingAlert = true
                }
             }.resume()
    }
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("Credentials")) {
                            TextField("Email", text: $email)
                                                    .keyboardType(.emailAddress)
                                                    .autocapitalization(.none)
                                                    .disableAutocorrection(true)

                            SecureField("Password", text: $password)
                        }

                        Section {
                            Button("Sign In") {
                                // Add your sign in logic here
                                signIn(email:email, password:password)
                            }
                        }
                    }
                    .navigationBarTitle("Sign In")
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Sign In Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
    }
}

//#Preview {
//    SignInView(signedIn: $false)
//}
