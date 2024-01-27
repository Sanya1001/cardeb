//
//  Data.swift
//  Xchange
//
//  Created by Sania Sinha on 1/26/24.
//

import Foundation
import SwiftUI

struct Data: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var email: String
    var phone: Int
    var affiliation: String
    var description: String
    
//    private var imageName: String
//    var image: Image {
//        Image(imageName)
//    }
    
//    private var coordinates: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//            CLLocationCoordinate2D(
//                latitude: coordinates.latitude,
//                longitude: coordinates.longitude)
//        }
//
//
//    struct Coordinates: Hashable, Codable {
//        var latitude: Double
//        var longitude: Double
//    }
    
}
