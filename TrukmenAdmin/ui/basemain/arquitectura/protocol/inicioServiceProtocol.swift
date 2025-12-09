//
//  inicioServiceProtocol.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
protocol InicioServiceProtocol {
    func serviceUnidades(Authorization:String,userId:Int,success: @escaping(_ data: [ItemUnidades]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceGrupos(Authorization:String,userId:Int,success: @escaping(_ data: [ItemGrupo]) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func validarSesionGPS
                 (usuario:String, password:String,success: @escaping( _ sesion:String) -> (), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func serviceDevice (idUnidad:Int, success: @escaping(_ data: deviceData) -> (), failure: @escaping(_ error: Item_erroruser)-> ())
    
    func servicePosition (idUnidad:Int, success: @escaping(_ data: PositionElement) -> (), failure: @escaping(_ error: Item_erroruser)-> ())
    
    func serviceGetPeriodo( success: @escaping(_ data: [Periodo]) ->(), failure: @escaping(_ error: Item_erroruser) -> ())
    
    func getServers(success: @escaping(_ data: ItemServidores) -> (), failure: @escaping(_ error: ItemErrorServers) -> ())

}
