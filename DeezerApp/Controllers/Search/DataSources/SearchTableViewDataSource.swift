//
//  SearchTableViewDataSource.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class SearchTableViewDataSource: NSObject {
    
    var artists: Artists?
    let cellId: String = "ArtistTableViewCell"
    weak var searchViewControllerDelegate: SearchViewControllerDelegate?
    
    var tableView: UITableView? {
        didSet {
            self.setupTableView()
        }
    }
    
    func setupTableView() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
}


extension SearchTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArtistTableViewCell {
            guard let artist: Artist = artists?.data?[indexPath.row] else { return cell }
            cell.artistTitleLabel.text = artist.name
            cell.artistImageView.image = UIImage(named: "profile")
            cell.artistImageView.downloadImage(fromUrl: artist.pictureSmall)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artist: Artist = artists?.data?[indexPath.row] else { return }
        searchViewControllerDelegate?.didSelectArtist(artist: artist)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
