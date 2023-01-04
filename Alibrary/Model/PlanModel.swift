//
//  PlanModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import Foundation
struct PlanModel: Decodable {
    var publisherPlans: [[PublisherPlan]]
    var schoolPlans: [[PublisherPlan]]
    var guestPlans: [[PublisherPlan]]
    var rcPricings: [RCPricing]
}

enum PublisherPlan: Decodable, Hashable {
    case integer(Int)
    case string(String)

    // -- here
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
        throw DecodingError.typeMismatch(PublisherPlan.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Plan"))
    }
}


struct RCPricings: Decodable{
    var id: Int
    var name: String
    var rc_from: Int
    var rc_to: Int
    var price: Int
    var discount: Int
    var is_active: String
   
}
public struct RCPricing: Decodable {
    public var id: Int
    public var name: String
    public let price: Int
    public let discount: Int
    public let rc_from: Int
    public let rc_to: Int
    enum CodingKeys: String, CodingKey {
        case id, name, price, rc_to,rc_from,discount
    }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.price = try container.decode(Int.self, forKey: .price)
            self.rc_from = try container.decode(Int.self, forKey: .rc_from)
            self.rc_to = try container.decode(Int.self, forKey: .rc_to)
            self.discount = try container.decode(Int.self, forKey: .discount)
        }
}
