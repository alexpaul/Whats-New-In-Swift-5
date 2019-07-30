//
//  Business.swift
//  ResultTypeDemo
//
//  Created by Alex Paul on 7/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct BusinessesSearch: Codable {
  let businesses: [Business]
  let total: Int
  struct Region: Codable {
    struct Center: Codable {
      let longitude: Double
      let latitude: Double
    }
    let center: Center
  }
  let region: Region
}

struct Business: Codable {
  let id: String
  let alias: String
  let name: String
  let image_url: String
  let is_closed: Bool
  let url: String
  let review_count: Int
}


