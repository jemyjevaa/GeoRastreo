//
//  MenuEmpresaService.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 12/06/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import Foundation
import Alamofire

class MenuEmpresaService: MenuEmpresaServiceProtocol {
    override func loginService(usuario: String, password:String,  success: @escaping (Usuario, String) -> (), failure: @escaping (Item_erroruser) -> ()){
           let parameters: Parameters = [
                      "email": usuario,
                      "password":password
                  ]
           
           let url = Endpoints.Posts.validarusuario.path
           
           APIManagerGeovoy.request(
                    url,
                    method: .post,
                    parameters: parameters,
                    encoding: URLEncoding.default,
                    headers: [:],
                    completion: { data, session in
                        // mapping data
                        do {
                            let decoded = try JSONDecoder().decode(Usuario.self, from: data)
                            success(decoded, session)
                            print("success ")
                        } catch _{
                            do {
                                let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)
                                failure(decoded)
                                print("error do ")
                            } catch _ {
                                failure(Item_erroruser(datos: "error", respuesta: "error"))
                                print("error catch ")
                            }
                        }
                        
                }) { errorMsg, errorCode in
                    failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
                }
       }
       
       override func getServers(success: @escaping (ItemServidores) -> (), failure: @escaping (ItemErrorServers) -> ()) {
       
           let url = Endpoints.Posts.datosServers.path
           
           APIManagerServers.request(
               url,
               method: .get,
               parameters: [:],
               encoding: URLEncoding.default,
               headers: [:],
               completion: { data in
                   // mapping data
                   do {
                       print("servers do")
                       let decoded = try JSONDecoder().decode(ItemServidores.self, from: data)
                       success(decoded)
                   } catch _ {
                       do {
                           print("Dominio do2")
                           let decoded = try JSONDecoder().decode(ItemErrorServers.self, from: data)
                           failure(decoded)
                       } catch _ {
                           failure(ItemErrorServers(datos: "error", respuesta: "error"))
                           print("Dominio cat2")
                       }
                   }
                   
           }) { errorMsg, errorCode in
               failure(ItemErrorServers(datos: "error", respuesta: "\(errorCode)"))
               print("Dominio errormsg")
           }
       }
}
