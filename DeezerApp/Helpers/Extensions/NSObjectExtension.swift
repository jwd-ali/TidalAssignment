//
//  NSObjectExtension.swift
//  DeezerApp
//
//  Created by Praveen on 04/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
