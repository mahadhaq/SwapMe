// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let incomingRequestModel = try? newJSONDecoder().decode(IncomingRequestModel.self, from: jsonData)

import Foundation

// MARK: - IncomingRequestModel
struct IncomingRequestModel: Codable {
    var status: Int?
    var message: String?
    var data: [MsgReqDatum]?
}

// MARK: - MsgReqDatum
struct MsgReqDatum: Codable {
    var id: Int?
    var shiftID, shiftTable, userID, userShiftID: String?
    var acceptedAt, rejectedAt: MsgReqJSONNull?
    var shift: MsgReqShift?
    
    enum CodingKeys: String, CodingKey {
        case id
        case shiftID = "shift_id"
        case shiftTable = "shift_table"
        case userID = "user_id"
        case userShiftID = "user_shift_id"
        case acceptedAt = "accepted_at"
        case rejectedAt = "rejected_at"
        case shift
    }
    
    func getTitle() -> String {
        if (shift == nil)
        {
            return ""
            
        }
        else
        {
            return "\(shift!.isPermanent == "1" ? getFormattedDays(days: shift!.days!):shift!.date ?? "")," + "\(shift?.departments! ?? ""), \(getFormatedDateTime(dateStr: shift!.startTime!))-\(getFormatedDateTime(dateStr: shift!.endTime!))"
            //            return "\(if (shift?.isPermanent == "1") shift!!.days else shift!!.date})," +
            //            "${shift!!.departments}, ${getFormatedDateTime(shift!!.start_time)}-${getFormatedDateTime(
            //            shift!!.end_time)"}}
        }
    }
    
    
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
        
        return listOfDays.joined()
    }
}

// MARK: - MsgReqShift
struct MsgReqShift: Codable {
    var id: Int?
    var tradeName, tradeType: String?
    var days: String?
    var departments, date, startTime, eStartTime: String?
    var endTime, eEndTime, isPermanent, userID: String?
    var shiftType, apiCall, deleteAt, createdAt: String?
    var updatedAt: String?
    var user: MsgReqUser?
    
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

// MARK: - User
struct MsgReqUser: Codable {
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

// MARK: - Encode/decode helpers

class MsgReqJSONNull: Codable, Hashable {
    
    public static func == (lhs: MsgReqJSONNull, rhs: MsgReqJSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(MsgReqJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MsgReqJSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
