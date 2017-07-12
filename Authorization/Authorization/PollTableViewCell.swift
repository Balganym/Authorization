//
//  PollTableViewCell.swift
//  Authorization
//
//  Created by mac on 07.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PollTableViewCell: UITableViewCell {
    
    // MARK: - outlets
    @IBOutlet private weak var pollImageView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - variables
    var poll: Polls! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - internal functions
    private func updateUI() {
        titleLabel.text = poll!.title
        pollImageView.image = nil
        
        getImage()
    }
    
    // Достаем картинки с кэша, если там нет получаем по url,
    // и сохраняем в кэш
    private func getImage() {
        
        spinner.startAnimating()
        
        let url = poll.image
        
        GettingImage.getImage(url: url) { image in
            if image == nil {
                GettingImage.fetchImage(with: url) { image in
                    
                    if let image = image {
                        GettingImage.addImage(url: url, image)
                        self.pollImageView.image = image
                    } else {
                        self.pollImageView.image = #imageLiteral(resourceName: "bg")
                    }
        
                    self.spinner.stopAnimating()
                }
            } else {
                self.pollImageView.image = image
                self.spinner.stopAnimating()
            }
        }
    }
}
