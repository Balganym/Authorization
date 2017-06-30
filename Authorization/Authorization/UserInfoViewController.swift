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
        Storage.deleteImage()
        appDelegate.openView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
        // загрузка аватарку
        spinner.startAnimating()
        
        Storage.setImage() { image in
            if image == nil {
                GettingImage.fetchImage(with: self.user.avatar) { image in
                    Storage.addImage(image)
                    self.imageView.image = image
                    self.spinner.stopAnimating()
                }
                
            } else {
                self.imageView.image = image
                self.spinner.stopAnimating()
            }
        }
        GettingImage.setRounded(imageView)
    }
}
