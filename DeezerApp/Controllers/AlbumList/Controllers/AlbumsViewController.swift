//
//  AlbumsViewController.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: AlbumListViewModel = AlbumListViewModel()
    var albumCollectionViewDataSource: AlbumCollectionViewDataSource = AlbumCollectionViewDataSource()
    
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupBindings()
        self.viewModel.getAlbums("\(artist.id)")
    }
    
    func setupViews() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = artist.name
        self.collectionView.backgroundColor = UIColor.Common.primary
        self.view.backgroundColor = UIColor.Common.primary
    }
    
    func setupCollectionView() {
        albumCollectionViewDataSource.viewController = self
        albumCollectionViewDataSource.collectionView = self.collectionView
    }
    
    private func setupBindings() {
          viewModel.isBusy.bind { [unowned self] isBusy in
              self.view.showLoader(show: isBusy)
          }
          
          viewModel.albums.bind { [unowned self] (albums) in
              if albums != nil {
                  self.albumCollectionViewDataSource.albums?.data?.removeAll()
                  self.albumCollectionViewDataSource.albums = albums
                  self.albumCollectionViewDataSource.collectionView?.reloadData()
              }
          }
          viewModel.error.bind { [unowned self] (error) in
              if let error = error {
                  self.view.showLoader(show: false)
                  UIAlertController.show(error.localizedDescription, from: self)
              }
          }
      }
    

}
