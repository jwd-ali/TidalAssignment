//
//  AlbumDetail.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

// MARK: - AlbumDetail
struct AlbumDetail: Codable {
    var id: Int?
    var title: String?
    var coverSmall, coverMedium, coverBig, coverXl: String?
    var label: String?
    var tracks: Tracks?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case label
        case tracks
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    var data: [TracksDatum]?
}

// MARK: - TracksDatum
struct TracksDatum: Codable {
    var id: Int?
    var readable: Bool?
    var title, titleShort, titleVersion: String?
    var link: String?
    var duration, rank: Int?
    var explicitLyrics: Bool?
    var explicitContentLyrics, explicitContentCover: Int?
    var preview: String?

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
    }
}
