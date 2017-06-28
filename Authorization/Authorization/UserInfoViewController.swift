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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var user = Storage.user! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - internal functions
    private func updateUI() {
        nameLabel?.text = user.name
        emailLabel?.text = user.email
    }
    
    // MARK: - actions
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        Storage.user = nil
        Storage.image = nil
        appDelegate.openView()
    }
    
    private func getImage() {
        if Storage.image != nil {
            spinner.stopAnimating()
            imageView.image = Storage.image
        } else {
            GettingImage.fetchImage(with: user.avatar) {image in
                Storage.image = image
                self.getImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // загрузка аватарки
        spinner.startAnimating()
        getImage()
        GettingImage.setRounded(imageView)
    }
}
