//
//  Inbox.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class Inbox: NSObject {
    
    var timestamp:String! = ""
    var msg:String! = ""
    var sid:String! = ""
    var rid:String! = ""
    var rName:String! = ""
    var shiftId = ""
    var totalUnread = ""
    var msg_id = ""
    var Shiftdetail:String! = ""
 
    
    
    init(timestamp: String!, msg: String!,sid:String!,rid:String!,rName:String!,shiftId:String!,totalUnread:String!,msg_id:String!,shift_detail:String!) {
        
        self.timestamp = timestamp
        self.msg = msg
        self.rid = rid
        self.sid = sid
        self.rName = rName
        self.shiftId = shiftId
        self.totalUnread = totalUnread
        self.msg_id = msg_id
        self.Shiftdetail = shift_detail
       
        
        
        
        
    }

}
