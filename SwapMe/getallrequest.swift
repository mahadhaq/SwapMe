//
//  getallrequest.swift
//  SwapMe
//
//  Created by Shawal's Mac on 29/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation
class AllRequest: NSObject {
    
    
    var swapDate:String! = ""
    var swapDeps:String! = ""
    var swapStart:String! = ""
    var swapEnd:String! = ""
  //  var swapID:String! = ""
    //var swapType:String! = ""
    
    
    
    
    init(swapDate: String!, swapDeps: String!,swapStart:String!,swapEnd: String!) {
        
        self.swapDate = swapDate
        self.swapDeps = swapDeps
        self.swapStart = swapStart
        self.swapEnd = swapEnd
      
        //self.swapType = swapType

        
    }

}
