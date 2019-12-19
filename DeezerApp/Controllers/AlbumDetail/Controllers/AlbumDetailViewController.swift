//
//  AlbumDetailViewController.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties Injection
    var album: Album
    
    // MARK: -  Properties
    
    //MARK: - should be private
    private let padding: CGFloat = 16
    private let viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    private let albumDetailCollectionViewDataSource: AlbumDetailCollectionViewDataSource = AlbumDetailCollectionViewDataSource()
    
    // MARK: -  Initializer
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumDetailCollectionViewDataSource.collectionView = collectionView
        viewModel.getAlbumDetail(String(describing: album.id))
        setupBindings()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupBindings() {
        viewModel.albumDetail.bind { [unowned self] (albumDetail) in
            if albumDetail != nil {
                self.albumDetailCollectionViewDataSource.albumDetail = albumDetail
                self.albumDetailCollectionViewDataSource.headerView?.heavyLabel.text = albumDetail?.label ?? ""
                self.albumDetailCollectionViewDataSource.headerView?.imageView.downloadImage(fromUrl: albumDetail?.coverBig ?? "")
                self.albumDetailCollectionViewDataSource.collectionView?.reloadData()
            }
        }
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
    }
}

