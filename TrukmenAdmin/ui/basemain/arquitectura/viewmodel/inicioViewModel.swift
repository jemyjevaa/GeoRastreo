//
//  inicioViewModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
import GoogleMaps
class InicioViewModel {
    private let service: InicioServiceProtocol
    
    private var model: [ItemUnidades] = [ItemUnidades]() {
          didSet {
              self.count = self.model.count
          }
      }
      
      /// Count your data in model
      var count: Int = 0
      
      //MARK: -- Network checking
    /// Define networkStatus for check network connection
       var networkStatus = Reach().connectionStatus()
       
       /// Define boolean for internet status, call when network disconnected
       var isDisconnected: Bool = false {
           didSet {
               self.alertMessage = "No network connection. Please connect to the internet"
               self.internetConnectionStatus?()
           }
       }
       
       //MARK: -- UI Status
    /// Update the loading status, use HUD or Activity Indicator UI
      var isLoading: Bool = false {
          didSet {
              self.updateLoadingStatus?()
          }
      }
      
      /// Showing alert message, use UIAlertController or other Library
      var alertMessage: String? {
          didSet {
              self.showAlertClosure?()
          }
      }
      
      
      var unidadSeleccionada: ItemUnidades? {
          didSet {
              self.selectUnidad?(unidadSeleccionada!)
              print("ruta seleccionada")
          }
      }
    var grupoSeleccionada: ItemGrupo? {
           didSet {
               self.selectGrupo?(grupoSeleccionada!)
               print("ruta seleccionada")
           }
       }
    
    var unidadesSeleccionadas:  [ItemUnidades]? {
             didSet {
                 self.selectUnidades?(unidadesSeleccionadas!)
                 print("ruta seleccionada")
             }
         }
    /// Define selected model
       var selectedObject: ItemUnidades?
       var selectedObjectGrupo: ItemGrupo?
    
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
       var updateLoadingStatus: (() -> ())?
       var internetConnectionStatus: (() -> ())?
       var serverErrorStatus: (() -> ())?
    
       var selectUnidad: ((ItemUnidades) -> ())?
       var selectUnidades: (([ItemUnidades]) -> ())?
       var selectGrupo: ((ItemGrupo) -> ())?
       var gidGetGrupos: (([ItemGrupo]) -> ())?
       var gidGetUnidades: (([ItemUnidades]) -> ())?
       var didGetSesion:((String)->())?
       var didGetDeviceData:((deviceData, String) -> ())?
       var gidGetPosicionActual: ((PositionElement, String, String) -> ())?
       var didGetPeriodo: (([Periodo]) -> ())?
       var didGetError: ((Item_erroruser) -> ())?
        var didGetServers: ((ItemServidores) ->())?
        var didErrorServers: ((ItemErrorServers) -> ())?
    
    init(withPromociones serviceProtocol: InicioServiceProtocol = InicioService() ) {
         self.service = serviceProtocol
         
         NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
         Reach().monitorReachabilityChanges()
     }
    
    
    //MARK: -- Internet Monitor Status
    
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    
    
    func unidadesService(idUsuario: Int, authorization: String){
       //  print("RUTAS SERVICE ")
         switch networkStatus {
         case .offline:
             self.isDisconnected = true
             self.internetConnectionStatus?()
             
            /* self.objRutaBd.selectRutasBd = { rutas in
                 let rutasModel = RutasModel(datos: rutas, respuesta: "ok")
                 self.selectedObjectRutas = rutasModel
             }

             self.objRutaBd.getAllRutasBd() */
             
         case .online:
             // call your service here
             self.service.serviceUnidades(Authorization: authorization, userId: idUsuario, success: { (data) in
                 self.isLoading = false
               //  self.model = data
               //  self.count = data.datos.count
                 self.gidGetUnidades?(data)
                 
             }) { (error) in
                 self.alertMessage = "ERROR " + error.respuesta
                 self.didGetError?(error)
             }
         default:
             break
         }
     }
    
    
    
    func gruposService(idUsuario: Int, authorization: String){
          //  print("RUTAS SERVICE ")

            switch networkStatus {
            case .offline:
                self.isDisconnected = true
                self.internetConnectionStatus?()
                
               /* self.objRutaBd.selectRutasBd = { rutas in
                    let rutasModel = RutasModel(datos: rutas, respuesta: "ok")
                    self.selectedObjectRutas = rutasModel
                }

                self.objRutaBd.getAllRutasBd() */
                
            case .online:
                // call your service here
                self.service.serviceGrupos(Authorization: authorization, userId: idUsuario, success: { (data) in
                    self.isLoading = false
                  //  self.model = data
                  //  self.count = data.datos.count
                    self.gidGetGrupos?(data)
                    
                }) { (error) in
                    self.alertMessage = "ERROR " + error.respuesta
                    self.didGetError?(error)
                }
            default:
                break
            }
        }
    
    func getPeriodos(){
            print("get Viajes")
            switch networkStatus {
            case .offline:
                print("offline")
                self.isDisconnected = true
                self.internetConnectionStatus?()
                
            case .online:
                print("online ")
                self.service.serviceGetPeriodo(
                   success: {(data) in
                    self.isLoading = false
                    
                   // self.objViajesBD.eliminarViajesBD()
                    self.didGetPeriodo?(data)
                    
                    print("periodos  ",  data)
                }){ (error) in self.alertMessage = "Error"
                    self.didGetError?(error)
                }
            default: break
            }
        }
    
    func validarUsuarioSocket(webapi: String){
          switch networkStatus {
                   case .offline:
                       self.isDisconnected = true
                       self.internetConnectionStatus?()
                   case .online:
                       // call your service here
                        
                       self.service.validarSesionGPS(usuario: "usuariosapp", password: "usuarios0904", success: { (sesion) in
                            
                                 self.isLoading = false
                               //  self.modelSocket = data
                                 print("sesionSS ", sesion)
                                self.didGetSesion?(sesion)
                               
                        }) { (error) in
                            self.alertMessage = "ERROR"
                            self.didGetError?(error)
                        }
                    
                       
                   default:
                       break
                   }
      }
    
    func  deviceService(idUnidad:Int, nameUnidad: String){
            switch networkStatus {
                          case .offline:
                              self.isDisconnected = true
                              self.internetConnectionStatus?()
                          case .online:
                              // call your service here
                                  self.service.serviceDevice(idUnidad: idUnidad, success: { (data) in
                                         
                                         self.isLoading = false
                                         //  self.model = data
                                         //  self.count = data.datos.count
                                         print("data Device ",data)
                                         self.didGetDeviceData?(data, nameUnidad)
                                         
                                     }) { (error) in
                                         self.alertMessage = "ERROR"
                                         self.didGetError?(error)
                                     }
                              
                         
                          default:
                              break
                          }
        }
    
    func posicionActualService(idUnidad: Int,  nameUnidad:String, category:String){
            switch networkStatus {
                   case .offline:
                       self.isDisconnected = true
                       self.internetConnectionStatus?()
                   case .online:
                       // call your service here
              
                        self.service.servicePosition(idUnidad: idUnidad, success: { (data) in
                               
                               self.isLoading = false
                               //  self.model = data
                               //  self.count = data.datos.count
                               print(data)
                               self.gidGetPosicionActual?(data, nameUnidad, category)
                               
                           }) { (error) in
                               self.alertMessage = "ERROR"
                               self.didGetError?(error)
                           }
                    
             
                   default:
                       break
                   }
        }
    
    func getServers(){
        print("getServersAVM: ")
        switch networkStatus {
                 case .offline:
                     self.isDisconnected = true
                     self.internetConnectionStatus?()
                 case .online:
                     // call your service here
            self.service.getServers(success: { (sesion) in
                             
                                  self.isLoading = false
                                //  self.modelSocket = data
                                  print("servers ", sesion)
                                 self.didGetServers?(sesion)
                         }) { (error) in
                            // self.alertMessage = [error.datos, error.respuesta]
                             self.didErrorServers?(error)
                         }
                 default:
                     break
                 }
    }
}
