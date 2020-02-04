//
//  Episode.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/4/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import Foundation

struct Episode: Codable {
  let seasons: Int
  let episode: Int
  let description: String
  let imageURL: URL
}
