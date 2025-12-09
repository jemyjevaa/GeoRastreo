//
//  ViajesViewModel.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
class ViajesViewModel{
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
                    self.didGetUnidades?(data)
                    
                }) { (error) in
                    self.alertMessage = "ERROR " + error.respuesta
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
                
             }
         default: break
         }
     }
    
    func TripsService(authorization: String, deviceId: Int, from: String, to: String ){
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
                self.service.serviceTrips(Authorization: authorization, deviceId: deviceId,from: from, to: to, success: { (data) in
                    self.isLoading = false
                  //  self.model = data
                  //  self.count = data.datos.count
                    self.didGetTrips?(data)
                    
                }) { (error) in
                    self.alertMessage = "ERROR " + error.respuesta
                }
            default:
                break
            }
        }
    
    func TripsService2(authorization: String, groupId: Int, from: String, to: String ){
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
                 self.service.serviceTrips2(Authorization: authorization, groupId: groupId, from: from, to: to, success: { (data) in
                     self.isLoading = false
                   //  self.model = data
                   //  self.count = data.datos.count
                     self.didGetTrips?(data)
                     
                 }) { (error) in
                     self.alertMessage = "ERROR " + error.respuesta
                 }
             default:
                 break
             }
         }
    func TripsServiceComplet(authorization: String, groupId: Int,deviceId: Int , from: String, to: String ){
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
                    self.service.serviceTripsComplet(Authorization: authorization, groupId: groupId, deviceId: deviceId, from: from, to: to, success: { (data) in
                        self.isLoading = false
                      //  self.model = data
                      //  self.count = data.datos.count
                        self.didGetTrips?(data)
                        
                    }) { (error) in
                        self.alertMessage = "ERROR " + error.respuesta
                    }
                default:
                    break
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
    
    func getURL(latitude : String,longitude : String, latitudeto : String,longitudeto : String,waypoints:String) -> String {
        let waypints = "waypoints="+waypoints
        let origin = "origin=" + latitude + "," + longitude
        let dest = "destination=" + latitudeto + "," + longitudeto
        let sensor = "sensor=false&key=AIzaSyA6WSHJ8R0AMDhhk0e_-Sn0KLEwSB60QKw"
        let lenguage = "language=es"
        var params = ""
        if (waypints == ""){
            params = "\(origin)&\(dest)&\(sensor)&\(lenguage)"
        }
        else{
            params = "\(origin)&\(dest)&\(waypints)&\(sensor)&\(lenguage)"
        }
      return "https://maps.googleapis.com/maps/api/directions/json?\(params)"
    }
    func generarWaypoints(obj: [ItemRuta])-> String{
        var i = 0
        var waypoints = ""
        var wyp = ""
        
        for puntos in obj {
            if i != 0 && i != (obj.count-1) {
                if obj.count == 3 || i == 1 {
                    wyp = "via:" + String(puntos.latitude!) + "%2C" + String(puntos.longitude!)
                }
                else{
                    wyp = "%7Cvia:" + String(puntos.latitude!) + "%2C" + String(puntos.longitude!)
                }
                waypoints = waypoints + wyp
            }
            i = i + 1
        }
        return waypoints
    }
    func generarWaypointsFin(obj: [ItemRuta])-> String{
        var i = 0
              var waypoints = ""
              var wyp = ""
       var x = 1
       var inicio = ""
       var it = obj.count
       var ot = 0
       
              for puntos in obj {
                  print("puntos ", x ," ot ", ot, " it ", it)
                  if (ot == 25){
                    inicio = String(puntos.latitude!) + "," + String(puntos.longitude!)
                    ot = -1
                    waypoints = waypoints + inicio + "@"
                  }
                if(x == it){
                    inicio = String(puntos.latitude!) + "," + String(puntos.longitude!)
                    waypoints = waypoints + inicio + "@"
                    ot = -1
                }
                i = i + 1
                ot = ot + 1
                x = x + 1
              }
              return waypoints
    }
    func generarWaypointsXL(obj: [ItemRuta])-> String{
       var i = 0
       var x = 0
       var ot = 0
       var inicio = ""
       let it = obj.count
      // print("tamaño ",it)
       //let residuo = (it % 24)-3
           let residuo = (it % 26)
           print("residuo ",residuo ," porcen ",(it % 26))
       var v = it/26
           print("v ",v)
             var waypoints = ""
             var wyp = ""
             
             for puntos in obj {
              // print("OT ",ot)
               //  if i != 0 && i != (obj.datos.count-1) {
                 print("puntos1 ", x ," ot ", ot, " it ", it)
                 
                     if i == 0 {
                         wyp = "via:" + String(puntos.latitude!) + "%2C" + String(puntos.longitude!)
                       inicio = String(puntos.latitude!) + "," + String(puntos.longitude!)
                     }else if(x == 0 && ot != 0 && i != it-2){
                        wyp = "via:" + String(puntos.latitude!) + "%2C" + String(puntos.longitude!)
                     }
                     else{
                         wyp = "%7Cvia:" + String(puntos.latitude!) + "%2C" + String(puntos.longitude!)
                     }
                   if(ot == 25){
                       inicio = String(puntos.latitude!) + "," + String(puntos.longitude!)
                       ot = -1
                       if(ot<0){ot = 0}
                   }
                     waypoints = waypoints + wyp
              // }
              print("X ",x," v ",v," cont ",obj.count, " res ",residuo," ot ",ot, " i ",i)

                   if(x > 23 && obj.count > 26 ){
                       print("primer if ",inicio)
                       waypoints = waypoints + "$" + inicio + "@"
                       x = -1
                       v-=1
                   }else if(x == residuo && v == 0){
                       print("segundo if ",inicio)
                     waypoints = waypoints + "$" + inicio + "@"
                     x = -1
                   }else if(i == obj.count-1){
                       print("tercer if ")
                     waypoints = waypoints + "$" + inicio + "@"
                   }
                 
                 i = i + 1
                 x = x + 1
                 ot = ot + 1
             }
           //print("waypointos ",waypoints)
             return waypoints
       }
}
