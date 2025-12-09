//
//  ItemTrip.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 10/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
struct ItemTrip: Codable{
    let deviceId: Int?
          let deviceName: String?
          let distance: Double?
          let averageSpeed: Double?
          let maxSpeed: Double?
          let spentFuel: Double?
          let startOdometer: Double?
          let endOdometer: Double?
          let startPositionId: Int?
          let endPositionId: Int?
          let startLat: Double?
          let startLon: Double?
          let endLat: Double?
          let endLon: Double?
          let startTime: String?
          let endTime: String?
          let duration: Int?
          let startAddress: String?
          let endAddress: String?
          let driverUniqueId: Int?
          let driverName: String?
}
