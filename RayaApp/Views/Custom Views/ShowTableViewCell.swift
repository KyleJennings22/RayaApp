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
  
  // Custom Views
  let showImageView = UIImageView()
  let titleLabel = UILabel()
  let episodeLabel = UILabel()
  let descriptionLabel = UILabel()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureCell()
  }
  
  // This is required for storyboards, I am not using storyboard so I can leave this as is.
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell() {
    addSubview(showImageView)
    addSubview(titleLabel)
    addSubview(episodeLabel)
    addSubview(descriptionLabel)
    
    showImageView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    episodeLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Show Image View Properties
    showImageView.contentMode = .scaleAspectFit
    showImageView.backgroundColor = .red
    showImageView.layer.cornerRadius = 10
    
    // Show Image Constraints
    NSLayoutConstraint.activate([
      showImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      showImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      showImageView.heightAnchor.constraint(equalToConstant: 60),
      showImageView.widthAnchor.constraint(equalToConstant: 60)
    ])
    
    // Title Label Properties
    titleLabel.font = .systemFont(ofSize: 32)
    
    // Title Label Constraints
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4)
    ])
    
    // Episode Label Properties
    episodeLabel.font = .systemFont(ofSize: 12)
    
    // Episode Label Constraints
    NSLayoutConstraint.activate([
      episodeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      episodeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
    ])
    
    // Description Text View Properties
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    
    // Description Label Constraints
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      descriptionLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 4),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    accessoryType = .disclosureIndicator
    
  }
}
