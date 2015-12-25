//
//  UIImage+Circle.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public class func circle(size: CGSize, color: UIColor) -> UIImage? {
        
        var circle = UIImage()
        var onceToken : dispatch_once_t = 0
        
        dispatch_once(&onceToken, {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
            
            let ctx = UIGraphicsGetCurrentContext();
            let rect = CGRectMake(0, 0, size.width, size.height);
            
            CGContextSaveGState(ctx);
            CGContextSetFillColorWithColor(ctx, color.CGColor);
            CGContextFillEllipseInRect(ctx, rect);
            CGContextRestoreGState(ctx);
            
            circle = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        })
        
        return circle
    }
}