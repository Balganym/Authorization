//
//  Storage.swift
//  Authorization
//
//  Created by mac on 27.06.17.
//  Copyright © 2017 mac. All rights reserved.
//

import Cache

private struct Caches {
    static let jsonCache = SpecializedCache<JSON>(name: "JSON Cache")
    static let imageCache = SpecializedCache<UIImage>(name: "image Cache")
}

private struct Keys {
    static let user = "User"
    static let image = "Image"
}

struct Storage {
    
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
    
    static var image: UIImage? {
        get {
            return Caches.imageCache.object(forKey: Keys.image)
        }
        set {
            if let newImage = newValue {
                try! Caches.imageCache.addObject(newImage, forKey: Keys.image)
            } else {
                try! Caches.imageCache.removeObject(forKey: Keys.image)
            }
        }
    }
}
