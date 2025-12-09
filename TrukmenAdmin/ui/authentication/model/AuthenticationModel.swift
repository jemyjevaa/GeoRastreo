//
//  AuthenticationModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/30/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation

struct AuthenticationModel: Codable {
    let respuesta: String
    let datos: [Dato]
}
// MARK: - Dato
struct Dato: Codable {
    let id, clave: String
}
