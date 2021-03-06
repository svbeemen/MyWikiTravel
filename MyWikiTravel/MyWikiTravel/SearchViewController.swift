//
//  SearchViewController.swift
//  MyWikiTravel
//
//  Created by Elias Gorter on 04-06-15.
//  Copyright (c) 2015 EliasGorter6052274. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MediaWikiAPIProtocol {
    
    var searchResults = [Article]()
    let cellIdentifier = "searchResultCell"
    var api: MediaWikiAPI!
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        api = MediaWikiAPI(delegate: self)
        api.searchWikiTravel("amsterdam")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell!
        let article = searchResults[indexPath.row]
        
        cell.textLabel?.text = article.title
        
        return cell
    }
    
    func didReceiveAPIResults(search: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResults = Article.articlesFromJson(search)
            self.searchResultsTableView!.reloadData()
        })
    }
}
