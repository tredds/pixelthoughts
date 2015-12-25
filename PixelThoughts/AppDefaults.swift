//
//  Defaults.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 23/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let messages = DefaultsKey<[String]>("messages")
    static let tags = DefaultsKey<[String]>("tags")
}