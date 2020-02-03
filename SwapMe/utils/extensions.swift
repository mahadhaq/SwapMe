//
//  extensions.swift
//  SwapMe
//
//  Created by Mahad on 12/20/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation

let TYPE_DIRECT_TRADE = 0
let TYPE_TWO_TRADE = 1
let TYPE_THREE_TRADE = 2

let SHIFT_TYPE_SINGLE = "SINGLE_SHIFT"
let SHIFT_TYPE_POST_PICKUP = "POST_PICKUP_SHIFT"
let SHIFT_TYPE_POST = "SHIFT_CREATE"
let SHIFT_TYPE_PICKUP = "SHIFT_PICKUP"

let EVENT_NAME_NOTIFICATION = "Notification"
let EVENT_NAME_SHIFT_REQUEST_NOTIFICATION = "shift_request"
let EVENT_NAME_SHIFT_REQUEST_STATUS_NOTIFICATION = "shift_status"
let EVENT_NAME_SHIFT_REQUEST_NO_MORE_NOTIFICATION = "shift_request_no_more"

let postShiftColor = #colorLiteral(red: 0.9960784314, green: 0.4784313725, blue: 0.08235294118, alpha: 1)
let pickShiftColor = #colorLiteral(red: 0.5254901961, green: 0.8431372549, blue: 0.5019607843, alpha: 1)
let swapAShiftColor = #colorLiteral(red: 0.4274509804, green: 0.4235294118, blue: 0.4196078431, alpha: 1)
let partialShiftColor = #colorLiteral(red: 0.9411764706, green: 0.9529411765, blue: 0.9411764706, alpha: 1)




let AM_FRONT = "11:53"
let AM_BACK = "11:55"
let PM_FRONT = "23:56"
let PM_BACK = "23:58"

let AM_FRONT_START = "11:47"
let AM_BACK_START = "11:49"
let PM_FRONT_START = "23:51"
let PM_BACK_START = "23:53"

func getFormatedDateTime(dateStr: String, strReadFormat: String = "HH:mm:ss", strWriteFormat: String = "hh:mm a") -> String {

    var formattedDate = dateStr
    
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.none
    
    formatter.dateFormat = strReadFormat
    
    var date:Date?
    
    do
    {
        date = try formatter.date(from: dateStr)
    }
    catch
    {
    }
    formatter.dateFormat = strWriteFormat
    if date != nil
    {
        formattedDate = formatter.string(from: date!)
    }
    return formattedDate
}
