//
//  SeasonsTableVC.swift
//  RayaApp
//
//  Created by Kyle Jennings on 2/3/20.
//  Copyright © 2020 Kyle Jennings. All rights reserved.
//

import UIKit

class SeasonsTableVC: UITableViewController {
  
  // MARK: - Lifecycle Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.reuseID, for: indexPath) as? ShowTableViewCell
      else { return UITableViewCell() }
    
    cell.descriptionLabel.text = "al;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdj"
    cell.titleLabel.text = "Test Title"
    cell.episodeLabel.text = "Test Episode"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let episodeDetailVC = EpisodeDetailVC()
    episodeDetailVC.providesPresentationContextTransitionStyle = true
    episodeDetailVC.definesPresentationContext = true
    
    // FIXME: - CHANGE THIS
    episodeDetailVC.seasonAndEpisodeLabel.text = "Season 1 Episode 1"
    episodeDetailVC.episodeTitleLabel.text = "Girls with Guns"
    episodeDetailVC.descriptionLabel.text = "al;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdjal;ksdjfa;klsjdfkl;ajdf;ajf;ldja;fsdj;ajf;asjf;sajf;adjf;ajfd;ajf;dajsf;dajdf;ajf;aj;fajf;ldajf;aj;;;;;;;;;;jflasjdf;asjfd;alsjfas;fj;ljd;ja;fjd;fja;fjd;afja;fdj"
    present(episodeDetailVC, animated: true)
  }
  
  // MARK: - Custom Functions
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func setupTableView() {
    tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.reuseID)
  }
}
