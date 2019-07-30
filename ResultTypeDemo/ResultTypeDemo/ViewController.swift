//
//  ViewController.swift
//  ResultTypeDemo
//
//  Created by Alex Paul on 7/29/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var apiClient = APIClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
  }
  
  private func fetchData() {
    apiClient.getData(keyword: "dim sum", zipcode: "11375") { result in
      switch result {
      case .failure(let error):
        print("error: \(error))")
      case .success(let businesses):
        print("Yelp Businesses: \(businesses)")
      }
    }
  }
}

