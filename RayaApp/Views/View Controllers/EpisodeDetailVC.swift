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
  }
  
  // Custom Functions
  func setupBlur() {
    let blur = UIVisualEffectView()
    blur.frame = view.frame
    blur.effect = UIBlurEffect(style: .extraLight)
    view.addSubview(blur)
  }
  
  func setupScrollView() {
    scrollView.addSubview(showImageView)
    scrollView.addSubview(seasonAndEpisodeLabel)
    scrollView.addSubview(episodeTitleLabel)
    scrollView.addSubview(descriptionLabel)
    
    view.addSubview(scrollView)
    
    showImageView.translatesAutoresizingMaskIntoConstraints = false
    seasonAndEpisodeLabel.translatesAutoresizingMaskIntoConstraints = false
    episodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.showsVerticalScrollIndicator = true
    scrollView.isScrollEnabled = true
    
    // Scroll View Properties
//    scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    
    // Scroll View Constraints
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    // Show Image Properties
    showImageView.contentMode = .scaleAspectFit
    showImageView.backgroundColor = .red
    showImageView.layer.cornerRadius = 10
    
    NSLayoutConstraint.activate([
      showImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      showImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      showImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
      showImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
    
    // Season and Episode Label Properties
    seasonAndEpisodeLabel.font = .systemFont(ofSize: 32)
    seasonAndEpisodeLabel.textAlignment = .center
    
    // Season and Episode Label Constraints
    NSLayoutConstraint.activate([
      seasonAndEpisodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      seasonAndEpisodeLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: 16),
    ])
    
    // Episode Title Label Properties
    episodeTitleLabel.font = .systemFont(ofSize: 18)
    episodeTitleLabel.textAlignment = .center
    episodeTitleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    // Episode Title Label Constraints
    NSLayoutConstraint.activate([
      episodeTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      episodeTitleLabel.topAnchor.constraint(equalTo: seasonAndEpisodeLabel.bottomAnchor, constant: 24)
    ])
    
    // Description Label Properties
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textAlignment = .center
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    
    // Description Label Constraints
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      descriptionLabel.topAnchor.constraint(equalTo: episodeTitleLabel.bottomAnchor, constant: 16),
      descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
    
  }
}
