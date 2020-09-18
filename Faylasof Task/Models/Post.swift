//
//  Post.swift
//  Faylasof Task
//
//  Created by Fady Hanna on 9/14/20.
//  Copyright © 2020 Fady Hanna. All rights reserved.
//

import Foundation

class Post : Codable {
    
    //MARK: Properties
    var id: Int?
    var title: String
    var description: String
    var img_url: String?
    var video_url: String?
    var likes_count: Int?
    
    init(id: Int?,
         title: String,
         description: String,
         img_url: String?,
         video_url: String?,
         likes_count: Int?) {
        
        self.id = id
        self.title = title
        self.description = description
        self.img_url = img_url
        self.video_url = video_url
        self.likes_count = likes_count
    }
    
//    init(fromDict: [String : Any]) {
//        if let id = fromDict["id"] else {
//
//        }
        
//        self.id = id
//        self.title = title
//        self.description = description
//        self.img_url = img_url
//        self.video_url = video_url
//        self.likes_count = likes_count
//    }
    
    var asDictionary : [String:Any] {
      let mirror = Mirror(reflecting: self)
      let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
        guard let label = label else { return nil }
        return (label, value)
      }).compactMap { $0 })
      return dict
    }
    
    
    func toObject() -> [String : Any] {

        var objDict : [String : Any]!
        

        if let id = self.id {
            objDict["id"] = id;
        }
    
        objDict["title"] = title;
        objDict["description"] = description;
    
        if let img_url = self.img_url {
            objDict["img_url"] = img_url;
        }
               
        if let video_url = self.video_url {
            objDict["video_url"] = video_url;
        }


        return objDict;
    }
    
}
