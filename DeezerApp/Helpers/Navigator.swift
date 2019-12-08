//
//  Navigator.swift
//  DeezerApp
//
//  Created by Praveen on 04/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation
import  UIKit

class Navigator {
    
    // MARK: - Class Functions
    class func getSearchViewController() -> SearchViewController {
        let searchViewController = SearchViewController(nibName: SearchViewController.name, bundle: nil)
        return searchViewController
    }
    
    // MARK: - Class Functions
    class func getAlbumsViewController(_ artist: Artist) -> AlbumsViewController {
        let albumsViewController = AlbumsViewController(artist: artist)
        return albumsViewController
    }
    
       // MARK: - Class Functions
    class func getAlbumDetailViewController(_ album: Album) -> AlbumDetailViewController {
        let albumDetailViewController = AlbumDetailViewController(album: album)
           return albumDetailViewController
       }
    
    
}
