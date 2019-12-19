//
//  ArtistListViewModel.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

class ArtistListViewModel {
    
    private var httpClient: HTTPClient!

    var isBusy: Bindable<Bool> = Bindable(false)
    var artists: Bindable<Artists?> = Bindable(nil)
    var error: Bindable<DeezerError?> = Bindable(nil)
    
    init(client: HTTPClient? = nil) {
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func searchArtist(_ keyword: String) {
        isBusy.value = true
        //MARK:- Potential Memory leak
        httpClient.dataTask(DeezerAPI.searchArtist(keyword: keyword)) { [weak self] (result) in
            guard let self = self else { return }
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let artists = try JSONDecoder().decode(Artists.self, from: data)
                    self.artists.value = artists
                } catch {
                    Print.error("Unable to decode Artist List", error: error)
                }
            case .failure(let error):
                self.error.value = DeezerError(error.localizedDescription)
                Print.error("Error in fetching Artist", error: error)
            }
        }
    }
}
