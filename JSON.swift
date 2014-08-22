//
//  JSON.swift
//  Beautifully Simple JSON in Swift
//
//  Created by Tanner Nelson on 8/21/14.
//  Copyright (c) 2014 Tanner Nelson. All rights reserved.
//

import Foundation

protocol Parsable {
    init(dictionary: [String: AnyObject])
}

class JSON {
    
    class func getString(json: [String: AnyObject]?, key: String) -> String? {
        let maybeString: AnyObject? = json?[key]
        return maybeString as? String
    }
    
    class func getDictionary(json: [String: AnyObject]?, key: String) -> [String: AnyObject]? {
        let maybeDictionary: AnyObject? = json?[key]
        return maybeDictionary as? [String: AnyObject]
    }
    
    class func getArray(json: [String: AnyObject]?, key: String) -> [AnyObject]? {
        let maybeArray: AnyObject? = json?[key]
        return maybeArray as? [AnyObject]
    }
    
    class func getParsedDictionary<T: Parsable>(dictionary: [String: AnyObject]) -> T {
        let parsedDictionary = T(dictionary: dictionary)
        return parsedDictionary
    }
    
    class func getParsedArray<T: Parsable>(array: [AnyObject]) -> [T] {
        var parsedArray = [T]()
        for dictionary in array {
            let dictionary = dictionary as [String: AnyObject]
            let parsedDictionary: T = self.getParsedDictionary(dictionary)
            parsedArray.append(parsedDictionary)
        }
        return parsedArray
    }
 
}

