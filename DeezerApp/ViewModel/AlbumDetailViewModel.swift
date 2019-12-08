//
//  AlbumDetailViewModel.swift
//  DeezerApp
//
//  Created by Praveen on 08/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

class AlbumDetailViewModel {
    
    private var httpClient: HTTPClient!
    
    var isBusy: Bindable<Bool> = Bindable(false)
    var albumDetail: Bindable<AlbumDetail?> = Bindable(nil)
    var error: Bindable<DeezerError?> = Bindable(nil)
    
    init(client: HTTPClient? = nil) {
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func getAlbumDetail(_ id: String) {
        isBusy.value = true
        httpClient.dataTask(DeezerAPI.getAlbumDeailsWithAlbum(id: id)) {  (result) in
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let albumDetail = try JSONDecoder().decode(AlbumDetail.self, from: data)
                    self.albumDetail.value = albumDetail
                    print("=======================================================")
                    print(albumDetail.title)
                    for track in albumDetail.tracks?.data ?? [] {
                        print(track.title)
                        print(track.duration)
                        print("-----------------------")
                    }
                    print("=======================================================")
                } catch {
                    Print.error("Unable to decode AlbumDetail", error: error)
                }
            case .failure(let error):
                self.error.value = DeezerError(error.localizedDescription)
                Print.error("Error in fetching AlbumDetail", error: error)
            }
        }
    }
}
