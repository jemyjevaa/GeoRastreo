//
//  MapaViajesViewModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 18/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
class MapaViajesViewModel{
    private let service: ViajesServiceProtocol
    
    //MARK: -- Network checking
    var networkStatus = Reach().connectionStatus()
    
    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }
    //MARK: -- UI Status
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
    
    var periodoSeleccionada: Periodo? {
                didSet {
                    self.selectPeriodo?(periodoSeleccionada!)
                    print("ruta seleccionada")
                }
            }
    var tripSeleccionada: ItemViajes? {
                didSet {
                    self.selectTrip?(tripSeleccionada!)
                    print("ruta seleccionada")
                }
            }
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    
    var didGetGrupos: (([ItemGrupo]) -> ())?
    var didGetPeriodo: (([Periodo]) -> ())?
    var didGetUnidades: (([ItemUnidades]) -> ())?
    var selectUnidad: ((ItemUnidades) -> ())?
    var selectPeriodo: ((Periodo) -> ())?
    var selectGrupo: ((ItemGrupo) -> ())?
    var didGetTrips: (([ItemViajes]) -> ())?
    var selectTrip: ((ItemViajes) -> ())?
    var didGetRout:  (([ItemRuta]) -> ())?
    var fecha1:Date? = nil
    var fecha2:Date? = nil
    
    init(withPromociones serviceProtocol: ViajesServiceProtocol = ViajesService()){
        self.service = serviceProtocol
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func getGrupos(authorization:String, userId: Int){
        print("get Viajes")
        switch networkStatus {
        case .offline:
            print("offline")
            self.isDisconnected = true
            self.internetConnectionStatus?()

          
    
            
        case .online:
            print("online ")
            self.service.serviceGetGrupos(Authorization: authorization, userId: userId, success: {(data) in
                self.isLoading = false
                
               // self.objViajesBD.eliminarViajesBD()
                self.didGetGrupos?(data)
                
                print("grupos  ",  data)
            }){ (error) in self.alertMessage = "Error"
               
            }
        default: break
        }
    }
    
 
    
    func RouteService(authorization: String, deviceId: Int,  from: String, to: String ){
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
                self.service.serviceRoute(Authorization: authorization, deviceId: deviceId,from: from, to: to, success: { (data) in
                    self.isLoading = false
                  //  self.model = data
                  //  self.count = data.datos.count
                    
                    self.didGetRout?(data)
                    
                }) { (error) in
                    self.alertMessage = "ERROR " + error.respuesta
                }
            default:
                break
            }
        }
}
