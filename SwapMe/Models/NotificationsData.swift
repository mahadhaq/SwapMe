//
//  NotificationsData.swift
//  SwapMe
//
//  Created by Mahad on 12/20/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation

class NotificationsData:Codable {
    var message: String = ""
        var shift = Shift()
        var request: ShiftRequest = ShiftRequest()
        var status: String = ""
    
        
}

class ShiftRequest:Codable {
    var shift = Shift()
    var user = User()
}
