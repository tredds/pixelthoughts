//
//  ResultsController.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import UIKit

public protocol ResultsControllerSelection : NSObjectProtocol {
    func resultsControllerSelectionSelect(string: String)
}

class ResultsController: UITableViewController, UISearchResultsUpdating {
    
    let tableViewCellIdentifier = "cellID"
    
    var allItems = DataProvider.sharedInstance().tagsProvider.tags()
    
    var filtered = [String]()
    weak var delegate: ResultsControllerSelection?
    
    var filterString = "" {
        didSet {
            // Return if the filter string hasn't changed.
            guard filterString != oldValue else { return }
            
            if filterString.isEmpty {
                filtered = allItems
            }
            else {
                filtered = allItems.filter { $0.containsString(filterString.lowercaseString) }
                
                if filtered.isEmpty {
                    filtered = [filterString]
                }
            }
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filtered = self.allItems
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: Configuration
    
    func configureCell(cell: UITableViewCell, forTitle title: String) {
        cell.textLabel?.text = title
        cell.textLabel?.textAlignment = .Center
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellIdentifier)!
        let title = filtered[indexPath.row]
        configureCell(cell, forTitle: title)
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterString = searchController.searchBar.text ?? ""
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            if (self.delegate?.respondsToSelector("resultsControllerSelectionSelect:") == true) {
                self.delegate?.resultsControllerSelectionSelect(self.filtered[indexPath.row])
                
                // custom 
                if (!self.allItems.contains(self.filtered[indexPath.row])) {
                    DataProvider.sharedInstance().tagsProvider.prepend(self.filtered[indexPath.row]);
                }
            }
        }
    }
    
}
