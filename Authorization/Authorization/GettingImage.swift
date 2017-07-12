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
                           completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                self.addImage(url: url, image)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - internal functions
    // Вытаскиваем с картинку кэша
    static func getImage(url key: String, completion: @escaping (UIImage?) -> Void) {
        Caches.imageCache.async.object(forKey: key, completion: completion)
    }
    
    // Добавляем картинку в кэш
    static func addImage(url key: String, _ image: UIImage) {
        //        print(key)
        Caches.imageCache.async.addObject(image, forKey: key)
    }
    
    // Очищаем кэш
    static func clearPollsImageCache() {
        Caches.imageCache.async.clear()
    }
    
}


