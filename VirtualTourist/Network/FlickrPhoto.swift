//
//  FlickrPhoto.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

struct FlickrPhoto: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
    let url: String
    
    let farm: Int
    let height: Int
    let isFamily: Int
    let isFriend: Int
    let isPublic: Int
    let width: Int
 
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, title
        case farm
        case height = "height_m"
        case isFamily = "isfamily"
        case isFriend = "isfriend"
        case isPublic = "ispublic"
        case url = "url_m"
        case width = "width_m"
    }
}
