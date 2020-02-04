//
//  EpisodeDetailVC.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/3/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import UIKit

class EpisodeDetailVC: UIViewController {
  
  let scrollView = UIScrollView()
  let showImageView = UIImageView()
  let seasonAndEpisodeLabel = UILabel()
  let episodeTitleLabel = UILabel()
  let descriptionLabel = UILabel()
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBlur()
    setupScrollView()
    setupShowImageView()
    setupSeasonAndEpisodeLabel()
    setupEpisodeTitleLabel()
    setupDescriptionLabel()
  }
  
  // Custom Functions
  func setupBlur() {
    let blur = UIVisualEffectView()
    blur.frame = view.frame
    blur.effect = UIBlurEffect(style: .regular)
    view.addSubview(blur)
  }
  
  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.showsVerticalScrollIndicator = true
    scrollView.isScrollEnabled = true
    
    // Scroll View Properties
    scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    
    // Scroll View Constraints
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    
  }
  
  func setupShowImageView() {
    scrollView.addSubview(showImageView)
    showImageView.translatesAutoresizingMaskIntoConstraints = false
    
    // Show Image Properties
    showImageView.contentMode = .scaleAspectFit
    showImageView.layer.cornerRadius = 10
    showImageView.layer.masksToBounds = true
    
    NSLayoutConstraint.activate([
      showImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      showImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      showImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
      showImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  func setupSeasonAndEpisodeLabel() {
    scrollView.addSubview(seasonAndEpisodeLabel)
    seasonAndEpisodeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Season and Episode Label Properties
    seasonAndEpisodeLabel.font = .systemFont(ofSize: 32)
    seasonAndEpisodeLabel.textAlignment = .center
    
    // Season and Episode Label Constraints
    NSLayoutConstraint.activate([
      seasonAndEpisodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      seasonAndEpisodeLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: 16),
    ])
  }
  
  func setupEpisodeTitleLabel() {
    scrollView.addSubview(episodeTitleLabel)
    episodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Episode Title Label Properties
    episodeTitleLabel.font = .systemFont(ofSize: 18)
    episodeTitleLabel.textAlignment = .center
    episodeTitleLabel.alpha = 0.5
    
    // Episode Title Label Constraints
    NSLayoutConstraint.activate([
      episodeTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      episodeTitleLabel.topAnchor.constraint(equalTo: seasonAndEpisodeLabel.bottomAnchor, constant: 24)
    ])
  }
  
  func setupDescriptionLabel() {
    scrollView.addSubview(descriptionLabel)
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // Description Label Properties
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textAlignment = .center
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.alpha = 0.25
    
    // Description Label Constraints
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      descriptionLabel.topAnchor.constraint(equalTo: episodeTitleLabel.bottomAnchor, constant: 16),
      descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
  }
}
