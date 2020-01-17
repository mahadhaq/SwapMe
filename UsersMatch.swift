//
//  UsersMatch.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class UsersMatch: NSObject {
    
    var muid:String! = ""
    var mutitle:String! = ""
    var muimage:String! = ""

    init(muid: String!, mutitle: String!,muimage:String!) {
        
        self.muid = muid
        self.mutitle = mutitle
        self.muimage = muimage
      
        
    }
}
