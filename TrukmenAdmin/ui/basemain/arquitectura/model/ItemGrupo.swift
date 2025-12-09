//
//  ItemGrupo.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 11/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
struct GruposModel: Codable{
    let datos: [ItemGrupo]
}
struct ItemGrupo: Codable{
    let id: Int?
     let attributes: AttributesGrupo?
     let groupId: Int?
     let name: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case attributes = "attributes"
        case groupId = "groupId"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(AttributesGrupo.self, forKey: .attributes)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
struct AttributesGrupo: Codable {
}
