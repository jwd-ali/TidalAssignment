//
//  DeezerAPI.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

//Deezer APIs
enum DeezerAPI {
    case searchArtist(keyword: String)
    case getAlbumsWithArtist(id: String)
    case getAlbumDeailsWithAlbum(id: String)
}

extension DeezerAPI: HTTPRequestProtocol {
    //Set Base URL
    var baseURL: URL {
        guard let url = URL(string: Constants.Service.baseURL) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    //Returns EndPoint for Deezer APIs
    var path: String {
        switch self {
        case .searchArtist(let keyword):
            return "search/artist?q=\(keyword)"
        case .getAlbumsWithArtist(let id):
            return "artist/\(id)/albums"
        case .getAlbumDeailsWithAlbum(let id):
            return "album/\(id)"
        }
    }
    
    //Returns HTTP Method for Deezer APIs
    var httpMethod: HTTPMethod {
        switch self {
        case .searchArtist, .getAlbumsWithArtist, .getAlbumDeailsWithAlbum:
            return .get
        }
    }
    
    //Encode and Returns Encoded Data
    var httpBody: Data? {
        return nil
    }
    
    //Return Contact APIs Specific Headers
    var headers: HTTPHeaders? {
        return nil
    }
}
