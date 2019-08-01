//
//  ViewController.swift
//  ResultTypeDemo
//
//  Created by Alex Paul on 7/29/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  private let apiClient = APIClient()
  private var businesses = [Business]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    tableView.dataSource = self
    searchBusinesses()
  }
  
  private func searchBusinesses() {
    apiClient.searchBusinesses { result in
      switch result {
      case .failure(let error):
        print("error: \(error)")
      case .success(let businesses):
        self.businesses = businesses
      }
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return businesses.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath)
    let business = businesses[indexPath.row]
    cell.textLabel?.text = business.name
    return cell
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    print(searchBar.text ?? "")
    searchBar.text = ""
  }
}

