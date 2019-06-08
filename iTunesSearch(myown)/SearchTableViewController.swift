//
//  SearchTableViewController.swift
//  iTunesSearch(myown)
//
//  Created by Dongwoo Pae on 6/8/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    let searchController = SearchController()
    
    @IBOutlet weak var resultTypeControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var resultType : ResultType!
        
        switch resultTypeControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
            guard let searchTerm = searchBar.text else {return}
            
            self.searchController.perfromSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
                if let error = error {
                    NSLog("print error : \(error)")
                    return
                } else {
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                }
            }
        }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let results = self.searchController.searchResults[indexPath.row]
        cell.textLabel?.text = results.title
        cell.detailTextLabel?.text = results.creator
        return cell
    }

}
