//
//  ShowTableViewCell.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/3/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
  
  static let reuseID = "seasonCell"
  
  let cache = ShowController.shared.cache
  
  // Custom Views
  var showImageView = UIImageView()
  let titleLabel = UILabel()
  let episodeLabel = UILabel()
  let descriptionLabel = UILabel()
  
  // Properties
  private var task: URLSessionDataTask?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureCell()
    setupShowImageView()
    setupTitleLabel()
    setupEpisodeLabel()
    setupDescriptionLabel()
  }
  
  // When a cell is about to be reused, need to cancel the current download to avoid image issues
  override func prepareForReuse() {
    super.prepareForReuse()
    task?.cancel()
    showImageView.image = nil
  }
  
  // This is required for storyboards, I am not using storyboards so I can leave this as is.
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell() {
    accessoryType = .disclosureIndicator
  }
  
  // I'll explain why I put this here
  func downloadImage(imageURL: String?) {
    showImageView.image = nil
    guard let imageURL = imageURL
      else { return }
    let cacheKey = NSString(string: imageURL)
    
    // If the image is already in the cache, lets use it instead of re-downloading
    if let image = cache.object(forKey: cacheKey) {
      showImageView.image = image
      return
    }
    
    guard let url = URL(string: imageURL)
      else { return }
    
    task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
      guard let self = self else { return }
      if let error = error {
        print(error)
        return
      }
      
      guard let data = data,
        let image = UIImage(data: data)
        else { return }
      self.cache.setObject(image, forKey: cacheKey)
      
      DispatchQueue.main.async {
        self.showImageView.image = image
      }
    }
    task?.resume()
  }
  
  func setupShowImageView() {
    addSubview(showImageView)
    showImageView.translatesAutoresizingMaskIntoConstraints = false
    
    // Show Image View Properties
    showImageView.contentMode = .scaleAspectFill
    showImageView.layer.cornerRadius = 10
    showImageView.layer.masksToBounds = true
    
    
    // Show Image Constraints
    NSLayoutConstraint.activate([
      showImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      showImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      showImageView.heightAnchor.constraint(equalToConstant: 60),
      showImageView.widthAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Title Label Properties
    titleLabel.font = .systemFont(ofSize: 24)
    
    // Title Label Constraints
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4)
    ])
  }
  
  func setupEpisodeLabel() {
    addSubview(episodeLabel)
    episodeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Episode Label Properties
    episodeLabel.font = .systemFont(ofSize: 16)
    
    // Episode Label Constraints
    NSLayoutConstraint.activate([
      episodeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      episodeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
    ])
  }
  
  func setupDescriptionLabel() {
    addSubview(descriptionLabel)
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Description Text Label Properties
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.font = .systemFont(ofSize: 12)
    
    // Description Label Constraints
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      descriptionLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 4),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
