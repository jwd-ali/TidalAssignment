//
//  Aritist.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

// MARK: - Artists
struct Artists: Codable {
    var data: [Artist]?
    let total: Int?
    let next: String?
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int
    let name: String
    let link, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}
