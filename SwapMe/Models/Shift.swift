//
//  Shift.swift
//  SwapMe
//
//  Created by Mahad on 12/19/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class Shift: Codable {
    
    var id: Int = -1
    var is_permanent: String = ""
    var departments: String = ""
    var shift_type: String? = ""
    var date: String? = ""
    var days: String? = ""
    var start_time: String = ""
    var end_time: String = ""
    var post_days: String?
    var post_date: String? = ""
    var post_department: String = ""
    var post_start_time: String = ""
    var post_end_time: String = ""
    var pickup_days: String?
    var pickup_date: String? = ""
    var pickup_departments = ""
    var pickup_start_time: String = ""
    var pickup_e_start_time: String = ""
    var pickup_end_time: String = ""
    var pickup_e_end_time: String = ""
    var user = User()
    
    func getTitle() -> String {
        if (shift_type == SHIFT_TYPE_POST || shift_type == SHIFT_TYPE_PICKUP)
        {
            
            
            return (is_permanent == "1" ? getFormattedDays(days: days!):date!) + "\(departments), \(getFormatedDateTime(dateStr: start_time))-\(getFormatedDateTime(dateStr: end_time))"
        }
        else
        {
            return getPostPickupTitle()
        }
    }
    
    private func getPostPickupTitle() -> String {
        return "Give Away: \(is_permanent == "1" ? getFormattedDays(days: post_days!):post_date!), \(post_department), \(getFormatedDateTime(dateStr: post_start_time))-\(getFormatedDateTime(dateStr: post_end_time))" + "\nPickup: \(is_permanent == "1" ? getFormattedDays(days: pickup_days!):pickup_date!), \(pickup_departments), \(getFormatedDateTime(dateStr: pickup_start_time))-\(getFormatedDateTime(dateStr: pickup_end_time))"
    }
    
    
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
        
        return listOfDays.joined()
    }
}
