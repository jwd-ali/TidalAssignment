//
//  AlbumDetailViewController.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var album: Album
    fileprivate let padding: CGFloat = 16
    fileprivate let viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    fileprivate let albumDetailCollectionViewDataSource: AlbumDetailCollectionViewDataSource = AlbumDetailCollectionViewDataSource()
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

