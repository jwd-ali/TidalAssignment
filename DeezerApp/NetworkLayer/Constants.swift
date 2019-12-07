//
//  Constants.swift
//  DeezerApp
//
//  Created by Praveen on 04/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

struct Constants {
    private init() {}
}

extension Constants {
    struct Service {
        static let baseURL = "http://api.deezer.com/"
        static let timeout: TimeInterval = 100.0
    }
}
