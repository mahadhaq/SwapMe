//
//  Variables.swift
//  SwapMe
//
//  Created by Mr. Nabeel on 12/10/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation
import UIKit

class PostShiftvar {
    static var Static = PostShiftvar()
    var permanent = false
    var days:[String] = []
    var date = ""
    var departmentName = ""
    var starttime = ["",""]
    var endtime = ["",""]
    var deleteShiftdays = 0
}

let dayfullname = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

class PickupShiftvar {
    static var Static =  PickupShiftvar()
    var permanent = false
    var days:[String] = []
    var date = ""
    var departmentName:[String] = []
    var starttime = ["",""]
    var endtime = ["",""]
    var deleteShiftdays = 0
    
}

func resetPickupShiftvar(){
    PickupShiftvar.Static.permanent = false
    PickupShiftvar.Static.days.removeAll()
    PickupShiftvar.Static.date = ""
    PickupShiftvar.Static.departmentName.removeAll()
    PickupShiftvar.Static.starttime[0] = ""
    PickupShiftvar.Static.starttime[1] = ""
    PickupShiftvar.Static.endtime[0] = ""
    PickupShiftvar.Static.endtime[1] = ""
    PickupShiftvar.Static.deleteShiftdays = 0
    
}


func resetPostShiftvar(){
    PostShiftvar.Static.permanent = false
    PostShiftvar.Static.days.removeAll()
    PostShiftvar.Static.date = ""
    PostShiftvar.Static.departmentName = ""
    PostShiftvar.Static.starttime[0] = ""
    PostShiftvar.Static.starttime[1] = ""
    PostShiftvar.Static.endtime[0] = ""
    PostShiftvar.Static.endtime[1] = ""
    PostShiftvar.Static.deleteShiftdays = 0
}
