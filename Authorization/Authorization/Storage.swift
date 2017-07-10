//
//  Storage.swift
//  Authorization
//
//  Created by mac on 27.06.17.
//  Copyright © 2017 mac. All rights reserved.
//

import Cache

// MARK: - caches
private struct Caches {
    static let jsonCache = SpecializedCache<JSON>(name: "JSON Cache")
    static let imageCache = SpecializedCache<UIImage>(name: "image Cache")
}

// MARK: - keys
private struct Keys {
    static let user = "User"
}

struct Storage {
    
    // MARK: - variables
    static var user: User? {
        get {
            if let json = Caches.jsonCache.object(forKey: Keys.user) {
                switch json {
                case .dictionary(let userJson): return User(JSON: userJson)
                default: break
                }
            }
            return nil
        }
        set {
            if let user = newValue {
                try! Caches.jsonCache.addObject(JSON.dictionary(user.toJSON()), forKey: Keys.user)
            } else {
                try! Caches.jsonCache.removeObject(forKey: Keys.user)
            }
        }
    }
    
    // MARK: - internal functions
    // Вытаскиваем с картинку кэша
    static func setImage(url key: String, completion: @escaping (UIImage?) -> Void) {
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




