//
//  CardData.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import Foundation
import SwiftUI

struct CardData: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var phone: String
    var affiliation: String
    var description: String
}
