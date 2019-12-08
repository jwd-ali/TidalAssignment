//
//  AlbumsViewControllerDelegate.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

protocol AlbumsViewControllerDelegate: class {
    func didSelectAlbum(album: Album)
}
