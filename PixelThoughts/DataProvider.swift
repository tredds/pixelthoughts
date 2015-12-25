//
//  DataProvider.swift
//  PixelThoughts
//
//  Created by Victor Tatarasanu on 23/12/15.
//  Copyright © 2015 Victor Tatarasanu. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

protocol MessagesService {
    
    func add(message: String);
    func prepend(message: String);
    func remove(message: String);
    func removeAll();
}

protocol TagsService {
    
    func add(tag: String);
    func prepend(tag: String);
    func remove(tag: String);
    func removeAll();
}

class UserDefaultsMessagesService : MessagesService {
    
    private static let instance = UserDefaultsMessagesService()
    
    /// Singleton
    
    class func sharedInstance() -> UserDefaultsMessagesService
    {
        return self.instance
    }
    
    func prepend(message: String) {
        Defaults[.messages].prepend(message)
    }
    
    func add(message: String) {
        Defaults[.messages].append(message)
    }
    
    func remove(message: String) {
        //TODO: remove
    }
    
    func removeAll() {
        Defaults[.messages].removeAll()
    }
    
    func messages() -> Array<String>{
        var messages = Defaults[.messages]
        
        if messages.count == 0 {
            messages = ["Take a deep breath in....",
                "....and breathe out",
                "Everything is okay",
                "Your life is okay",
                "Life is much grander than this thought",
                "The universe is over 93 billion light-years in distance",
                "Our galaxy is small",
                "Our sun is tiny",
                "The earth is minuscule",
                "Our cities are insignificant....",
                "....and you are microscopic",
                "This thought.... does not matter",
                "It can easily disappear",
                "and life will go on...."]
            Defaults[.messages] = messages
        }
        return messages
    }
}

class UserDefaultsTagsService : TagsService {
    
    private static let instance = UserDefaultsTagsService()
    
    /// Singleton
    
    class func sharedInstance() -> UserDefaultsTagsService
    {
        return self.instance
    }
    
    func prepend(tag: String) {
        Defaults[.tags].prepend(tag)
    }
    
    func add(tag: String) {
        Defaults[.tags].append(tag)
    }
    
    func remove(message: String) {
        //TODO: remove
    }
    
    func removeAll() {
        Defaults[.tags].removeAll()
    }
    
    func tags() -> Array<String>{
        var tags = Defaults[.tags]
        
        if tags.count == 0 {
            tags = ["Success", "Work", "Money", "School", "Friends", "Family", "Career", "School", "Drama", "Conflict", "Terrorism", "Global warming", "Exhausted", "Lonely", "Anxious", "Embarrassed", "Alone", "Lost", "I’m going to be late", "My job is awful", "I never going to be that good", "I don't fit in", "No one cares"]
            Defaults[.tags] = tags
        }
        return tags
    }
}

class DataProvider : NSObject {
    
    private static let instance = DataProvider()
    
    /// Singleton
    
    class func sharedInstance() -> DataProvider
    {
        return self.instance
    }
    
    let messegesProvider = UserDefaultsMessagesService.sharedInstance()
    let tagsProvider = UserDefaultsTagsService.sharedInstance()
}