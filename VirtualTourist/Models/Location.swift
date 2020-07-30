//
//  Location.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

struct Location: Codable {
    let country: String
    let latitude: Double
    let longitude: Double
    let location: String

    enum CodingKeys: String, CodingKey {
        case country, latitude, longitude, location
    }
}
