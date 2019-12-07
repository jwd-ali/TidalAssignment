//
//  SearchViewController.swift
//  DeezerApp
//
//  Created by Praveen on 04/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet var tableView: UITableView!
    
    var viewModel: ArtistListViewModel = ArtistListViewModel(client: HTTPClient(session: URLSession.shared))
    var searchTableViewDataSource: SearchTableViewDataSource = SearchTableViewDataSource()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupdDataSource()
        self.setupBindings()
    }
    
    private func setupdDataSource() {
        self.searchTableViewDataSource.tableView = tableView
        self.searchTableViewDataSource.viewController = self
    }
    
    private func setupBindings() {
        viewModel.isBusy.bind { [unowned self] isBusy in
            //self.view.showLoader(show: isBusy)
        }
        
        viewModel.artists.bind { [unowned self] (artists) in
            if artists != nil {
                self.searchTableViewDataSource.artists?.data?.removeAll()
                self.searchTableViewDataSource.artists = artists
                self.searchTableViewDataSource.tableView?.reloadData()
            } else {
                self.searchTableViewDataSource.artists?.data?.removeAll()
                self.searchTableViewDataSource.tableView?.reloadData()
            }
        }
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                self.view.showLoader(show: false)
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationAndSearchBar()
    }
    
    private func setupNavigationAndSearchBar() {
         self.navigationItem.title = "Tidal Music"
         self.navigationController?.navigationBar.prefersLargeTitles = true
         searchController.searchResultsUpdater = self
         searchController.searchBar.tintColor = .white
         searchController.searchBar.barStyle = .black
         navigationController?.navigationBar.barStyle = .black
         if #available(iOS 13, *) {
             navigationController?.navigationBar.isTranslucent = true
         } else {
             navigationController?.navigationBar.isTranslucent = false
         }
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.placeholder = "Search Artist"
         navigationItem.hidesSearchBarWhenScrolling = false
         navigationItem.searchController = searchController
         definesPresentationContext = true
         navigationItem.largeTitleDisplayMode = .automatic
     }
    
}



extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text!.isEmpty { return }
        //Applied Debounce for Reducing Search API Calls
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(updateSearch(with:)), with: searchController.searchBar.text ?? "", afterDelay: 0.3)
    }
    
    
    @objc private func updateSearch(with text: String) {
        self.viewModel.searchArtist(text)
    }
    
}
