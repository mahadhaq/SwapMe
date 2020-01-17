//
//  History.swift
//  SwapMe
//
//  Created by Rao Mudassar on 18/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class History: NSObject {
    
    
    var swapDate:String! = ""
    var swapDeps:String! = ""
    var swapStart:String! = ""
    var swapEnd:String! = ""
    var swapID:String! = ""
    var swapType:String! = ""
    
    
    
    
    init(swapDate: String!, swapDeps: String!,swapStart:String!,swapEnd: String!, swapID: String!, swapType: String!) {
        
        self.swapDate = swapDate
        self.swapDeps = swapDeps
        self.swapStart = swapStart
        self.swapEnd = swapEnd
        self.swapID = swapID
        self.swapType = swapType

        
    }

}
