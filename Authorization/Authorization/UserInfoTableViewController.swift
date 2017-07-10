//
//  UserInfoTableViewController.swift
//  Authorization
//
//  Created by mac on 09.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class UserInfoTableViewController: UITableViewController {
    
    // MARK: - variables
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var user = Storage.user! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var pollCountLabel: UILabel!
    
    // MARK: - internal functions
    private func updateUI() {
        userNameLabel?.text = user.name
        emailLabel?.text = user.email
        answerLabel?.text = "\(user.answerCount)"
        ratingLabel?.text = "\(user.rating)"
        pollCountLabel?.text = "\(user.pollCount)"
        print(user.answerCount)
        print(user.rating)
        print(user.pollCount)
    }
    
    // убираем лишние строки
    private func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - actions
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        Storage.user = nil
        Storage.clearPollsImageCache()
        appDelegate.openView()
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        updateUI()
        configureTableView()
        spinner.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = user.avatar
        // загрузка аватарки
        Storage.setImage(url: url) { image in
            if image == nil {
                GettingImage.fetchImage(with: url) { image in
                    self.avatarImageView.image = image
                    self.spinner.stopAnimating()
                }
                
            } else {
                self.avatarImageView.image = image
                self.spinner.stopAnimating()
            }
        }
    }
    
    // меняем границы аватарки
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        GettingImage.setRounded(avatarImageView)
    }
}
