//
//  AlbumListViewModel.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

class AlbumListViewModel {

    private var httpClient: HTTPClient!

    var isBusy: Bindable<Bool> = Bindable(false)
    var albums: Bindable<Albums?> = Bindable(nil)
    var error: Bindable<DeezerError?> = Bindable(nil)
    
    init(client: HTTPClient? = nil) {
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func getAlbums(_ id: String) {
        isBusy.value = true
        httpClient.dataTask(DeezerAPI.getAlbumsWithArtist(id: id)) {  (result) in
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let albums = try JSONDecoder().decode(Albums.self, from: data)
                    self.albums.value = albums
                } catch {
                    Print.error("Unable to decode albums List", error: error)
                }
            case .failure(let error):
                self.error.value = DeezerError(error.localizedDescription)
                Print.error("Error in fetching albums", error: error)
            }
        }
    }
}
