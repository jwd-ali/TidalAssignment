//
//  TrackCollectionViewCell.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {

    @IBOutlet var numberingLabel: UILabel!
    @IBOutlet var trackTitleLabel: UILabel!
    @IBOutlet var trackSubtitleLabel: UILabel!
    @IBOutlet var dureationLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
