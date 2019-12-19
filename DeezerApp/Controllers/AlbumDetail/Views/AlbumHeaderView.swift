//
//  AlbumHeaderView.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let heavyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    //MARK:- Should be private
    private func setupViews() {
        // custom code for layout
        addSubview(imageView)
        imageView.fillSuperview()
        setupGradientLayer()
    }
    
    //MARK:- should be private
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        // static frame
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
        
        heavyLabel.text = "ALBUM".localized
        heavyLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        heavyLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "ALBUM_HEADER_SUBTITLE".localized
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [
            heavyLabel, descriptionLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
