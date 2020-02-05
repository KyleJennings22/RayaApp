//
//  Episode.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation

struct Episode {
  let season: Int
  let episode: Int
  let title: String
  let description: String
  let mediumImageURL: String?
  let originalImageURL: String?
}

extension Episode {
  /// Initializer to make it easier to convert from JSON to our custom Episode object
  init?(dictionary: [String: Any]) {
    guard let season = dictionary[EpisodeKeys.season.rawValue] as? Int,
      let episode = dictionary[EpisodeKeys.episodeNumber.rawValue] as? Int,
      let title = dictionary[EpisodeKeys.title.rawValue] as? String,
      let description = dictionary[EpisodeKeys.description.rawValue] as? String
      else { return nil }
    
    // Some episodes do not contain images, this is why they are not included in the guard statement
    let imageDict = dictionary[EpisodeKeys.imageDict.rawValue] as? [String: Any]
    let mediumImageURL = imageDict?[EpisodeKeys.mediumImage.rawValue] as? String
    let originalImageURL = imageDict?[EpisodeKeys.originalImaage.rawValue] as? String
    
    self.init(season: season, episode: episode, title: title, description: description, mediumImageURL: mediumImageURL, originalImageURL: originalImageURL)
  }
}

enum EpisodeKeys: String {
  case season = "season"
  case episodeNumber = "number"
  case title = "name"
  case imageDict = "image"
  case description = "summary"
  case mediumImage = "medium"
  case originalImaage = "original"
}
