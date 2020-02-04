//
//  Season.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation

struct Season: Codable {
  let season: Int
  var episodes: [Episode]
}

extension Season {
  init?(dictionary: [String: Any]) {
    guard let season = dictionary[SeasonKeys.season.rawValue] as? Int
      else { return nil }
      
    self.init(season: season, episodes: [])
  }
}

extension Season: Equatable {
  static func == (lhs: Season, rhs: Season) -> Bool {
    return lhs.season == rhs.season
  }
}

enum SeasonKeys: String {
  case season = "season"
  case episodeNumber = "number"
  case imageDict = "image"
  case description = "summary"
  case mediumImage = "medium"
  case originalImaage = "original"
}
