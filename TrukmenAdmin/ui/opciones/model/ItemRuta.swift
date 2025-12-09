//
//  ItemRuta.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 18/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation

struct ItemRuta: Codable {
        let  id: Int?
        let  attributes: Attributa
        let  deviceId: Int?
        let  serverTime: String?
        let  deviceTime: String?
        let  fixTime: String?
        let  outdated: Bool?
        let  valid: Bool?
        let  latitude: Double?
        let  longitude: Double?
        let  altitude: Double?
        let  speed: Double?
        let  course: Double?
        let  accuracy: Double?
        let  type: String?
        let  address: String?
        let  network: String?
}

struct Attributa: Codable {
    let  priority: Int?
        let  sat: Int?
        let  event: Int?
        let  ignition: Bool?
        let  motion: Bool?
        let  rssi: Int?
        let  io200: Int?
        let  gpsStatus: Int?
        let  pdop: Double?
        let  hdop: Double?
        let  power: Double?
        let  battery: Double?
        let  io68: Int?
        let  `operator`: Int?
        let  io16: Int?
        let  distance: Double?
        let  totalDistance: Double?
        let  hours: Double?
}
