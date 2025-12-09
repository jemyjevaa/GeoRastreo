//
//  MenuEmpresaProtocol.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 12/06/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import Foundation
class MenuEmpresaServiceProtocol {
    func removeThisFuncName(success: @escaping(_ data: AuthenticationModel) -> (), failure: @escaping() -> ()){}

    func loginService(usuario:String, password:String, success: @escaping(_ data: Usuario, _ sesion:String) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){}
    
    func getServers(success: @escaping(_ data: ItemServidores) -> (), failure: @escaping(_ error: ItemErrorServers) -> ()){}
}
