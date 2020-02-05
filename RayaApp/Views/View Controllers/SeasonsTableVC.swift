//
//  SeasonsTableVC.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/3/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import UIKit

class SeasonsTableVC: UITableViewController {
  
  // MARK: - Variables
  var seasons: [Season] = []
  let cache = ShowController.shared.cache
  let indicator = UIActivityIndicatorView(style: .large)
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupActivityIndicator()
    cache.removeAllObjects()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    cache.removeAllObjects()
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Season \(seasons[section].season)"
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView
      else { return }
    
    // Custom header to look more like the project specs
    header.textLabel?.font = .systemFont(ofSize: 28)
    header.textLabel?.frame = CGRect(x: 16, y: 0, width: header.frame.width, height: header.frame.height)
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return seasons.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return seasons[section].episodes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.reuseID, for: indexPath) as? ShowTableViewCell
      else { return UITableViewCell() }
    
    // Current Episode
    let episode = seasons[indexPath.section].episodes[indexPath.row]
    
    // This particular API has HTML formatting so need to get rid of that
    cell.descriptionLabel.text = episode.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    cell.titleLabel.text = episode.title
    cell.episodeLabel.text = "Episode \(episode.episode)"
    cell.downloadImage(imageURL: episode.mediumImageURL)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    indicator.startAnimating()
    
    // Getting the next view controller
    let episodeDetailVC = EpisodeDetailVC()
    episodeDetailVC.providesPresentationContextTransitionStyle = true
    episodeDetailVC.definesPresentationContext = true
    
    // Episode Selected
    let episode = seasons[indexPath.section].episodes[indexPath.row]
    
    episodeDetailVC.seasonAndEpisodeLabel.text = "Season \(episode.season) Episode \(episode.episode)"
    episodeDetailVC.episodeTitleLabel.text = episode.title
    episodeDetailVC.descriptionLabel.text = episode.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    
    // If the episode has an original image
    if let originalImageURL = episode.originalImageURL,
      originalImageURL != "" {
      ShowController.shared.getImage(imageURL: originalImageURL) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let image):
          DispatchQueue.main.async {
            self.indicator.stopAnimating()
            episodeDetailVC.showImageView.image = image
            self.present(episodeDetailVC, animated: true)
          }
        case .failure(let error):
          print(error)
        }
      }
    } else {
      present(episodeDetailVC, animated: true)
    }
  }
  
  // MARK: - Custom Functions
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func setupTableView() {
    tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.reuseID)
  }
  
  func setupActivityIndicator() {
    guard let navigationView = navigationController?.view
      else { return }
    navigationView.addSubview(indicator)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    
    // Indicator Properties
    indicator.hidesWhenStopped = true
    
    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor),
      indicator.heightAnchor.constraint(equalToConstant: 40),
      indicator.widthAnchor.constraint(equalToConstant: 40)
    ])
  }
}
