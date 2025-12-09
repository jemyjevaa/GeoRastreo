//
//  ItemEvents.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 05/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
struct ItemEvents: Codable {
     let id: Int?
     let deviceId: Int?
     let type: String?
     let eventTime: String?
     let positionId: Int?
     let geofenceId: Int?
     let maintenanceId: Int?
}

struct Attributes3: Codable {
    let result: String?
    let speed: String?
    let speedLimit: String?
}
