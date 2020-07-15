//
//  ImageCache.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    private static var caches: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.name = "ImageStore"
        cache.countLimit = 100
        return cache
    }()
    
    private static var cache: [String: Data] = [:]
    
    func store(imageData: UIImage, for key: String) {
        type(of: self).caches.setObject(imageData, forKey: key as NSString)
//        type(of: self).cache[key] = imageData
    }
    
    func imageData(for key: String) -> UIImage? {
        guard let data = (type(of: self).caches.object(forKey: key as NSString)) else {
            return nil
        }
        return data
    }
}
