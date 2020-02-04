//
//  ShowController.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation



class ShowController {
  static let shared = ShowController()

  func getShows(with searchText: String, completion: @escaping(Result<[Show], ShowAPIError>) -> Void) {
    
    // Creating the URL
    guard let searchURL = URL(string: baseURL.search.rawValue)
      else { return completion(.failure(.invalidURL)) }
    let showSearchURL = searchURL.appendingPathComponent("shows")
    
    // Creating the URL Components
    var components = URLComponents(url: showSearchURL, resolvingAgainstBaseURL: false)
    let searchQueryItem = URLQueryItem(name: "q", value: searchText)
    components?.queryItems = [searchQueryItem]
    
    // Final URL with Query Item
    guard let finalSearchURL = components?.url
      else { return completion(.failure(.invalidURL)) }
    
    // Starting the Network Request
    let session = URLSession.shared.dataTask(with: finalSearchURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      do {
        var showArray: [Show] = []
        let shows = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
        for dict in shows {
          guard let show = Show(dictionary: dict)
            else { continue }
          showArray.append(show)
        }
        return completion(.success(showArray))
        
      } catch {
        print(error, error.localizedDescription)
        return completion(.failure(.unableToDecodeData))
      }
    }
    
    session.resume()
  }
}

enum baseURL: String {
  case search = "http://api.tvmaze.com/search"
  case show = "http://api.tvmaze.com/show"
}

enum ShowAPIError: Error {
  case invalidURL
  case noData
  case invalidData
  case unableToDecodeData
}
