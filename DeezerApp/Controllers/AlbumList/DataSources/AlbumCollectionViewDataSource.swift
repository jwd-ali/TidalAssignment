//
//  AlbumCollectionViewDataSource.swift
//  DeezerApp
//
//  Created by Praveen on 06/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumCollectionViewDataSource: NSObject {
    
    // MARK: -  Properties
    let cellId: String = "AlbumCollectionViewCell"
    
    // MARK: - Weak Properties and Delgate
    weak var albumsViewControllerDelegate: AlbumsViewControllerDelegate?
    
    // MARK: - Properties Injection
    var albums: Albums!
    var collectionView: UICollectionView? {
        didSet {
            self.setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
}

extension AlbumCollectionViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  albums?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AlbumCollectionViewCell
        guard let album: Album = albums?.data?[indexPath.row] else { return cell! }
        cell?.albumImageView.image = UIImage(named: "profile")
        cell?.albumImageView.downloadImage(fromUrl: album.coverMedium)
        cell?.albumTitleLabel.text = album.title.uppercased()
        cell?.albumSubtitleLabel.text = album.releaseDate
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/2 - 6
        let height = UIScreen.main.bounds.width/2 + 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album: Album = albums?.data?[indexPath.row] else { return }
        albumsViewControllerDelegate?.didSelectAlbum(album: album)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

