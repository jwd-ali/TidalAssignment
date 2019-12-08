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
    
    var artist: Artist
    
    fileprivate let viewModel: AlbumListViewModel = AlbumListViewModel()
    fileprivate let albumCollectionViewDataSource: AlbumCollectionViewDataSource = AlbumCollectionViewDataSource()    
    
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
