//
//  ImageService.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation
import UIKit

class StarsService: NSObject {
    
    static let sharedInstance = StarsService()
    let cache = NSCache()
    
    override init() {
        super.init()
    }
    
    func circleImage(size: CGSize, color: UIColor) -> UIImage? {
        
        let key = color.description + " [\(size.height), \(size.width)"
        
        if let img = self.cache.objectForKey(key) as? UIImage {
            return img
        }
        
        if let image = UIImage.circle(size, color: color) {
            self.cache.setObject(image, forKey: key)
            return image
        }
        
        return nil
    }
    
}
