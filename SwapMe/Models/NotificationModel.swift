// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notificationModel = try? newJSONDecoder().decode(NotificationModel.self, from: jsonData)

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Decodable {
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
    var request: Request?
    var message: String?
    var shift, otherUserShift: NotShift?
    
    func getTitle() -> String {
        
        if(request != nil)
        {

            return (request!.shift?.isPermanent == "1" ? getFormattedDays(days: (request!.shift?.days)!):(request!.shift?.date)!) + ",\(request!.shift?.departments! ?? ""), \(getFormatedDateTime(dateStr: (request!.shift?.startTime)!))-\(getFormatedDateTime(dateStr: (request!.shift?.endTime)!))"
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
        
        return "Give Away: \(shift?.isPermanent == "1" ? getFormattedDays(days: (shift?.days)!):shift?.date), \(shift!.departments), \(getFormatedDateTime(dateStr: (shift?.startTime)!))-\(getFormatedDateTime(dateStr: (shift?.endTime)!))" + "\nPickup: \(otherUserShift?.isPermanent == "1" ? getFormattedDays(days: (otherUserShift?.days)!):otherUserShift?.date), \(otherUserShift?.departments), \(getFormatedDateTime(dateStr: (otherUserShift?.startTime)!))-\(getFormatedDateTime(dateStr: (otherUserShift?.endTime)!))"
    }
    
    
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
        
        return listOfDays.joined()
    }
    
    
}

// MARK: - NotShift
struct NotShift: Codable {
    var tradeName, departments: String?
    var days: String?
    var date, startTime: String?
    var eStartTime: String?
    var endTime: String?
    var eEndTime: String?
    var isPermanent, userID, shiftType: String?
    var deleteAt: String?
    var updatedAt, createdAt: String?
    var id: Int?
    var user: OtherUserShiftUser?
    var tradeType, apiCall: String?

    enum CodingKeys: String, CodingKey {
        case tradeName = "trade_name"
        case departments, days, date
        case startTime = "start_time"
        case eStartTime = "e_start_time"
        case endTime = "end_time"
        case eEndTime = "e_end_time"
        case isPermanent = "is_permanent"
        case userID = "user_id"
        case shiftType = "shift_type"
        case deleteAt = "delete_at"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, user
        case tradeType = "trade_type"
        case apiCall = "api_call"
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
    var shift: NotShift?

    enum CodingKeys: String, CodingKey {
        case shiftID = "shift_id"
        case shiftTable = "shift_table"
        case userID = "user_id"
        case userShiftID = "user_shift_id"
        case id, user, shift
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
    var emailVerifiedAt: JSONNull?
    var phone: String?
    var profilePic, departmentID: JSONNull?
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
