//
//  gettingImage.swift
//  Authorization
//
//  Created by mac on 27.06.17.
//  Copyright © 2017 mac. All rights reserved.
//

import Alamofire
import AlamofireImage

private struct Constants {
    static let borderColor = UIColor(red: 101/255, green: 112/255, blue: 147/255, alpha: 100).cgColor
}

struct GettingImage {
    
    static func fetchImage(with url: String,
                           completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
    
    static func setRounded(_ imageView: UIImageView) {
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = Constants.borderColor
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
    }
}


