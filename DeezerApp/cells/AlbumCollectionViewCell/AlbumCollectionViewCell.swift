//
//  AlbumCollectionViewCell.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var albumTitleLabel: UILabel!
    @IBOutlet var albumSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
