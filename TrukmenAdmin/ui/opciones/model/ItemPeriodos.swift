//
//  ItemPeriodos.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
struct PeriodosModel: Codable {
    let data: [Periodo]
}

struct Periodo: Codable{
    let id: Int
    let periodo: String
}
