//
//  Note.swift
//  SwapMe
//
//  Created by Rao Mudassar on 05/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class Note: NSObject {
    
    var nid:String! = ""
    var title:String! = ""
    var descri:String! = ""
    var updated_at:String! = ""
  
 
    
    
    init(nid: String!, title: String!,descri:String!,updated_at:String!) {
        
        self.nid = nid
        self.title = title
        self.descri = descri
        self.updated_at = updated_at
 
    }
}


