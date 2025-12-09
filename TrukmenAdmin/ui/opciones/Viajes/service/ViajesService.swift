//
//  ViajesService.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ViajesService: ViajesServiceProtocol{
    
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
    
    func serviceGetGrupos( Authorization:String,userId:Int,success: @escaping(_ data: [ItemGrupo]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
            let parameters: Parameters = [
                           "userId": userId
                          ]
                
                let url = Endpoints.Posts.getGroups.path
                
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
                                 let decoded : [ItemGrupo] = try JSONDecoder().decode([ItemGrupo].self, from: data)
                                 success(decoded)
                             } catch _ {
                                 print("catch1 ")
                                 do {
                                     let error = Item_erroruser(datos: "error ", respuesta: "Error Decoded ")
                                    /* let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)*/
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
    
    func serviceUnidades(Authorization:String, userId:Int, success: @escaping(_ data: [ItemUnidades]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
         let parameters: Parameters = [
                        "userId": userId
                       ]
             
             let url = Endpoints.Posts.getDevices.path
             
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
    
    func serviceTrips(Authorization:String, deviceId:Int,from:String, to :String, success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
                         "deviceId": deviceId,
                         "from": from,
                         "to": to
                        ]
       
        let url = Endpoints.Posts.searchTrips.path
              
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
                               
                               let decoded: [ItemViajes] = try JSONDecoder().decode([ItemViajes].self, from: data)
                               
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
    
    func serviceTrips2(Authorization:String, groupId:Int,from:String, to :String, success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
                         "groupId": groupId,
                         "from": from,
                         "to": to
                        ]
       
        let url = Endpoints.Posts.searchTrips.path
              
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
                               
                               let decoded: [ItemViajes] = try JSONDecoder().decode([ItemViajes].self, from: data)
                               
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
    func serviceTripsComplet(Authorization:String, groupId:Int, deviceId: Int,from:String, to :String, success: @escaping(_ data: [ItemViajes]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
                         "groupId": groupId,
                         "deviceId": deviceId,
                         "from": from,
                         "to": to
                        ]
       
        let url = Endpoints.Posts.searchTrips.path
              
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
                               
                               let decoded: [ItemViajes] = try JSONDecoder().decode([ItemViajes].self, from: data)
                               
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
    func serviceRoute(Authorization:String, deviceId:Int,from:String, to :String, success: @escaping(_ data: [ItemRuta]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
          let parameters: Parameters = [
                         "deviceId": deviceId,
                         "from": from,
                         "to": to
                        ]
       
        let url = Endpoints.Posts.route.path
              
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
                               
                               let decoded: [ItemRuta] = try JSONDecoder().decode([ItemRuta].self, from: data)
                               
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
}
