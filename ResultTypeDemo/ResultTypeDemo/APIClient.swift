//
//  APIClient.swift
//  ResultTypeDemo
//
//  Created by Alex Paul on 7/29/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case badURL
  case badStatusCode(Int)
  case apiError
}

class APIClient {
  public func getData(keyword: String,
                      zipcode: String,
                      completion: @escaping (Result<[String], NetworkError>) -> Void) {
    guard let addingEncoded = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
      return
    }
    guard let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=\(addingEncoded)&location=\(zipcode)") else {
      completion(.failure(.badURL))
      return
    }
    var request = URLRequest(url: url)
    let accessToken = "csB_Ku1PXZYemDnhcmy_NkGIXtC7eI-TGYmPztkXVavX1e1rYZ4o55tscsD_9ObULhsdTQdacovr3gf_5wn-7-4ag8CMYlInvz_nGS__H6IeaF1qJhhDRaV0Q5xYWnYx"
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request) { (data, responsse, error) in
      guard let httpResponse = responsse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        completion(.failure(.badStatusCode((responsse as? HTTPURLResponse)?.statusCode ?? -999)))
        return
      }
      if let _ = error {
        completion(.failure(.apiError))
      } else {
        if let data = data {
          do {
            let businessesSearch = try? JSONDecoder().decode(BusinessesSearch.self, from: data)
            let names = businessesSearch?.businesses.map { $0.name }
            completion(.success(names ?? []))
          }
        }
      }
    }
    task.resume()
  }
}
