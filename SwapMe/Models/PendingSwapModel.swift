// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pendingSwapModel = try? newJSONDecoder().decode(PendingSwapModel.self, from: jsonData)

import Foundation

// MARK: - PendingSwapModel
struct PendingSwapModel: Codable {
    var status: Int?
    var message: String?
    var data: PendingDataClass?
}

// MARK: - PendingDataClass
struct PendingDataClass: Codable {
    var postShifts, pickupShifts: [PendingSwapShift]?
    var postPickupShifts: [PostPickupShift]?
}

// MARK: - PendingSwapShift
struct PendingSwapShift: Codable {
    var shift: TradeClass?
    var trades: [TradeClass]?
}

// MARK: - TradeClass
struct TradeClass: Codable {
    var id: Int?
    var tradeName: TradeName?
    var tradeType: String?
    var days: String?
    var departments: String?
    var date, startTime: String?
    var eStartTime: String?
    var endTime: String?
    var eEndTime: String?
    var isPermanent, userID: String?
    var shiftType: ShiftType?
    var apiCall: APICall?
    var deleteAt: String?
    var createdAt, updatedAt: String?
    var user: TradeUser?

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
    
    
    func getTitle() -> String {
        
        return (isPermanent == "1" ? getFormattedDays(days: days!):date!) + ",\(departments!), \(getFormatedDateTime(dateStr: startTime!))-\(getFormatedDateTime(dateStr: endTime!))"
       
    }
    
   
    
    
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
        
        return listOfDays.joined()
    }
    
    
}

enum APICall: String, Codable {
    case single = "SINGLE"
}

//enum Departments: String, Codable {
//    case mlABR = "ML ABR"
//    case mlCsr = "ML CSR"
//}

enum ShiftType: String, Codable {
    case shiftCreate = "SHIFT_CREATE"
    case shiftPickup = "SHIFT_PICKUP"
    case POSTPICKUPSHIFT = "POST_PICKUP_SHIFT"
}

enum TradeName: String, Codable {
    case defaultTrade = "Default trade"
    case purpleDefaultTrade = "default trade"
    case tradeNameDefaultTrade = "Default Trade"
}

// MARK: - TradeUser
struct TradeUser: Codable {
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

// MARK: - PostPickupShift
struct PostPickupShift: Codable {
    var shift: ShiftElement?
    var trades: Trades?
}

// MARK: - ShiftElement
struct ShiftElement: Codable {
    var id: Int?
    var userID, isPermanent, tradeType: String?
    var tradeName: TradeName?
    var postDays: String?
    var postDate, postStartTime, postEndTime: String?
    var postDepartment: String?
    var pickupDays: String?
    var pickupDate, pickupStartTime, pickupEStartTime, pickupEndTime: String?
    var pickupEEndTime, pickupDepartments, status, deleteAt: String?
    var createdAt, updatedAt: String?
    var user: Trade0User?

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
        case user
    }
    
     func getPostPickupTitle() -> String {
           return "Give Away: \(isPermanent == "1" ? getFormattedDays(days: postDays!):postDate!), \(postDepartment!), \(getFormatedDateTime(dateStr: postStartTime!))-\(getFormatedDateTime(dateStr: postEndTime!))" + "\nPickup: \(isPermanent == "1" ? getFormattedDays(days: pickupDays!):pickupDate!), \(pickupDepartments!), \(getFormatedDateTime(dateStr: pickupStartTime!))-\(getFormatedDateTime(dateStr: pickupEndTime!))"
       }
    
    private func getFormattedDays(days:String) -> String {
        let listOfDays: [String] = days.components(separatedBy: ",").map({($0.trimmingCharacters(in: .whitespaces)+"s")})
        
        return listOfDays.joined()
    }
}

// MARK: - Trade0User
struct Trade0User: Codable {
    var id: Int?
    var firstName, lastName, username, email: String?
    var emailVerifiedAt: String?
    var phone: String?
    var profilePic, departmentID: String?
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

// MARK: - Trades
struct Trades: Codable {
    var trade0: [ShiftElement]?
    var trade1, trade2: [JSONAny]?
}

// MARK: - Encode/decode helpers

class PendingJSONNull: Codable, Hashable {

    public static func == (lhs: PendingJSONNull, rhs: PendingJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(PendingJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PendingJSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return PendingJSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return PendingJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return PendingJSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is PendingJSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is PendingJSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is PendingJSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
