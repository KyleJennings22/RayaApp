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
  let clearButton = UIButton()
  let searchStackView = UIStackView()
  let tableView = UITableView()
  
  // Variables
  var shows: [Show] = []
  var timer: Timer?
  let delayTime: Double = 0.5
  let indicator = UIActivityIndicatorView(style: .large)
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    configureNavigationBar()
    setupSearchView()
    setupTableView()
    setupActivityIndicator()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    indicator.stopAnimating()
  }
  
  // MARK: - View Setup
  /// Sets up the horizontal stack view for the search icon, text field and clear button
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
    searchTextField.backgroundColor = .clear
    searchTextField.delegate = self
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
    searchImage.tintColor = .systemFill
    
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
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    // TableView Properties
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ShowCell.showCell)
    
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
    view.backgroundColor = .systemBackground
  }
  
  @objc func clearTextField() {
    searchTextField.text = ""
    shows = []
    indicator.stopAnimating()
    tableView.reloadData()
  }
  
  /// Function that happens every time the textfield is changed
  @objc func textFieldValueChanged() {
    indicator.startAnimating()
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: delayTime, target: self, selector: #selector(searchForShow), userInfo: nil, repeats: false)
  }
  
  /// Function that searches for show once the timer has fired
  @objc func searchForShow() {
    
    // Canceling network request when new search is made
    if ShowController.shared.showTask != nil {
      ShowController.shared.showTask?.cancel()
    }
    
    // Clearing the shows array and reloading the table view if no text exists
    guard let searchText = searchTextField.text,
      searchText != ""
      else {
        shows = []
        tableView.reloadData()
        indicator.stopAnimating()
        return
    }
    
    ShowController.shared.getShows(with: searchText) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let shows):
        DispatchQueue.main.async {
          self.shows = shows
          self.indicator.stopAnimating()
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func setupActivityIndicator() {
    view.addSubview(indicator)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    
    // Indicator Properties
    indicator.hidesWhenStopped = true
    
    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      indicator.heightAnchor.constraint(equalToConstant: 40),
      indicator.widthAnchor.constraint(equalToConstant: 40)
    ])
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
    searchTextField.resignFirstResponder()
    indicator.startAnimating()
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    let seasonsTableVC = SeasonsTableVC()
    seasonsTableVC.title = shows[indexPath.row].title
    
    let showID = shows[indexPath.row].id
    
    ShowController.shared.getEpisodesFor(showID: showID) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let seasons):
        seasonsTableVC.seasons = seasons
        DispatchQueue.main.async {
          self.indicator.stopAnimating()
          self.navigationController?.pushViewController(seasonsTableVC, animated: true)
        }
      case .failure(let error):
        print(error)
      }
    }
  }
}

extension TVShowSearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}

// Safer than typing it every time
struct ShowCell {
  static let showCell = "showCell"
}
