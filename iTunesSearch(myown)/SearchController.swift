//
//  SearchController.swift
//  iTunesSearch(myown)
//
//  Created by Dongwoo Pae on 6/8/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class SearchController {

    var baseURL = URL(string: "https://itunes.apple.com/")!
    
    var searchResults : [Search] = []
    
    func perfromSearch(searchTerm: String, resultType: ResultType, completion:@escaping (Error?)->Void) {
        
        baseURL.appendPathComponent("search")
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let searchTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, searchTypeQueryItem]
        guard let requestURL = urlComponents?.url else {
            NSLog("there isnt URL")
            completion(NSError())
            return
        }
        
        var reqeust = URLRequest(url: requestURL)
        reqeust.httpMethod = HTTPMethod.get.rawValue
 
        URLSession.shared.dataTask(with: reqeust) { (data, _, error) in
            if let error = error {
                NSLog("print error: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("there is no data")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let results = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = results.results
                completion(nil)
            } catch {
                NSLog("there is an error decoding data")
                completion(error)
            }
        }.resume()
    }
}
