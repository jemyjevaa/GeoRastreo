//
//  EventosServiceProtocol.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
protocol EventosServiceProtocol {
    func serviceGetPeriodo( success: @escaping(_ data: [Periodo]) ->(), failure: @escaping(_ error: Item_erroruser) -> ())
       
    func serviceUnidades(Authorization:String,userId:Int,success: @escaping(_ data: [ItemUnidades]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
       
    func serviceEvents(Authorization: String, deviceId: Int, type: String, from: String, to: String ,success: @escaping(_ data: [ItemEvents]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func servicePosition(Authorization: String, id: Int ,success: @escaping(_ data: PositionElement) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
}
