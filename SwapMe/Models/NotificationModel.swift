//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let notificationModel = try? newJSONDecoder().decode(NotificationModel.self, from: jsonData)
//
//import Foundation
//
//// MARK: - NotificationModel
//struct NotificationModel: Codable {
//    var status: Int?
//    var message: String?
//    var data: [Datum]?
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    var id: Int?
//    var userID, channelName, eventName: String?
//    var data: DataClass?
//    var hasSeen, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case channelName = "channel_name"
//        case eventName = "event_name"
//        case data
//        case hasSeen = "has_seen"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    var request: Request?
//    var message: String?
//    var shift, otherUserShift: NotShift?
//
//    func getTitle() -> String {
//
//        if(request != nil)
//        {
//
//            return (request!.shift?.isPermanent == "1" ? getFormattedDays(days: (request!.shift?.days)!):(request!.shift?.date)!) + ",\(request!.shift?.departments! ?? ""), \(getFormatedDateTime(dateStr: (request!.shift?.startTime)!))-\(getFormatedDateTime(dateStr: (request!.shift?.endTime)!))"
//        }
//
//        else if (shift?.shiftType == SHIFT_TYPE_POST || shift?.shiftType == SHIFT_TYPE_PICKUP)
//        {
//
//            return (shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.days)!):(shift?.date)!) + ",\(shift?.departments! ?? ""), \(getFormatedDateTime(dateStr: (shift?.startTime)!))-\(getFormatedDateTime(dateStr: (shift?.endTime)!))"
//        }
//        else
//        {
//            return getPostPickupTitle()
//        }
//    }
//
//    private func getPostPickupTitle() -> String {
//
//        return "Give Away: \(shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.days)!):shift?.date), \(shift!.departments), \(getFormatedDateTime(dateStr: (shift?.startTime)!))-\(getFormatedDateTime(dateStr: (shift?.endTime)!))" + "\nPickup: \(otherUserShift?.isPermanent == "1" ? getFormattedDays(days: (otherUserShift?.days)!):otherUserShift?.date), \(otherUserShift?.departments), \(getFormatedDateTime(dateStr: (otherUserShift?.startTime)!))-\(getFormatedDateTime(dateStr: (otherUserShift?.endTime)!))"
//    }
//
//
//    private func getFormattedDays(days:String) -> String {
//        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
//
//        return listOfDays.joined()
//    }
//
//
//}
//
//// MARK: - NotShift
//struct NotShift: Codable {
//    var tradeName, departments: String?
//    var days: String?
//    var date, startTime: String?
//    var eStartTime: String?
//    var endTime: String?
//    var eEndTime: String?
//    var isPermanent, userID, shiftType: String?
//    var deleteAt: String?
//    var updatedAt, createdAt: String?
//    var id: Int?
//    var user: OtherUserShiftUser?
//    var tradeType, apiCall: String?
//
//    enum CodingKeys: String, CodingKey {
//        case tradeName = "trade_name"
//        case departments, days, date
//        case startTime = "start_time"
//        case eStartTime = "e_start_time"
//        case endTime = "end_time"
//        case eEndTime = "e_end_time"
//        case isPermanent = "is_permanent"
//        case userID = "user_id"
//        case shiftType = "shift_type"
//        case deleteAt = "delete_at"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id, user
//        case tradeType = "trade_type"
//        case apiCall = "api_call"
//    }
//}
//
//// MARK: - OtherUserShiftUser
//struct OtherUserShiftUser: Codable {
//    var id: Int?
//    var firstName, lastName, username, email: String?
//    var phone: String?
//    var profilePic: String?
//    var isPublic: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case username, email, phone
//        case profilePic = "profile_pic"
//        case isPublic = "is_public"
//    }
//}
//
//// MARK: - Request
//struct Request: Codable {
//    var shiftID: ShiftID?
//    var shiftTable, userID, userShiftID: String?
//    var id: Int?
//    var user: RequestUser?
//    var shift: NotShift?
//
//    enum CodingKeys: String, CodingKey {
//        case shiftID = "shift_id"
//        case shiftTable = "shift_table"
//        case userID = "user_id"
//        case userShiftID = "user_shift_id"
//        case id, user, shift
//    }
//}
//
//enum ShiftID: Codable {
//    case integer(Int)
//    case string(String)
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Int.self) {
//            self = .integer(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        throw DecodingError.typeMismatch(ShiftID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShiftID"))
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .integer(let x):
//            try container.encode(x)
//        case .string(let x):
//            try container.encode(x)
//        }
//    }
//}
//
//// MARK: - RequestUser
//struct RequestUser: Codable {
//    var id: Int?
//    var firstName, lastName, username, email: String?
//    var emailVerifiedAt: String?
//    var phone: String?
//    var profilePic, departmentID: String?
//    var role, isPublic, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case username, email
//        case emailVerifiedAt = "email_verified_at"
//        case phone
//        case profilePic = "profile_pic"
//        case departmentID = "department_id"
//        case role
//        case isPublic = "is_public"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notificationModel = try? newJSONDecoder().decode(NotificationModel.self, from: jsonData)

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Codable {
    var status: Int?
    var message: String?
    var data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int?
    var userID, channelName, eventName: String?
    var data: DataClass?
    var hasSeen, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case channelName = "channel_name"
        case eventName = "event_name"
        case data
        case hasSeen = "has_seen"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var shift: PurpleShift?
    var secondNode: Node?
    var thirdNode, fourthNode: Node?
    var request: Request?
    var message: String?
    var otherUserShift: OtherUserShiftClass?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case shift
        case secondNode = "second_node"
        case thirdNode = "third_node"
        case fourthNode = "fourth_node"
        case message, request, otherUserShift, status
    }
    func getTitle() -> String {
            
        if(request != nil)
        {
            return (request!.shift?.isPermanent == "1" ? getFormattedDays(days: request!.shift?.days ?? ""):request!.shift?.date ?? "") + ",\(request!.shift?.departments ?? ""), \(getFormatedDateTime(dateStr: request!.shift?.startTime ?? ""))-\(getFormatedDateTime(dateStr: request!.shift?.endTime ?? ""))"
        }
        else if (shift?.shiftType == SHIFT_TYPE_POST || shift?.shiftType == SHIFT_TYPE_PICKUP)
        {
                
            return (shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.days)!):(shift?.date)!) + ",\(shift?.departments! ?? ""), \(getFormatedDateTime(dateStr: (shift?.startTime)!))-\(getFormatedDateTime(dateStr: (shift?.endTime)!))"
        }
        else
        {
            return getPostPickupTitle()
        }
    }
        
    private func getPostPickupTitle() -> String {
            
        return "Give Away: \(shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.postDays)!):shift?.postDate ?? ""), \(shift?.postDepartment ?? ""), \(getFormatedDateTime(dateStr: (shift?.postStartTime)!))-\(getFormatedDateTime(dateStr: (shift?.postEndTime)!))" + "\nPickup: \(shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.pickupDays)!):shift?.pickupDate ?? ""), \(shift?.pickupDepartments ?? ""), \(getFormatedDateTime(dateStr: (shift?.pickupStartTime)!))-\(getFormatedDateTime(dateStr: (shift?.pickupEndTime)!))"
    }
        
        
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
            
        return listOfDays.joined()
    }
        
    
}

// MARK: - OtherUserShiftClass
struct OtherUserShiftClass: Codable {
    var tradeName, departments: String?
    var days: String?
    var date, startTime, eStartTime, endTime: String?
    var eEndTime, isPermanent, userID, shiftType: String?
    var deleteAt, updatedAt, createdAt: String?
    var id: Int?
    var tradeType: String?
    var apiCall: APICall?
    var user: OtherUserShiftUser?

    enum CodingKeys: String, CodingKey {
        case id
        case tradeName = "trade_name"
        case tradeType = "trade_type"
        case days, departments, date
        case startTime = "start_time"
        case eStartTime = "e_start_time"
        case endTime = "end_time"
        case eEndTime = "e_end_time"
        case isPermanent = "is_permanent"
        case userID = "user_id"
        case shiftType = "shift_type"
        case apiCall = "api_call"
        case deleteAt = "delete_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}


// MARK: - OtherUserShiftUser
struct OtherUserShiftUser: Codable {
    var id: Int?
    var firstName, lastName, username, email: String?
    var phone: String?
    var profilePic: String?
    var isPublic: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email, phone
        case profilePic = "profile_pic"
        case isPublic = "is_public"
    }
}


// MARK: - Request
struct Request: Codable {
    var shiftID: ShiftID?
    var shiftTable, userID, userShiftID: String?
    var id: Int?
    var user: RequestUser?
    var shift: OtherUserShiftClass?
    var acceptedAt, rejectedAt: String?

    enum CodingKeys: String, CodingKey {
        case shiftID = "shift_id"
        case shiftTable = "shift_table"
        case userID = "user_id"
        case userShiftID = "user_shift_id"
        case id, user, shift
        case acceptedAt = "accepted_at"
        case rejectedAt = "rejected_at"
    }
}

enum ShiftID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ShiftID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShiftID"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


// MARK: - RequestUser
struct RequestUser: Codable {
    var id: Int?
    var firstName, lastName, username, email: String?
    var emailVerifiedAt: String?
    var phone: String?
    var profilePic: String?
    var departmentID: String?
    var role, isPublic, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email
        case emailVerifiedAt = "email_verified_at"
        case phone
        case profilePic = "profile_pic"
        case departmentID = "department_id"
        case role
        case isPublic = "is_public"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Node
struct Node: Codable {
    var userID, isPermanent, tradeType: String?
    var tradeName: TradeName?
    var postDays: String?
    var postDate, postStartTime, postEndTime: String?
    var postDepartment: String?
    var pickupDays: String?
    var pickupDate, pickupStartTime, pickupEStartTime, pickupEndTime: String?
    var pickupEEndTime, pickupDepartments, deleteAt, updatedAt: String?
    var createdAt: String?
    var id: Int?
    var user: RequestUser?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case isPermanent = "is_permanent"
        case tradeType = "trade_type"
        case tradeName = "trade_name"
        case postDays = "post_days"
        case postDate = "post_date"
        case postStartTime = "post_start_time"
        case postEndTime = "post_end_time"
        case postDepartment = "post_department"
        case pickupDays = "pickup_days"
        case pickupDate = "pickup_date"
        case pickupStartTime = "pickup_start_time"
        case pickupEStartTime = "pickup_e_start_time"
        case pickupEndTime = "pickup_end_time"
        case pickupEEndTime = "pickup_e_end_time"
        case pickupDepartments = "pickup_departments"
        case deleteAt = "delete_at"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, user
    }
}

// MARK: - PurpleShift
struct PurpleShift: Codable {
    var id: Int?
    var userID, isPermanent, tradeType: String?
    var tradeName: TradeName?
    var postDays: String?
    var postDate, postStartTime, postEndTime: String?
    var postDepartment: String?
    var pickupDays: String?
    var pickupDate, pickupStartTime, pickupEStartTime, pickupEndTime: String?
    var pickupEEndTime: String?
    var pickupDepartments: String?
    var status: String?
    var deleteAt: String?
    var createdAt, updatedAt: String?
    var user: RequestUser?
    var departments: String?
    var days: String?
    var date, startTime: String?
    var eStartTime: String?
    var endTime: String?
    var eEndTime: String?
    var shiftType: String?
    var apiCall: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case isPermanent = "is_permanent"
        case tradeType = "trade_type"
        case tradeName = "trade_name"
        case postDays = "post_days"
        case postDate = "post_date"
        case postStartTime = "post_start_time"
        case postEndTime = "post_end_time"
        case postDepartment = "post_department"
        case pickupDays = "pickup_days"
        case pickupDate = "pickup_date"
        case pickupStartTime = "pickup_start_time"
        case pickupEStartTime = "pickup_e_start_time"
        case pickupEndTime = "pickup_end_time"
        case pickupEEndTime = "pickup_e_end_time"
        case pickupDepartments = "pickup_departments"
        case status
        case deleteAt = "delete_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, departments, days, date
        case startTime = "start_time"
        case eStartTime = "e_start_time"
        case endTime = "end_time"
        case eEndTime = "e_end_time"
        case shiftType = "shift_type"
        case apiCall = "api_call"
    }
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
