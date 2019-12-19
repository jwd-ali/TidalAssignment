//
//  AlbumsViewController.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
     // MARK: - Outlet
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties Injection
    var artist: Artist
    
    // MARK: - Properties Injection
    
    //MARK:- should be private
    private let viewModel: AlbumListViewModel = AlbumListViewModel()
    private let albumCollectionViewDataSource: AlbumCollectionViewDataSource = AlbumCollectionViewDataSource()
    
     // MARK: - Initializer
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupBindings()
        self.viewModel.getAlbums("\(artist.id)")
    }
     //MARK:- should be private
   private func setupViews() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = artist.name
        self.collectionView.backgroundColor = UIColor.Common.primary
        self.view.backgroundColor = UIColor.Common.primary
    }
     //MARK:- should be private
   private func setupCollectionView() {
        albumCollectionViewDataSource.albumsViewControllerDelegate = self
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


extension AlbumsViewController: AlbumsViewControllerDelegate {
    
    func didSelectAlbum(album: Album) {
        let vc = Navigator.getAlbumDetailViewController(album)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
