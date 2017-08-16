//
//  movieInfo.swift
//  The movies
//
//  Created by Mac on 14/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class MovieModel : NSObject,NSCoding {
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: "title")
        aCoder.encode(posterUrl, forKey: "posterUrl")
        aCoder.encode(strBase64, forKey: "strBase64")
        
    }
    
    var title = ""
    var posterUrl = ""
    var strBase64 = ""
    
    init(dictionary: NSDictionary)
    {
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
       
        
        if let path = dictionary["poster_path"] as? String {
             baseUrl = "http://image.tmdb.org/t/p/w500"
            self.posterUrl = baseUrl + path
            
            if let url = NSURL(string: posterUrl) {
                if let data = NSData(contentsOf: url as URL) {

                     strBase64 = data.base64EncodedString(options: .lineLength64Characters)

                }
            }
            
        }
        

    }
//    override init() {
//        
//    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title       = aDecoder.decodeObject(forKey: "title") as! String
        let posterUrl     = aDecoder.decodeObject(forKey: "posterUrl") as! String
      
        let strBase64 = aDecoder.decodeObject(forKey: "strBase64") as! String
        let mydictionary = ["title": title, "posterUrl":posterUrl, "strBase64": strBase64]
        
        self.init(dictionary: mydictionary as NSDictionary)
    }
    
}

