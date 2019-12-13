//
//  Album.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

// MARK: - Albums
struct Albums: Codable {
    var data: [Album]?
    let total: Int?
    let next: String?
}

// MARK: - Album
struct Album: Codable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"
    }
}
