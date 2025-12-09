//
//  ItemUnidades.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 11/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
struct UnidadesModel: Codable{
    let data: [ItemUnidades]
}
struct ItemUnidades: Codable, Equatable{
    static func == (lhs: ItemUnidades, rhs: ItemUnidades ) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.groupId == rhs.groupId && lhs.uniqueId == rhs.uniqueId && lhs.status == rhs.status && lhs.lastUpdate == rhs.lastUpdate && lhs.positionId == rhs.positionId && lhs.geofenceIds == rhs.geofenceIds && lhs.phone == rhs.phone && lhs.model == rhs.model && lhs.contact == rhs.contact && lhs.category == rhs.category && lhs.disabled == rhs.disabled 
    }
    
    let id: Int?
    let attributes: AttributesUnidad?
    let groupId: Int?
    let name: String?
    let uniqueId: String?
    let status: String?
    let lastUpdate: String?
    let positionId: Int?
    let geofenceIds: Array<Int?>?
    let phone: String?
    let model: String?
    let contact: String?
    let category: String?
    let disabled: Bool?
        
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case attributes = "attributes"
        case groupId = "groupId"
        case name = "name"
        case uniqueId = "uniqueId"
        case status = "status"
        case lastUpdate = "lastUpdate"
        case positionId = "PositionID"
        case geofenceIds = "geofenceIds"
        case phone = "phone"
        case model = "model"
        case contact = "contact"
        case category = "category"
        case disabled = "disabled"
    }
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
     id = try values.decodeIfPresent(Int.self, forKey: .id)
     attributes = try values.decodeIfPresent(AttributesUnidad.self, forKey: .attributes)
     groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
     name = try values.decodeIfPresent(String.self, forKey: .name)
     uniqueId = try values.decodeIfPresent(String.self, forKey: .uniqueId)
     status = try values.decodeIfPresent(String.self, forKey: .status)
     lastUpdate = try values.decodeIfPresent(String.self, forKey: .lastUpdate)
     positionId = try values.decodeIfPresent(Int.self, forKey: .positionId)
     geofenceIds = try values.decodeIfPresent(Array<
                                                 Int>.self, forKey: .geofenceIds) as Array<Int?>?
     phone = try values.decodeIfPresent(String.self, forKey: .phone)
     model = try values.decodeIfPresent(String.self, forKey: .model)
     contact = try values.decodeIfPresent(String.self, forKey: .contact)
     category = try values.decodeIfPresent(String.self, forKey: .category)
     disabled = try values.decodeIfPresent(Bool.self, forKey: .disabled)
    }
        }


struct AttributesUnidad: Codable {
    
}
