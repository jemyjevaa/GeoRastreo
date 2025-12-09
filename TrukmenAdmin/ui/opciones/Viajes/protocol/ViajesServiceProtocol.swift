//
//  ViajesServiceProtocol.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
protocol ViajesServiceProtocol {
    func serviceGetPeriodo( success: @escaping(_ data: [Periodo]) ->(), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceGetGrupos(Authorization:String,userId:Int,success: @escaping(_ data: [ItemGrupo]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceUnidades(Authorization:String,userId:Int,success: @escaping(_ data: [ItemUnidades]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceTrips(Authorization:String,deviceId:Int, from:String, to:String ,success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceTrips2(Authorization:String,groupId:Int, from:String, to:String ,success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceTripsComplet(Authorization:String,groupId:Int,deviceId:Int, from:String, to:String ,success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceRoute(Authorization:String,deviceId:Int, from:String, to:String ,success: @escaping(_ data: [ItemRuta]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    }
