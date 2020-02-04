//
//  TVShowSearchVC.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/3/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import UIKit

class TVShowSearchVC: UIViewController {
  
  // Views
  let searchTextField = UITextField()
  let searchImage = UIImageView()
  var searchButton = UIButton()
  let searchStackView = UIStackView()
  let tableView = UITableView()
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    configureNavigationBar()
    setupSearchView()
    setupTableView()
  }
  
  // MARK: - View Setup
  func setupSearchView() {
    searchStackView.addArrangedSubview(searchImage)
    searchStackView.addArrangedSubview(searchTextField)
    searchStackView.addArrangedSubview(searchButton)
    
    view.addSubview(searchStackView)
    
    searchTextField.translatesAutoresizingMaskIntoConstraints = false
    searchImage.translatesAutoresizingMaskIntoConstraints = false
    searchButton.translatesAutoresizingMaskIntoConstraints = false
    searchStackView.translatesAutoresizingMaskIntoConstraints = false
    
    // Search Textfield Properties
    searchTextField.borderStyle = .roundedRect
    
    // Search Button Properties
    searchButton.backgroundColor = .systemBlue
    searchButton.setTitle("Search", for: .normal)
    searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    searchButton.layer.cornerRadius = 5
    
    // Search Image Properties
    searchImage.image = UIImage(systemName: "magnifyingglass")
    searchImage.contentMode = .scaleAspectFit
    searchImage.tintColor = UIColor.black
    
    // Constraining sizes for objects
    NSLayoutConstraint.activate([
      searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
      searchImage.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
      searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
    ])
    
    // Stackview Properties
    searchStackView.alignment = .fill
    searchStackView.distribution = .fill
    searchStackView.axis = .horizontal
    searchStackView.spacing = 4
    
    // Constraining Search Stackview
    NSLayoutConstraint.activate([
      searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      searchStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (view.frame.height / -3) + 24)
    ])
  }
  
  func setupTableView() {
    view.addSubview(tableView)
    
    // TableView Properties
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ShowCell.showCell)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    // Constraints for Table View
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 24),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  // MARK: - Custom Functions
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func setupViews() {
    view.backgroundColor = UIColor.white
  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  }
}

extension TVShowSearchVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ShowCell.showCell, for: indexPath)
    
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let seasonsTableVC = SeasonsTableVC()
    seasonsTableVC.title = "Test"
    navigationController?.pushViewController(seasonsTableVC, animated: true)
  }
}

extension TVShowSearchVC: UITextFieldDelegate {
  
}

enum ShowCell {
  static let showCell = "showCell"
}
