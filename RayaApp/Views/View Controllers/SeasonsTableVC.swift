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
  let cache = NSCache<NSString, UIImage>()
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
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
    
    // Custom header to look more like the project
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
    
    let cacheKey = NSString(string: episode.title)
    
    
    if let image = cache.object(forKey: cacheKey) {
      cell.showImageView.image = image
      return cell
    } else {
      if let mediumImageURL = episode.mediumImageURL {
        ShowController.shared.getImage(imageURL: mediumImageURL) { [weak self] (result) in
          guard let self = self else { return }
          switch result {
          case .success(let image):
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
              cell.showImageView.image = image
            }
          case .failure(let error):
            print(error)
          }
        }
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showSpinner(onView: self.view)
    tableView.deselectRow(at: indexPath, animated: true)
    
    let episodeDetailVC = EpisodeDetailVC()
    episodeDetailVC.providesPresentationContextTransitionStyle = true
    episodeDetailVC.definesPresentationContext = true
    
    // Episode Selected
    let episode = seasons[indexPath.section].episodes[indexPath.row]
    
    episodeDetailVC.seasonAndEpisodeLabel.text = "Season \(episode.season) Episode \(episode.episode)"
    episodeDetailVC.episodeTitleLabel.text = episode.title
    episodeDetailVC.descriptionLabel.text = episode.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    if let originalImageURL = episode.originalImageURL,
      originalImageURL != "" {
      ShowController.shared.getImage(imageURL: originalImageURL) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let image):
          DispatchQueue.main.async {
            episodeDetailVC.showImageView.image = image
            self.removeSpinner()
            self.present(episodeDetailVC, animated: true)
          }
        case .failure(let error):
          print(error)
          self.removeSpinner()
        }
      }
    } else {
      removeSpinner()
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
}
