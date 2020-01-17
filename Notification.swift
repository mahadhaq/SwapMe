//
//  Notification.swift
//  SwapMe
//
//  Created by Rao Mudassar on 06/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class Notification: Codable {

       var timestamp:String! = ""
       var msg:String! = ""
       var profile_pic:String! = ""
       var username:String! = ""
    
        var data1:[notfyData]?
 
       
//       init(timestamp: String!, msg: String!,profile_pic:String!,username:String!) {
//
//           self.timestamp = timestamp
//           self.msg = msg
//           self.profile_pic = profile_pic
//           self.username = username
//
//
//       }
}

class notfyData:Codable {
    var data1: NotificationsData = NotificationsData()
    var event_name: String = ""
}
