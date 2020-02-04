//
//  ShowController.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation
import UIKit.UIImage

class ShowController {
  static let shared = ShowController()
  
  var seasons: [Season] = []
  
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
        guard let shows = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]]
          else { return completion(.failure(.unableToDecodeData)) }
        
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
  
  
  func getEpisodesFor(showID: Int, completion: @escaping(Result<[Season], ShowAPIError>) -> Void) {
    guard let showURL = URL(string: baseURL.show.rawValue)
      else { return completion(.failure(.invalidURL)) }
    let showIDURL = showURL.appendingPathComponent("\(showID)").appendingPathComponent("episodes")
    
    let session = URLSession.shared.dataTask(with: showIDURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      do {
        var seasons: [Season] = []
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]]
          else { return completion(.failure(.unableToDecodeData)) }
        
        for dict in json {
          guard let season = Season(dictionary: dict)
            else { continue }
          
          if seasons.contains(where: {$0.season == season.season}) {
            guard let episode = Episode(dictionary: dict),
              let index = seasons.firstIndex(of: season)
              else { continue }
            seasons[index].episodes.append(episode)
          } else {
            seasons.append(season)
            guard let episode = Episode(dictionary: dict),
              let index = seasons.firstIndex(of: season)
              else { continue }
            seasons[index].episodes.append(episode)
            
          }
        }
        return completion(.success(seasons))
      } catch {
        print(error, error.localizedDescription)
        return completion(.failure(.unableToDecodeData))
      }
      
    }
    session.resume()
  }
  
  func getImage(imageURL: String, completion: @escaping(Result<UIImage, ShowAPIError>) -> Void) {
    guard let fetchImageURL = URL(string: imageURL)
      else { return completion(.failure(.invalidURL)) }
    
    let session = URLSession.shared.dataTask(with: fetchImageURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      guard let image = UIImage(data: data)
        else { return completion(.failure(.unableToDecodeData)) }
      
      return completion(.success(image))
    }
    session.resume()
  }
}

enum baseURL: String {
  case search = "http://api.tvmaze.com/search"
  case show = "http://api.tvmaze.com/shows"
}

enum ShowAPIError: Error {
  case invalidURL
  case noData
  case invalidData
  case unableToDecodeData
}
