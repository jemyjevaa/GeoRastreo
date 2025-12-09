//
//  userModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/31/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let datos: [Usuario]
    let respuesta: String
}
struct Item_erroruser: Codable {
    let datos: String
    let respuesta: String
}
struct Usuario: Codable {
        let id: Int?
        let attributes: Attributes?
        let name: String?
        let login: String?
        let email: String?
        let phone: String?
        let readonly: Bool?
        let administrator: Bool?
        let map: String?
        let latitude: Double?
        let longitude: Double?
        let zoom: Int?
        let twelveHourFormat: Bool?
        let coordinateFormat: String?
        let disabled: Bool?
        let expirationTime: String?
        let deviceLimit: Int?
        let userLimit: Int?
        let deviceReadonly: Bool?
        let token: String?
        let limitCommands: Bool?
        let poiLayer: String?
        let password: String?
    
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case attributes = "attributes"
           case name = "name"
           case login = "login"
           case email = "email"
           case phone = "phone"
           case readonly = "readonly"
           case administrator = "administrator"
           case map = "map"
           case latitude = "latitude"
           case longitude = "longitude"
           case zoom = "zoom"
           case twelveHourFormat = "twelveHourFormat"
           case coordinateFormat = "coordinateFormat"
           case disabled = "disabled"
           case expirationTime = "expirationTime"
           case deviceLimit = "deviceLimit"
           case userLimit = "userLimit"
           case deviceReadonly = "deviceReadonly"
           case token = "token"
           case limitCommands = "limitCommands"
           case poiLayer = "poiLayer"
           case password = "password"
           }
       
           init(from decoder: Decoder) throws {
                   let values = try decoder.container(keyedBy: CodingKeys.self)
                   //administrator = try values.decodeIfPresent(Bool.self, forKey: .administrator)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                   attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
                   name = try values.decodeIfPresent(String.self, forKey: .name)
                   login = try values.decodeIfPresent(String.self, forKey: .login)
                   email = try values.decodeIfPresent(String.self, forKey: .email)
                   phone = try values.decodeIfPresent(String.self, forKey: .phone)
                   readonly = try values.decodeIfPresent(Bool.self, forKey: .readonly)
                   administrator = try values.decodeIfPresent(Bool.self, forKey: .administrator)
                   map = try values.decodeIfPresent(String.self, forKey: .map)
                   latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
                   longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
                   zoom = try values.decodeIfPresent(Int.self, forKey: .zoom)
                   twelveHourFormat = try values.decodeIfPresent(Bool.self, forKey: .twelveHourFormat)
                   coordinateFormat = try values.decodeIfPresent(String.self, forKey: .coordinateFormat)
                   disabled = try values.decodeIfPresent(Bool.self, forKey: .disabled)
                   expirationTime = try values.decodeIfPresent(String.self, forKey: .expirationTime)
                   deviceLimit = try values.decodeIfPresent(Int.self, forKey: .deviceLimit)
                   userLimit = try values.decodeIfPresent(Int.self, forKey: .userLimit)
                   deviceReadonly = try values.decodeIfPresent(Bool.self, forKey: .deviceReadonly)
                   token = try values.decodeIfPresent(String.self, forKey: .token)
                   limitCommands = try values.decodeIfPresent(Bool.self, forKey: .limitCommands)
                   poiLayer = try values.decodeIfPresent(String.self, forKey: .poiLayer)
                   password = try values.decodeIfPresent(String.self, forKey: .password)
           }
}


struct Attributes: Codable {
    
}


