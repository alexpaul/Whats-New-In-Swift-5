//
//  ViewController.swift
//  ResultTypeDemo
//
//  Created by Alex Paul on 7/29/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private let apiClient = APIClient()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBusinesses()
  }
  
  private func searchBusinesses() {
    apiClient.searchBusinesses { result in
      switch result {
      case .failure(let error):
        print("error: \(error)")
      case .success(let businesses):
        let names = businesses.map { $0.name }
        print("businesses found: \(names)")
      }
    }
  }
}

