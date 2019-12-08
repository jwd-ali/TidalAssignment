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
        //searchViewController.viewModel = SearchListViewModel()
        //searchViewController.searchListDataSource = SearchListDataSource()
        return searchViewController
    }
    
    // MARK: - Class Functions
    class func getAlbumsViewController() -> AlbumsViewController {
        let albumsViewController = AlbumsViewController(nibName: AlbumsViewController.name, bundle: nil)
        //searchViewController.viewModel = SearchListViewModel()
        //searchViewController.searchListDataSource = SearchListDataSource()
        return albumsViewController
    }
    
    
       // MARK: - Class Functions
       class func getAlbumDetailViewController() -> AlbumDetailViewController {
           let albumDetailViewController = AlbumDetailViewController(nibName: AlbumDetailViewController.name, bundle: nil)
           //searchViewController.viewModel = SearchListViewModel()
           //searchViewController.searchListDataSource = SearchListDataSource()
           return albumDetailViewController
       }
    
    
}
