//
//  HTTPError.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

struct HTTPError: Decodable {
    let status: String?
    let error: String?
}
