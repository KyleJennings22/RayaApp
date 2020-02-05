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
  
  var showTask: URLSessionDataTask? = nil
  let cache = NSCache<NSString, UIImage>()
  
  /// Function to get all shows with specified search text
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
    showTask = URLSession.shared.dataTask(with: finalSearchURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      // Making sure the data is not nil
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      do {
        var showArray: [Show] = []
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]]
          else { return completion(.failure(.unableToDecodeData)) }
        
        for dict in json {
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
    showTask?.resume()
  }
  
  // Function to get all seasons and episodes with specified show ID
  func getEpisodesFor(showID: Int, completion: @escaping(Result<[Season], ShowAPIError>) -> Void) {
    
    // Creating the URL
    guard let showURL = URL(string: baseURL.show.rawValue)
      else { return completion(.failure(.invalidURL)) }
    let showIDURL = showURL.appendingPathComponent("\(showID)").appendingPathComponent("episodes")
    
    // Starting the session to grab the data
    let task = URLSession.shared.dataTask(with: showIDURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      // Checking for nil
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      do {
        var seasons: [Season] = []
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]]
          else { return completion(.failure(.unableToDecodeData)) }
        
        for dict in json {
          guard let season = Season(dictionary: dict)
            else { continue }
          
          // If the season already exists, we want to append it to existing episodes in the season
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
    task.resume()
  }
  
  // Function to get images for specified image URL
  func getImage(imageURL: String, completion: @escaping(Result<UIImage, ShowAPIError>) -> Void) {
    
    // Creating the URL
    guard let fetchImageURL = URL(string: imageURL)
      else { return completion(.failure(.invalidURL)) }
    
    // Making the network request
    let task = URLSession.shared.dataTask(with: fetchImageURL) { (data, _, error) in
      if let error = error {
        print(error, error.localizedDescription)
        return completion(.failure(.noData))
      }
      
      // Guarding against nil
      guard let data = data
        else { return completion(.failure(.invalidData)) }
      
      // Compressing the image a bit to save space and make runtimes quicker
      guard let imageData = UIImage(data: data)?.jpegData(compressionQuality: 0.5),
        let image = UIImage(data: imageData)
        else { return completion(.failure(.unableToDecodeData)) }
      
      return completion(.success(image))
    }
    task.resume()
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
