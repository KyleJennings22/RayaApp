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
  var clearButton = UIButton()
  let searchStackView = UIStackView()
  let tableView = UITableView()
  
  // Variables
  var shows: [Show] = []
  var timer: Timer?
  let delayTime: Double = 0.5
  
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
    searchStackView.addArrangedSubview(clearButton)
    
    view.addSubview(searchStackView)
    
    searchTextField.translatesAutoresizingMaskIntoConstraints = false
    searchImage.translatesAutoresizingMaskIntoConstraints = false
    clearButton.translatesAutoresizingMaskIntoConstraints = false
    searchStackView.translatesAutoresizingMaskIntoConstraints = false
    
    // Search Textfield Properties
    searchTextField.borderStyle = .roundedRect
    searchTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    
    // Search Button Properties
    clearButton.backgroundColor = .systemBlue
    clearButton.setTitle("Clear", for: .normal)
    clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    clearButton.layer.cornerRadius = 5
    clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
    
    // Search Image Properties
    searchImage.image = UIImage(systemName: "magnifyingglass")
    searchImage.contentMode = .scaleAspectFit
    searchImage.tintColor = UIColor.black
    
    // Constraining sizes for objects
    NSLayoutConstraint.activate([
      searchImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
      clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
    ])
    
    // Stackview Properties
    searchStackView.alignment = .fill
    searchStackView.distribution = .fillProportionally
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
  
  @objc func clearTextField() {
    searchTextField.text = ""
    shows = []
    tableView.reloadData()
  }
  
  /// Function that happens every time the textfield is changed
  @objc func textFieldValueChanged() {
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(timeInterval: delayTime, target: self, selector: #selector(searchForShow), userInfo: nil, repeats: false)
  }
  
  /// Function that searches for show once the timer has fired
  @objc func searchForShow() {
    guard let searchText = searchTextField.text,
    searchText != ""
    else {
      shows = []
      tableView.reloadData()
      return
    }
    
    ShowController.shared.getShows(with: searchText) { (result) in
      switch result {
      case .success(let shows):
        self.shows = shows
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
}

extension TVShowSearchVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ShowCell.showCell, for: indexPath)
    
    let show = shows[indexPath.row]
    cell.textLabel?.text = show.title
    
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let seasonsTableVC = SeasonsTableVC()
    seasonsTableVC.title = shows[indexPath.row].title
    navigationController?.pushViewController(seasonsTableVC, animated: true)
  }
}

// Safer than typing it every time
struct ShowCell {
  static let showCell = "showCell"
}
