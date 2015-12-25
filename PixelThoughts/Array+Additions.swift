//
//  Array+Additions.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 22/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation

extension Array {
    mutating func prepend(newElement: Element) {
        self.insert(newElement, atIndex: 0)
    }
}