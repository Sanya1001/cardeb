//
//  UserViewModel.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var data: [UserModel]?
    @Published var isLoading = false

    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        isLoading = true

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let data = data, error == nil else { return }

                self?.data = try? JSONDecoder().decode([UserModel].self, from: data)

            }
        }.resume()
    }
}
