//
//  Message.swift
//  gameofChat
//
//  Created by Anthony Ho on 02/11/2018.
//  Copyright © 2018 Anthony Ho. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    var imageUrl: String?
    
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.toId = dictionary["toId"] as? String
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageHeight = dictionary["imageHeight"] as? NSNumber
        self.imageWidth = dictionary["imageWidth"] as? NSNumber
    }
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
}
