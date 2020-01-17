//
//  Department.swift
//  SwapMe
//
//  Created by Rao Mudassar on 13/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

/*class Department: NSObject {

    var department_type :String! = ""
    var did:String! = ""
    var name:String! = ""

    
    init(department_type: String!, did: String!, name: String!) {
        
        self.department_type = department_type
        self.did = did
        self.name = name
       
        
    }
}*/



// MARK: - BaseModel
class DepartmentResponse: Codable {
    var status: Int?
    var message: String?
    var data: DepartmentModel?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

   
}

// MARK: - DataClass
class DepartmentModel: Codable {
    var mainlineDepartments: [Departmentt]?
    var regionalDepartments: [Departmentt]?

    enum CodingKeys: String, CodingKey {
        case mainlineDepartments = "MAINLINE_DEPARTMENTS"
        case regionalDepartments = "REGIONAL_DEPARTMENTS"
    }

  
}

// MARK: - Department
class Departmentt: Codable {
    var id: Int?
    var name: String?
    var departmentType: DepartmentType?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case departmentType = "department_type"
    }

   
}

enum DepartmentType: String, Codable {
    case mainlineDepartments = "MAINLINE_DEPARTMENTS"
    case regionalDepartments = "REGIONAL_DEPARTMENTS"
}
