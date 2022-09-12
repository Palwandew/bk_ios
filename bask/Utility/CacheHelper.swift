//
//  CacheHelper.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import Foundation
import SwiftUI

class ImageCacheHelper {
    var cache = NSCache<NSString, CGImage>()
    
    func get(forKey: String) -> CGImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: CGImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCacheHelper {
    private static var imageCache = ImageCacheHelper()
    static let shared = imageCache
}
