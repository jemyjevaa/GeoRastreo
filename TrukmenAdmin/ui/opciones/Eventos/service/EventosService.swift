//
//  EventosService.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventosService: EventosServiceProtocol {
    
    func serviceGetPeriodo(success: @escaping(_ data: [Periodo]) -> (), failure: @escaping(_ error: Item_erroruser) ->()){
        
        let parameters: Parameters = [:]
        
        let url = Endpoints.Posts.getPeriodos.path
        
        APIManager.request4(url,
                           method: .get,
                           parameters: parameters,
                           encoding: URLEncoding.default,
                            headers: [:],
                           completion: {data in
            do{
                let decoded = try JSONDecoder().decode([Periodo].self, from: data)
                success(decoded)
            } catch _{
                do{
                    let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)
                    failure(decoded)
                }catch _ {
                    failure(Item_erroruser(datos: "error", respuesta: "error"))
                }
            }
        }) { errorMsg, errorCode in
            failure(Item_erroruser(datos: errorMsg, respuesta: "\(errorCode)"))
            
        }
    }
    
  
    
    func serviceUnidades(Authorization:String, userId:Int, success: @escaping(_ data: [ItemUnidades]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
         let parameters: Parameters = [
                        "userId": userId
                       ]
             
             let url = Endpoints.Posts.getDevices.path
             
             print("🔴 ENVIANDO PARAMETROS A UNIDADES: \(parameters)")
             APIManagerGeovoy.request(
                      url,
                      method: .get,
                      parameters: [:],
                      encoding: URLEncoding.queryString,
                      headers: ["Authorization":Authorization],
                      completion: { data, sesion  in
                          // mapping data
                         print("mapping data ",sesion)
                          do {
                             print("do ")
                              
                              let decoded: [ItemUnidades] = try JSONDecoder().decode([ItemUnidades].self, from: data)
                              
                              success(decoded)
                          } catch _ {
                              print("catch1 ")
                              do {
                                  let error = Item_erroruser(datos: "error ", respuesta: "Error Decoded ")
                                  /*let decoded = try JSONDecoder().decode(Item_erroruser.self, from: error)*/
                                  failure(error)
                              } catch _ {
                                  print("catch2 ")
                                  failure(Item_erroruser(datos: "error", respuesta: "error"))
                              }
                          }
                  }) { errorMsg, errorCode in
                      failure(Item_erroruser(datos: errorMsg, respuesta: "\(errorCode)"))
                  }
         }
    
    
    func serviceEvents(Authorization: String, deviceId: Int, type: String, from: String, to: String, success: @escaping(_ data: [ItemEvents]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
            "deviceId" : deviceId,
            "type" : type,
            "from" : from,
            "to" : to
                        ]
       
        let url = Endpoints.Posts.events.path
              
              APIManagerGeovoy.request(
                       url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.queryString,
                       headers: ["Authorization":Authorization, "Accept":"application/json"],
                       completion: { data, sesion  in
                           // mapping data
                          print("mapping data ",sesion)
                           do {
                              print("do ")
                               
                               let decoded: [ItemEvents] = try JSONDecoder().decode([ItemEvents].self, from: data)
                               
                               success(decoded)
                           } catch _ {
                               print("catch1 ")
                               do {
                                   let error = Item_erroruser(datos: "error ", respuesta: "Error Decoded ")
                                   /*let decoded = try JSONDecoder().decode(Item_erroruser.self, from: error)*/
                                   failure(error)
                               } catch _ {
                                   print("catch2 ")
                                   failure(Item_erroruser(datos: "error", respuesta: "error"))
                               }
                           }
                           
                   }) { errorMsg, errorCode in
                       failure(Item_erroruser(datos: errorMsg, respuesta: "\(errorCode)"))
                   }
          }
    
    func servicePosition(Authorization: String, id: Int, success: @escaping(_ data: PositionElement) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
            "id" : id
                        ]
       
        let url = Endpoints.Posts.posicions.path
              
              APIManagerGeovoy.request(
                       url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.queryString,
                       headers: ["Authorization":Authorization],
                       completion: { data, sesion  in
                           // mapping data
                          print("mapping data ",sesion)
                           do {
                              print("do ")
                               
                            let jsonArray = JSON(data)
                            let responseModel = try PositionElement.self.init(fromJson: jsonArray[0])
                            success(responseModel)
                           } catch _ {
                               print("catch1 ")
                               do {
                                   let error = Item_erroruser(datos: "error ", respuesta: "Error Decoded ")
                                   /*let decoded = try JSONDecoder().decode(Item_erroruser.self, from: error)*/
                                   failure(error)
                               } catch _ {
                                   print("catch2 ")
                                   failure(Item_erroruser(datos: "error", respuesta: "error"))
                               }
                           }
                           
                   }) { errorMsg, errorCode in
                       failure(Item_erroruser(datos: errorMsg, respuesta: "\(errorCode)"))
                   }
          }
}
