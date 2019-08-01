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
  case apiError(Error)
  case jsonDecodingError(Error)
}

class APIClient {
  // Result type in Swift 5 in a generic enum used on asychrousnous calls,
  // the Result is an enum that validates a .success or .failure against the call
  public func searchBusinesses(completion: @escaping (Result<[Business], NetworkError>) -> Void) {
    let endPointURL = "https://api.yelp.com/v3/businesses/search?term=coffee&location=10023"
    guard let url = URL(string: endPointURL) else {
      return
    }
    var request = URLRequest(url: url)
    let accessToken = ""
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
          completion(.failure(.badStatusCode(statusCode)))
          return
      }
      if let error = error {
        completion(.failure(.apiError(error)))
      } else if let data = data {
        do {
          let businessesSearch = try JSONDecoder().decode(BusinessesSearch.self, from: data)
          completion(.success(businessesSearch.businesses))
        } catch {
          completion(.failure(.jsonDecodingError(error)))
        }
      }
    }
    task.resume()
  }
}
