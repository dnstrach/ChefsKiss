//
//  CacheManager.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 1/14/25.
//

import Foundation

// used for searching recipes because initial default recipes will show then after each search previous search will show first
//class CacheManager {
//    static let instance = CacheManager()
//    var cachedKeys: [NSString] = []
//    
//    var recipesCache = NSCache<NSString, NSArray>()
//    
//    func add(recipes: [APIRecipe], search: String) {
//        let key = search as NSString
//        recipesCache.setObject(recipes as NSArray, forKey: search as NSString)
//        if !cachedKeys.contains(key) {
//            cachedKeys.append(key)
//        }
//    }
//    
//    func remove(search: String) {
//        recipesCache.removeObject(forKey: search as NSString)
//    }
//    
//    func get(search: String) -> [APIRecipe]? {
//        print(cachedKeys)
//        return recipesCache.object(forKey: search as NSString) as? [APIRecipe]
//    }
//}
