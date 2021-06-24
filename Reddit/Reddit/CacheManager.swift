//
//  CacheManager.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import Foundation

class CacheManager {
    static let manager = CacheManager()
    let cache = NSCache<NSString, NSData>()
    private init() {}
    
    func fetch(from imageUrl: String) -> Data? {
        return cache.object(forKey: imageUrl as NSString) as Data?
    }
    
    func cahceImage(url: String, data: Data) {
        cache.setObject(data as NSData, forKey: url as NSString)
    }
}
