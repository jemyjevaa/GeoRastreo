//
//  AuthenticationServiceProtocol.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/30/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation

class AuthenticationServiceProtocol {

    func removeThisFuncName(success: @escaping(_ data: AuthenticationModel) -> (), failure: @escaping() -> ()){}

    func loginService(usuario:String, password:String, success: @escaping(_ data: Usuario, _ sesion:String) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){}
    
    func getServers(success: @escaping(_ data: ItemServidores) -> (), failure: @escaping(_ error: ItemErrorServers) -> ()){}
}
