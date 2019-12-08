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

    fileprivate let padding: CGFloat = 16
    var viewModel: AlbumDetailViewModel = AlbumDetailViewModel()
    var album: Album?
    var albumDetailCollectionViewDataSource: AlbumDetailCollectionViewDataSource = AlbumDetailCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumDetailCollectionViewDataSource.collectionView = collectionView
        viewModel.getAlbumDetail(String(describing: album?.id ?? 0))
        setupBindings()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
    
    private func setupBindings() {
            viewModel.isBusy.bind { [unowned self] isBusy in
                 //self.view.showLoader(show: isBusy)
            }
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
                    self.view.showLoader(show: false)
                    UIAlertController.show(error.localizedDescription, from: self)
                }
            }
        }
    }

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}
