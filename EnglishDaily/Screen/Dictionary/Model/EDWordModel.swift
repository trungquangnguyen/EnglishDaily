//
//  EDWordModel.swift
//  EnglishDaily
//
//  Created by Dong Nguyen on 3/16/16.
//  Copyright © 2016 sTeam. All rights reserved.
//

import UIKit


class EDWordModel: NSObject {
    let title: String
    let type: String
    let urlAudioUS: NSURL
    let urlAudioUK: NSURL
    
    required init(data : NSDictionary) {
        self.title = (data[""]?.string)!
        self.urlAudioUK = NSURL(string: (data[""]?.string)!)!
//        self.number = number
//        self.scale = scale
    }
}
