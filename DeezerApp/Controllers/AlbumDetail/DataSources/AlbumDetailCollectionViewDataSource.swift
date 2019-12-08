//
//  AlbumDetailCollectionViewDataSource.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumDetailCollectionViewDataSource: NSObject {
    
    // MARK: - Properties 
    fileprivate let cellId = "TrackCollectionViewCell"
    fileprivate let headerId = "headerId"
    
    // MARK: - Properties Injection
    var headerView: HeaderView!
    var albumDetail: AlbumDetail!
    
    var collectionView: UICollectionView? {
        didSet {
            self.setupCollectionView()
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}

extension AlbumDetailCollectionViewDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumDetail?.tracks?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCollectionViewCell
        guard let track: TracksDatum = albumDetail?.tracks?.data?[indexPath.row] else { return cell }
        cell.numberingLabel.text = "\(indexPath.row + 1)."
        cell.trackTitleLabel.text = track.title?.uppercased()
        cell.trackSubtitleLabel.text = track.titleShort
        cell.dureationLabel.text = Double(track.duration ?? Int(0.0)).asString(style: .positional)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width - 2, height: 60)
    }
    
}
