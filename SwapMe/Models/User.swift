//
//  User.swift
//  SwapMe
//
//  Created by Mahad on 12/20/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class User:Codable {
    
    var id: Int = -1
    var name: String = ""
    var username: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var profile_pic: String? = ""
    var phone: String = ""
    var is_public = -1
    var fcm_token: String? = ""
    var provider: String? = ""
    var provider_id: String? = ""
}
