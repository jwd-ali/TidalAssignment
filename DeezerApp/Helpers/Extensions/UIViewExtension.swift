//
//  UIViewExtension.swift
//  DeezerApp
//
//  Created by Praveen on 04/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

extension UIView {
    
    func showLoader(show: Bool) {
        if(show) {
            let backgroundView = UIView()
            backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
            backgroundView.backgroundColor = backgroundColor
            backgroundView.tag = 475647
            
            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.tag = 12313412
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.color = UIColor.black
            activityIndicator.startAnimating()
            self.isUserInteractionEnabled = false
            
            backgroundView.addSubview(activityIndicator)
            
            self.addSubview(backgroundView)
        } else {
            hideLoader()
        }
    }
    
    private func hideLoader() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        if let background = viewWithTag(12313412){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
