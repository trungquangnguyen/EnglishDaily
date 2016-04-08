//
//  EDWordModel.swift
//  EnglishDaily
//
//  Created by Dong Nguyen on 3/16/16.
//  Copyright © 2016 sTeam. All rights reserved.
//

import UIKit


class EDWordModel: NSObject {
    var title: String
    var type: String
    var pronunciationUS: String
    var pronunciationUK: String
    var urlAudioUS: NSURL
    var urlAudioUK: NSURL
    
    required init(data : Dictionary<String, Any>?) {
        self.title = ""
        self.type = ""
        self.pronunciationUS = ""
        self.pronunciationUK = ""
        self.type = ""
        self.type = ""
        if let word = data!["word"] as? String {
            self.title = word
        }
        
        if let typeWords = data!["typeWords"] as? String {
            self.type = typeWords
        }
        
        if let proBre = data!["proBre"] as? String {
            self.pronunciationUS = proBre
        }
        
        if let proName = data!["proName"] as? String {
            self.pronunciationUK = proName
        }
//        
//        if var proBreSound = data!["proBreSound"] as? String {
//            self.pronunciationUK = NSURL(fileURLWithPath: proBreSound, relativeToURL: nil)
//        }
//
//        if var proName = data!["proName"] as? String {
//            self.pronunciationUK = proName
//        }
        self.urlAudioUK = NSURL(string: "123")!
        self.urlAudioUS = NSURL(string: "123")!
        //        self.number = number
        //        self.scale = scale
        
    }
    
    func createTextFromModel()->String{
        return "\(title)\n\(type)\n\(pronunciationUK)\(pronunciationUS)";
    }
    
}
