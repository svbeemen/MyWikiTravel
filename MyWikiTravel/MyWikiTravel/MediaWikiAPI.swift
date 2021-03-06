//
//  MediaWikiAPI.swift
//  MyWikiTravel
//
//  Created by Elias Gorter on 04-06-15.
//  Copyright (c) 2015 EliasGorter6052274. All rights reserved.
//

import Foundation

protocol MediaWikiAPIProtocol {
    func didReceiveAPIResults(search: NSArray)
}

class MediaWikiAPI {
    var delegate: MediaWikiAPIProtocol
    
    init(delegate: MediaWikiAPIProtocol) {
        self.delegate = delegate
    }
    
    func searchWikiTravel(searchTerm: String) {
        let urlPath = "http://wikitravel.org/wiki/en/api.php?format=json&action=query&list=search&srwhat=text&srsearch=\(searchTerm)"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                if(err != nil) {
                    println("JSON Error \(err!.localizedDescription)")
                }
                if let query: NSDictionary = jsonResult["query"] as? NSDictionary {
                    if let search: NSArray = query["search"] as? NSArray {
                        self.delegate.didReceiveAPIResults(search)
                    }
                }
            }
        })
        task.resume()
    }
}