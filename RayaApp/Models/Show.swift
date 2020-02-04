//
//  Show.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation

struct Show: Codable {
  let title: String
  let id: Int
}

extension Show {
  init?(dictionary: [String: Any]) {
    guard let showDictionary = dictionary[ShowKeys.show.rawValue] as? [String: Any],
      let title = showDictionary[ShowKeys.title.rawValue] as? String,
      let id = showDictionary[ShowKeys.id.rawValue] as? Int
    else { return nil }
    
    self.init(title: title, id: id)
  }
}

enum ShowKeys: String {
  case show = "show"
  case title = "name"
  case id = "id"
}
