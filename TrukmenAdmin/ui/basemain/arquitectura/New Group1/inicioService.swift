//
//  inicioService.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class InicioService: InicioServiceProtocol {
    
    func serviceGetPeriodo(success: @escaping(_ data: [Periodo]) -> (), failure: @escaping(_ error: Item_erroruser) ->()){
           
           let parameters: Parameters = [:]
           
           let url = Endpoints.Posts.getPeriodos.path
           
           APIManager.request4(url,
                              method: .post,
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
               failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
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
                   failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
               }
      }
    
    func serviceGrupos( Authorization:String,userId:Int,success: @escaping(_ data: [ItemGrupo]) -> (), failure: @escaping(_ error: Item_erroruser) -> ()){
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
                       failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
                   }
          }
    
    func validarSesionGPS(usuario: String, password:String,  success: @escaping ( String) -> (), failure: @escaping (Item_erroruser) -> ()){
    let parameters: Parameters = [
                   "email": usuario,
                   "password":password
               ]
        
    let url = Endpoints.Posts.sesionGps.path
        
        APIManagerGeovoy.request(
                 url,
                 method: .post,
                 parameters: parameters,
                 encoding: URLEncoding.default,
                 headers: [:],
                 completion: { data, sesion  in
                     // mapping data
                    print("mapping data Sesion",data )
                     do {
                        print("do ")
                       /*  let decoded = try JSONDecoder().decode(uSocket.self, from: data)*/
                         success(sesion)
                     } catch _ {
                         print("catch1 ")
                         do {
                             let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)
                             failure(decoded)
                         } catch _ {
                             print("catch2 ")
                             failure(Item_erroruser(datos: "error", respuesta: "error"))
                         }
                     }
                     
             }) { errorMsg, errorCode in
                 failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
             }
    }
    
    func serviceDevice(idUnidad: Int, success: @escaping (deviceData) -> (), failure: @escaping (Item_erroruser) -> ()) {
        let parameters: Parameters = [
                   "id": idUnidad
               ]
        let username = "usuariosapp"
        let password = "usuarios0904"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
 
               let url = Endpoints.Posts.devices.path
               
        APIManagerGeovoy.request(
                   url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: ["Authorization":base64LoginString, "Accept":"application/json"],
                   completion: { data, sesion in
                       // mapping data
                    print("data device ",data)
                       do {
                        
                         /*  let decoded = try JSONDecoder().decode(PositionElement.self, from: data)*/
                    
                        let jsonArray = JSON(data)
                        let responseModel = try deviceData.self.init(fromJson: jsonArray[0])
                     
                       
                      //  print("json device res ", jsonArray[0])
                            //jsonDecoder.decode(deviceData.self, from: data)
                        //decode(fdeviceData.self, from: data)
                           success(responseModel)
                       } catch let error {
                        print("catch device ", error)
                           do {
                               let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)
                               failure(decoded)
                           } catch let error {
                            print("catch2 device \(error)")
                               failure(Item_erroruser(datos: "error", respuesta: "error"))
                           }
                       }
                       
               }) { errorMsg, errorCode in
                   failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
                   print("errorMsg device ")
               }
    }
    
    func servicePosition(idUnidad: Int, success: @escaping (PositionElement) -> (), failure: @escaping (Item_erroruser) -> ()) {
          let parameters: Parameters = [
                     "id": idUnidad
                 ]
          let username = "usuariosapp"
          let password = "usuarios0904"
          let loginString = String(format: "%@:%@", username, password)
          let loginData = loginString.data(using: String.Encoding.utf8)!
          let base64LoginString = loginData.base64EncodedString()
          
       /*   let authorization  = "Basic " + android.util.Base64.encodeToString(
                         String.format(
                             "%s:%s",
                            "usuariosapp",
                            "usuarios0904"
                         ).toByteArray(), Base64.NO_WRAP
                     )*/
                 let url = Endpoints.Posts.posicions.path
                 
        APIManagerGeovoy.request(
                     url,
                     method: .get,
                     parameters: parameters,
                     encoding: URLEncoding.default,
              headers: ["Authorization":base64LoginString, "Accept":"application/json"],
                     completion: { data, sesion in
                         // mapping data
                      print("data sesion ",data)
                         do {
                          
                           /*  let decoded = try JSONDecoder().decode(PositionElement.self, from: data)*/
                          let jsonArray = JSON(data)

                          //let responseModel = try jsonDecoder.decode(PositionElement.self, from: data)
                          let responseModel = try PositionElement.self.init(fromJson: jsonArray[0])

                             success(responseModel)
                         } catch let error {
                          print("catch ", error)
                             do {
                                 let decoded = try JSONDecoder().decode(Item_erroruser.self, from: data)
                                 failure(decoded)
                             } catch let error {
                              print("catch2 \(error)")
                                 failure(Item_erroruser(datos: "error", respuesta: "error"))
                             }
                         }
                         
                 }) { errorMsg, errorCode in
                     failure(Item_erroruser(datos: "servidor", respuesta: "\(errorCode)"))
                    print("errorMsg ")
                 }
      }
    
    
     func getServers(success: @escaping (ItemServidores) -> (), failure: @escaping (ItemErrorServers) -> ()) {
    
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
