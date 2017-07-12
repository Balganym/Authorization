//
//  UserInfoViewController.swift
//  Authorization
//
//  Created by mac on 28.06.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    // MARK: - variables
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var user = Storage.user! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!

    // MARK: - actions
    @IBAction private func logOut(_ sender: UIBarButtonItem) {
        Storage.user = nil
        GettingImage.clearPollsImageCache()
        appDelegate.openView()
    }
    
    // MARK: - internal functions
    private func updateUI() {
        nameLabel?.text = user.name
        emailLabel?.text = user.email
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        updateUI()
        spinner.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = user.avatar
        // загрузка аватарки
        GettingImage.getImage(url: url) { image in
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
}
