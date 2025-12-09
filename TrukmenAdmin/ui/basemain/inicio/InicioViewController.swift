//
//  InicioViewController.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import UIKit
import SideMenu
import GoogleMaps
import PanModal
import Spring
import Alamofire
import Starscream
import SideMenu
import SwiftyJSON
import Darwin
import SwiftUI

class InicioViewController: UIViewController, UIGestureRecognizerDelegate {
    static var vc = InicioViewController()
    var delegate: BasemainDelegate?
    var sesion:String = ""
    var websocket: WebSocket?

    @IBOutlet weak var MMap: GMSMapView!
    @IBOutlet weak var btnMenu: GRButton!
    @IBOutlet weak var btnCapas: GRButton!
    @IBOutlet weak var btnMenuCapas: GRButton!
    @IBOutlet weak var btnTrafico: GRButton!
    
    @IBOutlet weak var txtEmpresa: UILabel!
    @IBOutlet weak var btnUnidades: GRButton!
    @IBOutlet weak var tituloUnidades: UILabel!
    @IBOutlet weak var textoUnidades: UILabel!
    
    @IBOutlet weak var imgConfig: UIImageView!
    @IBOutlet weak var btnInfo: GRButton!
    @IBOutlet weak var GloboTexto: GRButton!
    @IBOutlet weak var tituloGlobo: UILabel!
    @IBOutlet weak var contenidoGlobo: UILabel!
    var markersArray = [GMSMarker]()
        var markers2Array = [GMSMarker]()
        var markers1Array = [GMSMarker]()
        var markers3Array = [GMSMarker]()
    var unidadAsignada: UnidadesModel!
    
    var base64LoginString = ""
    var idUsuario = 0
    var viewModel = InicioViewModel()
            var unidadesData = [ItemUnidades]()
            var grupoData = [ItemGrupo]()
            var periodoData = [Periodo]()
    var typeMap: String = ""
    var isOpenInfo = true
    var indexOld = 0
        var contador = 0
        var contador2 = 0
        var rutaActiva:Bool = false
    
    var myLocationMarker: GMSMarker!
        var myLocationMarker2: GMSMarker!
        var myLocationMarker3: GMSMarker!
    var banderaUnidad = false
      var banderaRuta = false
    var unidadesSeleccionadas = [ItemUnidades]()
    var unidadesAux = [DataUni]()
    var tipoCarga = 0
    var servers : ItemServidores?
    
    var se1 =   ""
    var se2 =   ""
    var se3 =   ""
    var servName = ""
    var config:Bool = false

    var user_name: String?
    var password: String?
    
    let alertaL: AlertaLoading = AlertaLoading()
    var rowVCG: PanModalPresentable.LayoutType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        InicioViewController.vc = self
        se1 = se1 +  (ServersManager.currentServers?.datos.url1)!
        se2 = se2 +  (ServersManager.currentServers?.datos.url2)!
        se3 = se3 +  (ServersManager.currentServers?.datos.socket)!
        user_name = ServersManager.currentServers?.datos.user
        password = ServersManager.currentServers?.datos.pass
        servName = servName + (ServersManager.currentServers?.datos.nameServ)!
       
        setupSideMenu()
        setupViewModel()
        setupMap()
        cargaDataInicio()
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        print("Boton MEnu")
         /*present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)*/
      setupSideMenu()
         present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func btnUnidades(_ sender: Any) {
        
        print("Boton Unidades")
        print("Boton Rutas")
               let vc: AlertaUnidades
        = AlertaUnidades()
                      vc.viewModel = self.viewModel
                      let rowVC: PanModalPresentable.LayoutType = vc
        vc.grupoData = self.grupoData
        vc.grupoFilter = self.grupoData
        vc.unidadesData = self.unidadesData
        vc.unidadesFilter = self.unidadesData
                    //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
                      dismiss(animated: true, completion: nil)
                      presentPanModal(rowVC)
    }
    
    @IBAction func btnCapasNew(_ sender: Any) {
        print("boton capas ")
        typeMap = UserManager.currentUser!.datosMapa.mapaM
        print("mapa llega ",typeMap)
                var temp = Int(typeMap) ?? 1
                temp =  temp+1
                typeMap = String(temp)
                print("temp ",temp," typemap ",typeMap)
                if(typeMap == "4"){typeMap = "1"}
                switch(typeMap){
                case "1":
                    self.MMap.mapType = .normal
                    break
                case "2":
                    self.MMap.mapType = .hybrid
                    break
                case "3":
                    self.MMap.mapType = .satellite                default:
                    self.MMap.mapType = .normal
                    break
                }
        UserManager.currentUser!.datosMapa.mapaM = typeMap
    }
    
    
    @IBAction func btnCapas(_ sender: Any) {
        print("boton capas ")
        typeMap = UserManager.currentUser!.datosMapa.mapaM
        print("mapa llega ",typeMap)
                var temp = Int(typeMap) ?? 1
                temp =  temp+1
                typeMap = String(temp)
                print("temp ",temp," typemap ",typeMap)
                if(typeMap == "4"){typeMap = "1"}
                switch(typeMap){
                case "1":
                    self.MMap.mapType = .normal
                    break
                case "2":
                    self.MMap.mapType = .hybrid
                    break
                case "3":
                    self.MMap.mapType = .satellite                default:
                    self.MMap.mapType = .normal
                    break
                }
                UserManager.currentUser!.datosMapa.mapaM = typeMap
    }
    
    @IBAction func btnMenuCapas(_ sender: Any) {
        print("boton menucapas")
        if(config == false){
            btnCapas.isHidden = false
            btnCapas.layer.animation(forKey: "fadeInUp")
          /*  [UIView .transition(with: btnCapas2, duration: 0.2, options: fadeInUp, animations: nil, completion: nil)]*/
            btnTrafico.isHidden = false
            btnTrafico.layer.animation(forKey: "fadeInUp")
            self.imgConfig.image =  #imageLiteral(resourceName: "cerrar-2")
            config = true
        }else{
            btnCapas.isHidden = true
            btnTrafico.isHidden = true
            self.imgConfig.image =  #imageLiteral(resourceName: "menumapa2")
            config = false
        }
    }
    
    @IBAction func btnTrafico(_ sender: Any) {
        print("boton trafico")
        if (self.MMap.isTrafficEnabled){
            self.MMap.isTrafficEnabled = false
            } else {
            self.MMap.isTrafficEnabled = true
            }
    }
    
    
    @IBAction func btnInfo(_ sender: Any) {
        if(isOpenInfo){
                   GloboTexto.isHidden = true
                   isOpenInfo = false
               }else{
                   GloboTexto.isHidden = false
                   isOpenInfo = true
               }
    }
    
    fileprivate func setupViewModel(){
              self.viewModel.showAlertClosure = {
                  let alert = self.viewModel.alertMessage ?? ""
                  print(alert)
              }
              
              self.viewModel.updateLoadingStatus = {
                  if self.viewModel.isLoading {
                      print("LOADING...")
                  } else {
                      print("DATA READY")
                  }
              }
              
              self.viewModel.internetConnectionStatus = {
                  print("Internet disconnected")
                  // show UI Internet is disconnected
              }
              
              self.viewModel.serverErrorStatus = {
                  print("Server Error / Unknown Error")
                  // show UI Server is Error
              }
        self.viewModel.didGetError = {error in
            if(error.datos == "servidor"){
               // aqui llama a getServer
                self.viewModel.getServers()
            }
        }
        self.viewModel.didGetPeriodo = { data in
            print("periodos ", data)
            self.periodoData = data
        }
        
        self.viewModel.gidGetUnidades = { data in
            print("Unidades VIew ", data)
            self.unidadesData = data
        }
        
        self.viewModel.gidGetGrupos = { data in
            print("Grupos View ", data)
            self.grupoData = data
        }
        
        self.viewModel.didGetSesion = { ses in
            print("sesionDidget ",ses)
                        self.sesion = ses
            SesionManager.currentSesion!.datos.sesionID = ses
                        self.socket()
        }
        self.viewModel.didGetServers = { servers in
            print("didgetServers ", self.servName)
            self.servers = servers
            var reiniciar = false
            var name1 = "lectoras" + self.servName
            var name2 = "gps" + self.servName
            var nam3 = "gpswss" + self.servName
                for s in self.servers!.datos {
                   
                          if (s.clave == name2){
                              print("Clave1 ", s.url , "  clave2  ", self.se1)
                              if(s.url != self.se1){
                                  print("Clave ", s.clave , "  nombre  ", name2)
                                  var bienvenida = s.url
                                  bienvenida.remove(at: bienvenida.index(before: bienvenida.endIndex))
                                  ServersManager.currentServers?.datos.url1 = s.url
                                  ServersManager.currentServers?.datos.url2 = bienvenida + ":4000/"
                                  ServersManager.currentServers?.datos.url3 = bienvenida + ":4000/"
                                  self.se1 = s.url
                                  self.se2 = bienvenida + ":4000/"
                                  reiniciar = true
                              }
                          }
                    
                          if(s.clave == nam3){
                              if (s.url != self.se3) {
                                  print("Clave3 ", s.clave , "  nombre3  ", nam3)
                                  ServersManager.currentServers?.datos.socket = s.url
                                  reiniciar = true
                        }
                    }
                }
           /* let alerta = UIAlertController(title: "Error conexión servidor", message: "Por favor intentalo nuevamente", preferredStyle: .alert)
            let guiaOk = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_aceptar"), style: .default, handler: {(action) in
            }) */
            print("reiniciar ", reiniciar)
            if(reiniciar == true){
              //  self.showResponseAlert(title: "Error de conexión con servidor", message: "Por favor intenta nuevamente")
               
                let alerta = UIAlertController(title: "Error de conexión con servidor", message: "Se actualizarán los datos, Por favor intenta nuevamente", preferredStyle: .alert)
                let guiaOk = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_aceptar"), style: .default, handler: {(action) in
                    InicioViewController.vc.eliminarData()
                })
             
                alerta.addAction(guiaOk)
                InicioViewController.vc.present(alerta, animated:true, completion:nil)
                
           /*     Messaging.messaging().unsubscribe(fromTopic: "empresa/\(UserManager.currentUser?.datosEmpresa.clave)"){ error in
                    print("Subscribed to weather topic")
                }*/
                //OneSignal.sendTag("empresaNombre", value: "")
              //  OneSignal.sendTag("empresaidusuario", value: "")
            }
        }
        self.viewModel.selectUnidades = { unidades in
            print("unidades Select ", unidades)
            self.limpiarMapa()
            self.tipoCarga = 1
            self.unidadesSeleccionadas.removeAll()
            self.unidadesAux.removeAll()
            self.contador = 0
            self.unidadesSeleccionadas = unidades
            self.contenidoGlobo.text =  DataManager.currentData?.dataApp.GrupoSel
            
            self.unidadesSeleccionadas.forEach{ unidad in
                print("unidad select ",unidad)
                self.viewModel.deviceService(idUnidad: unidad.id!, nameUnidad: unidad.name!)
                
               // self.viewModel.posicionActualService(idUnidad: unidad.positionId!, nameUnidad: unidad.name! )
            }
        }
        
        self.viewModel.didGetDeviceData = { device, unidad in
            
            self.viewModel.posicionActualService(idUnidad: device.positionId!, nameUnidad: unidad, category: device.category!)
              }
        
        self.viewModel.gidGetPosicionActual = { posicion, name, Category in
                   print("posicionDidget",name)
                   self.contador+=1
                   let lat = Double(posicion.latitude)
                   let lon = Double(posicion.longitude)
                   var icono  = #imageLiteral(resourceName: "autobus_estacionario")
                   var icono2 = #imageLiteral(resourceName: "icono_base")
                   let iconoT = #imageLiteral(resourceName: "icono_base_texto")
            let degrees = posicion.course!
            switch(Category){
            case "pickup":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "pickup_estacionario-1")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "pickup_estacionario-1")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "pickup_base-1")
                                            
                }
            break
            case "van":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "van_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "van_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "van_base")
                                            
                }
        break
            case "default":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                            
                }
            break
            case "bus":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "autobus_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "autobus_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "autobus_base")
                }
                
                break
            case "offroad":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "todo_terreno_estacionaria")
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "todo_terreno_estacionaria")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "todo_terreno_base")
                                            
                }
        break
            case "truck":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "camion_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "camion_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "camion_base")
                                            
                }
        break
            case "car":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "automovil_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "automovil_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "automovil_base")
                                            
                }
            break
                
            case "motorcycle":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "motocicleta_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "motocicleta_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "motocicleta_base")
                                            
                }
            break
                
            case "":
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                            
                }
    break
            
            case nil:
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                            
                }
    break
                                     
            default:
                if (posicion.speed <= 0 && (posicion.attributes.ignition == false || posicion.attributes.ignition == nil)) {
                    icono  = #imageLiteral(resourceName: "icono_base_texto")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                    
                }
                if (posicion.speed <= 0 && posicion.attributes.ignition == true) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                }
                if (posicion.speed > 0) {
                    icono  = #imageLiteral(resourceName: "icono_base")
                    icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                            
                }
            }
               //    print("ignition ",posicion.attributes.ignition)
              /*     if(posicion.attributes.ignition! == false){
                       icono  = #imageLiteral(resourceName: "icono_base")
                       icono2 = #imageLiteral(resourceName: "autobus_estacionario")
                   }else{
                       icono  = #imageLiteral(resourceName: "icono_base")
                       icono2 = #imageLiteral(resourceName: "autobus_base")
                   }*/
            
                   
            
                   if(self.banderaRuta == false){
                       print("vuelta -> ",name)
                       self.moveBus(lat: lat, lon: lon, icono: icono2, icono2: icono, icono3: iconoT, unidad:name, deegres:degrees, ignition: false, tipoMov: 1, velocidad: (posicion.speed)!, fechaR: (posicion.deviceTime)!)
                   }else{}
               }
    }
    
    func socket(){
           print("socket init ")
          
        var request = URLRequest(url: URL(string: self.se3)!)
        var urlSo = self.se3
               //FuncionesGlobales.instance.serverURls.socket!!
      //  var origin = ""
        var cadena =   String(self.se1)
               
        let or1 = cadena.components(separatedBy: "//")
        
        let origin = or1[0] + "//www." + or1[1]
        print("ORIGIN ", origin)
        print("url origin  ", urlSo)
                

    
        request.httpMethod = "GET";
                   request.addValue(sesion, forHTTPHeaderField: "Cookie")
        request.addValue(String(origin), forHTTPHeaderField: "Origin")
        websocket = WebSocket.init(request: request)
       // websocket?.delegate = self
        
               print("socketss  ", sesion)

        self.websocket!.onEvent = { event in
                   switch event {
                case .text(let string):
                //  print("recibe socket ", string)
                  //     print("recibe socket ")

                   let sp = Data(string.utf8)
              
                     //  print("socketsD  ", self.unidadesSeleccionadas.isEmpty, " ", self.unidadesAux.isEmpty)

                       if( self.unidadesSeleccionadas.isEmpty == false && self.tipoCarga == 1 ){
                          // print("socketsEntre  ")
                                        self.unidadesSeleccionadas.forEach{ unidad in
                                            self.ProcesamientoSocket(data: sp, idUnidad: String(unidad.id!), nombreUnidad: unidad.name!, categoria: unidad.category!)
                                           // print("item datos ",unidad.clave)
                                            }
                                        }
                       if(self.tipoCarga == 2 && self.unidadesAux.isEmpty == false){
                         //  print("socketsEntre  2")

                           self.unidadesAux.forEach{ unidad in
                               self.ProcesamientoSocket(data: sp, idUnidad: String(unidad.IdUnidad), nombreUnidad: unidad.nameUnidad, categoria: unidad.categoriaUnidad)
                                                                      // print("item datos ",unidad.clave)
                                                                       }
                       }
                       break
                          case .binary(let data):
                           self.websocket!.write(data: data)
                          case .ping(_):
                              break
                          case .pong(_):
                              break
                          case .connected(_):
                           print("Socket conectado ")
                              break
                          case .disconnected(let reason, let code):
                           print("socket desconectado ")
                              print("reason: \(reason) code: \(code)")
                          case .error(let error):
                           print("error socket ",error)
                              break
                          case .viabilityChanged(_):
                              break
                          case .reconnectSuggested(_):
                           print("reconect socket ")
                              break
                          case .cancelled:
                           print("cancelado socket ")
                              break
                   }
               }
               websocket!.connect()
           
           
       }
    
    var icono: UIImage?=nil
       var icono2: UIImage?=nil
       var iconoT = #imageLiteral(resourceName: "icono_base_texto")
    func ProcesamientoSocket(data: Data, idUnidad:String, nombreUnidad:String, categoria:String){
        //  print("procesa socket")
           do{
               let dtunidad = Int(idUnidad)
               let jsonArray = JSON(data)
             //  print("json Array procesamiento ",jsonArray)
               let str = String(decoding: data, as: UTF8.self)
               let spl = str.split(separator: "\"")
             //  print("inicio de string ", spl[1])
               if(spl.count > 1){
                  // print("Mayor de 1 ")
                   if(spl[1] == "positions"){
                     //  print("positions ")
                       let dataPositions =  try PositionModelo.init(fromJson: jsonArray)
                       
                       if(dataPositions.positions != nil){
                          // print("positions diferente null ", dataPositions.positions?[0].deviceId, "    ", dtunidad)
                           //    print(" informacion  ", dataPositions.positions?[0].attributes.ignition)
                           if(dataPositions.positions?[0].deviceId == dtunidad){
                               print("son iguales ",nombreUnidad, " id ",dtunidad, "otro id ",dataPositions.positions?[0].deviceId)
                               let spd = Double(dataPositions.positions?[0].speed ?? 0)
                               switch(categoria){
                               case "pickup":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "pickup_estacionario-1")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "pickup_estacionario-1")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "pickup_base-1")
                                       
                                   }
                                   break
                               case "van":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "van_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "van_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "van_base")
                                       
                                   }
                                   break
                               case "default":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                       
                                   }
                                   break
                               case "bus":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "autobus_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "autobus_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "autobus_base")
                                       
                                   }
                                   break
                               case "offroad":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "todo_terreno_estacionaria")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "todo_terreno_estacionaria")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "todo_terreno_base")
                                       
                                   }
                                   break
                               case "truck":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "camion_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "camion_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "camion_base")
                                       
                                   }
                                   break
                               case "car":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "automovil_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "automovil_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "automovil_base")
                                       
                                   }
                                   break
                                   
                               case "motorcycle":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "motocicleta_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "motocicleta_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "motocicleta_base")
                                       
                                   }
                                   break
                                   
                               case "":
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                       
                                   }
                                   break
                                   
                               case nil:
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                       
                                   }
                                   break
                                   
                               default:
                                   if ((dataPositions.positions?[0].speed)! <= 0 && (dataPositions.positions?[0].attributes.ignition == false || dataPositions.positions?[0].attributes.ignition == nil)) {
                                       icono  = #imageLiteral(resourceName: "icono_base_texto")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                       
                                   }
                                   if ((dataPositions.positions?[0].speed)! <= 0 && dataPositions.positions?[0].attributes.ignition == true) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_estacionario")
                                   }
                                   if ((dataPositions.positions?[0].speed)! > 0) {
                                       icono  = #imageLiteral(resourceName: "icono_base")
                                       icono2 = #imageLiteral(resourceName: "predeterminado_base")
                                       
                                   }
                               }
                               
                               // FIN SWITCH IMAGENES
                               /*  icono  = #imageLiteral(resourceName: "icono_base")
                                icono2 = #imageLiteral(resourceName: "autobus_base")*/
                               // print("images ",icono)
                               var n = false
                               let lat = Double(dataPositions.positions?[0].latitude ?? 0)
                               let lon = Double(dataPositions.positions?[0].longitude ?? 0)
                               if(markers1Array.count > 0 ){
                                   moveBus(lat: lat, lon: lon, icono: icono2!, icono2: icono!, icono3: iconoT, unidad:nombreUnidad, deegres:(dataPositions.positions?[0].course)!, ignition: (dataPositions.positions?[0].attributes.ignition)!, tipoMov: 2, velocidad: (dataPositions.positions?[0].speed)!, fechaR: (dataPositions.positions?[0].deviceTime)!)
                               }
                               /*else{
                                print("vacio ")
                                for x in markers1Array{
                                if(x.snippet == nombreUnidad ){n = true; break}
                                }
                                if(n == false){
                                crearBus(lat: lat, lon: lon, icono: icono2!, icono2: icono!, icono3: iconoT, unidad:nombreUnidad, deegres:(dataPositions.positions?[0].course)!, ignition: (dataPositions.positions?[0].attributes.ignition)!)
                                }
                                }*/
                               
                           } // FIN COMPARACION DE UNIDADES
                       }// FIN COMPROBACION POSICIONES NO NULL
                   }//FIN COMPROBACION POSITIONS
               }//Fin comprobacion tamaño array
           } catch _ {
               print("Error Procesamiento")
           }
       }
    
    fileprivate func setupSideMenu(){
         let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
         
         
         SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
         
         SideMenuManager.default.menuAnimationBackgroundColor = SideMenuManager.default.menuShadowColor
         
         SideMenuManager.default.menuFadeStatusBar = false
         
         SideMenuManager.default.menuPresentMode = .menuSlideIn
         
         SideMenuManager.default.menuShadowOpacity = 0.6
         SideMenuManager.default.menuAnimationFadeStrength = 0.6
        // SideMenuManager.default.menuWidth = FuncionesGlobales.scaleIphoneXWindth(tamO: 280, widthView: UIScreen.main.bounds.width)
     }
    
    func setupMap() {
        //let latlon =    LatLng(20.676667, -103.3475);
          let lat = 20.676667
          let lon =  -103.3475
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 6.0)
        //  let camera = GMSCameraPosition.camera(withLatitude: 20.659815, longitude: -103.353438, zoom: 6.0)
          self.MMap.camera = camera
          do{
              if let styleURL = Bundle.main.url(forResource: "mapstylewhite" , withExtension: "json"){
                MMap.mapStyle = try GMSMapStyle (contentsOfFileURL: styleURL)
              }else{
                  print("Unable to find style.json")
              }
          } catch{ print("The style definition no could loaded: \(error)")}
          self.MMap.delegate = self
          typeMap = UserManager.currentUser!.datosMapa.mapaM
         
          switch(typeMap){
          case "1":
              self.MMap.mapType = .normal
              break
          case "2":
              self.MMap.mapType = .hybrid
              break
          default:
              self.MMap.mapType = .normal
              break
          }
          
      }
    
    static func closeSesion(){
         let alerta = UIAlertController(title: IdiomaSelect().seleccionIdioma(caso: "txt_SS"), message: IdiomaSelect().seleccionIdioma(caso: "txt_deCeSe"), preferredStyle: .alert)
         let guiaOk = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_aceptar"), style: .default, handler: {(action) in
             InicioViewController.vc.eliminarData()
         })
         let guiaCancel = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_cancelar"), style: .default, handler: {(action) in
                    })
         alerta.addAction(guiaOk)
         alerta.addAction(guiaCancel)
     
         InicioViewController.vc.present(alerta, animated:true, completion:nil)
     }
    static func returnMenu(){
       /* let alerta = UIAlertController(title: IdiomaSelect().seleccionIdioma(caso: "txt_SS"), message: IdiomaSelect().seleccionIdioma(caso: "txt_deCeSe"), preferredStyle: .alert)
               let guiaOk = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_aceptar"), style: .default, handler: {(action) in*/
                   InicioViewController.vc.eliminarData2()
             /*  })
               let guiaCancel = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_cancelar"), style: .default, handler: {(action) in
                          })
               alerta.addAction(guiaOk)
               alerta.addAction(guiaCancel)
           
               InicioViewController.vc.present(alerta, animated:true, completion:nil)*/
    }
    static func call(){
           let busPhone = "3314098230"
           if let url = URL(string: "tel://\(busPhone)"),
              UIApplication.shared.canOpenURL(url) {
                  if #available(iOS 10, *) {
                      UIApplication.shared.open(url)
                  } else {
                      UIApplication.shared.openURL(url)
                  }
           }
       }
    
    static func openViajes(){
        InicioViewController.vc.delegate?.openViajes()
    }
    
    static func openEventos(){
        InicioViewController.vc.delegate?.openEventos()
    }
    
    func eliminarData(){
        self.websocket!.disconnect()
             // exit(0)
        UserManager.currentUser = nil
       ServersManager.currentServers = nil
        self.delegate?.closeSession()
      }
    func eliminarData2(){
        print("eliminar data 2")
          self.websocket!.disconnect()
               // exit(0)
        UserManager.currentUser = nil
        ServersManager.currentServers?.datos.url1 = ""
        ServersManager.currentServers?.datos.url2 = ""
        ServersManager.currentServers?.datos.url3 = ""
        ServersManager.currentServers?.datos.socket = ""
        ServersManager.currentServers?.datos.nameServ = ""
        self.delegate?.goMenu()
        }
      
    func iniciarSesionSocket(){
           print("iniciar sesion socket")
           self.viewModel.validarUsuarioSocket(webapi: "")
       }
    
    func cargaDataInicio(){
        self.txtEmpresa.text =  servName.uppercased()
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        
        self.viewModel.unidadesService(idUsuario: self.idUsuario, authorization: self.base64LoginString)
        self.viewModel.gruposService(idUsuario: self.idUsuario, authorization: self.base64LoginString)
        
        self.contenidoGlobo.text = DataManager.currentData?.dataApp.GrupoSel
        self.sesion = SesionManager.currentSesion!.datos.sesionID
        if(sesion != ""){self.socket()}else{self.iniciarSesionSocket()}
        
        print("data inicio ",DataManager.currentData?.dataUni.count)
        
        if(DataManager.currentData?.dataApp.Seleccionadas == true){
            self.tipoCarga = 2
            self.unidadesAux = DataManager.currentData!.dataUni
            
            self.unidadesAux.forEach{ unidad in
                print("unidad inicio vuelta ")
                self.viewModel.deviceService(idUnidad: unidad.IdUnidad, nameUnidad: unidad.nameUnidad)
            }
        }
    }
    
    func moveBus(lat:CLLocationDegrees, lon:CLLocationDegrees, icono:UIImage, icono2:UIImage, icono3:UIImage, unidad:String, deegres: Int, ignition: Bool, tipoMov: Int, velocidad: Float, fechaR: String) {
        print("marker mover bus ", self.contador, " - ",self.unidadesSeleccionadas.count, " - ", self.unidadesAux.count)

             let location = CLLocation(latitude: lat, longitude: lon)
         /*    let label = UILabel(frame: CGRect(x: 8, y: -11, width: 35, height: 50))
                    label.text = unidad
                    label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2666666667, alpha: 1) */
         print("icono ",icono)
         print("icono2 ",icono2)
         print("icono3 ",icono3)
         print("ignition ",ignition)
        print ("fecha ", fechaR)
        var enText=""
        let speed = velocidad*1.852
        print ("speed rec ", speed)

                    let number3digits = Double(speed).redondear(numeroDeDecimales: 2)
        
                   let localeSpanish = Locale(identifier: "ES")
                   let simpleDateFormat =  DateFormatter()
                    simpleDateFormat.locale = localeSpanish
                   simpleDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    simpleDateFormat.timeZone = TimeZone.current
                   //DateFormatter("yyyy-MM-dd'T'HH:mm:ss", localeSpanish);
        
     
        
       
                    var spl = fechaR.split(separator: ".")
        
                print("fecha corta ", spl[0])
                let dte = simpleDateFormat.date(from:String(spl[0]))!
                   let myDate = simpleDateFormat.string(from: dte)
        let fechaFuncion = convertDateFormatter(date: String(spl[0]))
        print("fecha funcion ", fechaFuncion)

                                     let output = fechaFuncion


                                     /*  var DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss'Z'";
                                        val output = getFormattedLocalTimeFromUtc(unit.deviceTime!!, DATE_FORMAT )*/
                                     switch(ignition){
                                     case true:
                                             enText = "Si"
                                         
                                         break
                                     case false:
                                             enText = "No"
                                         
                                         break
                                     default:
                                         enText = "Sin información"
                                         break
                                     }
                   
                   let info =  "Fecha: " + output + "\n" + "Encendido:  " + enText + "\n" + "Velocidad: " + number3digits + " Km/h"
        
         if  tipoMov == 1 {
                 print("marker null ")
             switch self.tipoCarga{
             case 1:
                 print("tipo carga 1")
                 if(self.contador >= self.unidadesSeleccionadas.count ){
                                self.banderaRuta = true
                                print("marker banderaruta true ")
                            }
                 break
             case 2:
                 print("tipo carga 2 ")
                 if( self.contador >= self.unidadesAux.count){
                                self.banderaRuta = true
                                print("marker banderaruta true ")

                            }
                 break
             default:
                 break
             }
           
                 let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
                 iconView.image = icono3
                                        
                                        // text
                                        let label = UILabel(frame: CGRect(x: 0, y: -15, width: 100, height:70))
                                        label.text = unidad
                                        label.font = UIFont.boldSystemFont(ofSize: 11.0)
                                        label.textAlignment = .center
                                          //label.font.withSize(11)

                                        label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2666666667, alpha: 1)
                                        iconView.addSubview(label)
                                        UIGraphicsBeginImageContextWithOptions(label.bounds.size, _: false, _: UIScreen.main.scale)
                                        if let context = UIGraphicsGetCurrentContext(){
                                             iconView.layer.render(in: context)
                                        }
                                        let icon = UIGraphicsGetImageFromCurrentImageContext()
                                        UIGraphicsEndImageContext()
                              
                              myLocationMarker3 = GMSMarker(position: location.coordinate)
                              myLocationMarker3.icon = icon
                             
             myLocationMarker3.snippet = info
             myLocationMarker3.title = unidad
             myLocationMarker3.map = self.MMap
             myLocationMarker3.infoWindowAnchor = getInfoWindowAnchorFor(50)
             
            markers3Array.append(myLocationMarker3)
                             
             
            /* "Fecha: " + output + "\n" +
                                                   "Encendido: " + enText + "\n" +
                                                   "Velocidad: " + number3digits + " km/h" + "\n"*/
                 
                 myLocationMarker2 = GMSMarker(position: location.coordinate)
                 myLocationMarker2.icon = icono2
               
                 if(ignition == true){
                 myLocationMarker2.rotation = CLLocationDegrees(deegres)
                 }
                 myLocationMarker2.snippet = info
                 myLocationMarker2.title = unidad
                 myLocationMarker2.map = self.MMap
                 myLocationMarker2.infoWindowAnchor = getInfoWindowAnchorFor(50)
                 markers2Array.append(myLocationMarker2)
             
                 myLocationMarker = GMSMarker(position: location.coordinate)
                 myLocationMarker.icon = icono
                 myLocationMarker.title = unidad
                 myLocationMarker.snippet = info
                 myLocationMarker.map = self.MMap
                
                 myLocationMarker.infoWindowAnchor = getInfoWindowAnchorFor(50)
             
                 markers1Array.append(myLocationMarker)

           //  if(self.unidadesSeleccionadas.count < 2 &&  self.unidadesAux.count < 2){
                 self.MMap.updateMap(toLocation: location)
            // }
                // createMarkerBus(mMap: MMap, lat: lat, lon: lon, textIcon: "", imagen: icono)
             } else {
                 print("marker no null ")
                 print("marker numero de marcadores ", markers1Array.count)
                 var index1 = 0;
                 var index2 = 0;
                 var index3 = 0;
                 var ipl = 0;
                 for i1 in markers1Array { if i1.title == unidad {index1 = ipl};  ipl+=1}; ipl = 0
                 for i2 in markers2Array { if i2.title == unidad {index2 = ipl};  ipl+=1}; ipl = 0
                 for i3 in markers3Array { if i3.title == unidad {index3 = ipl};  ipl+=1}
                 
                 
                 print("marker iguales ",markers3Array[index3].title," - ", markers1Array[index1].title," otro ", markers2Array[index2].title," numero ",markers1Array.count," - ",markers2Array.count," - ", markers3Array.count)
                 let lastlocation = CLLocation(latitude:  markers1Array[index1].position.latitude, longitude:  markers1Array[index1].position.longitude)
                 let degrees = CLLocationDegrees(deegres)
                 
                 markers2Array[index2].icon = icono2
                 if ignition == true {markers2Array[index2].rotation = CLLocationDegrees(deegres)}
               

                 markers1Array[index1].icon = icono
                 
                 markers1Array[index1].snippet = info
                 markers2Array[index2].snippet = info
                 markers3Array[index3].snippet = info
                 

                 updateMarkerBus(marker:  markers1Array[index1], marker2:  markers2Array[index2], marker3:  markers3Array[index3], coordinates: location.coordinate, degrees: degrees, duration: 0.3)
             
             }
        // self.puntoCercano(lat: lat, lon: lon, paradas: self.paradas, unidad: unidad)
         }
    
    func crearBus(lat:CLLocationDegrees, lon:CLLocationDegrees, icono:UIImage, icono2:UIImage, icono3:UIImage, unidad:String, deegres: Int, ignition: Bool){
            let location = CLLocation(latitude: lat, longitude: lon)
            let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
            iconView.image = icono3
                                   
                                   // text
                                   let label = UILabel(frame: CGRect(x: 7, y: -15, width: 100, height:70))
                                   label.text = unidad
                                   label.font = UIFont.boldSystemFont(ofSize: 11.0)
                                     //label.font.withSize(11)

                                   label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2666666667, alpha: 1)
                                   iconView.addSubview(label)
                                   UIGraphicsBeginImageContextWithOptions(label.bounds.size, _: false, _: UIScreen.main.scale)
                                   if let context = UIGraphicsGetCurrentContext() {
                                        iconView.layer.render(in: context)
                                   }
                                   let icon = UIGraphicsGetImageFromCurrentImageContext()
                                   UIGraphicsEndImageContext()
                         
                         let myLocationMarker3 = GMSMarker(position: location.coordinate)
                         myLocationMarker3.icon = icon
                         myLocationMarker3.snippet = unidad
                         myLocationMarker3.map = self.MMap
                         markers3Array.append(myLocationMarker3)
          
            
            let myLocationMarker2 = GMSMarker(position: location.coordinate)
            myLocationMarker2.icon = icono2
            myLocationMarker2.snippet = unidad

            if(ignition == true ){
            myLocationMarker2.rotation = CLLocationDegrees(deegres)
            }
            myLocationMarker2.map = self.MMap
            markers2Array.append(myLocationMarker2)
            let myLocationMarker = GMSMarker(position: location.coordinate)
            myLocationMarker.icon = icono
            myLocationMarker.snippet = unidad
            myLocationMarker.map = self.MMap
            markers1Array.append(myLocationMarker)

            
            self.MMap.updateMap(toLocation: location)
        }
    
    func updateMarkerBus(marker: GMSMarker, marker2:GMSMarker, marker3:GMSMarker, coordinates: CLLocationCoordinate2D, degrees: CLLocationDegrees, duration: Double) {
              // Keep Rotation Short
              CATransaction.begin()
              CATransaction.setAnimationDuration(3) //1
              marker2.rotation = degrees
              marker.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
              marker2.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
              marker3.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.7))
              CATransaction.commit()
              // Movement
              CATransaction.begin()
              CATransaction.setAnimationDuration(3)
              marker.position = coordinates
              marker2.position = coordinates
              marker3.position = coordinates
          
              // Center Map View
        if(self.unidadesSeleccionadas.count < 2 &&  self.unidadesAux.count < 2){
            let camera = GMSCameraUpdate.setTarget(coordinates)
                                              if(self.unidadesSeleccionadas.count < 2 && self.unidadesAux.count < 2){
                         MMap.animate(with: camera)
                                              }
             
          }
              CATransaction.commit()
          }
    
    func limpiarMapa(){
        self.MMap.clear()
        markers2Array.removeAll()
        markers1Array.removeAll()
        markers3Array.removeAll()

        self.unidadAsignada = nil
         self.banderaUnidad = true
         self.banderaRuta = false
         self.contador = 0

     }
   /* func createMarker(mMap : GMSMapView, lat: Double, lon:Double, textIcon:String, title:String) -> GMSMarker {
     //   print("crear marcador ",lat)
           let marker = GMSMarker()
           marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
           // marker.description = title
          // marker.snippet = ubi.encargado
          // marker.userData = ubi
           marker.map = mMap
           marker.icon = createIconMarkerWithText(text: textIcon)
           marker.title = title
           marker.snippet = "Parada "+textIcon
           marker.infoWindowAnchor = getInfoWindowAnchorFor(50)

           return marker
       }*/
    
    func createMarkerBus(mMap : GMSMapView, lat: Double, lon:Double, textIcon:String, imagen: Any) -> GMSMarker {
     print("crear marcador BUS")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
           // marker.title = ubi.descripcion
           // marker.snippet = ubi.encargado
           // marker.userData = ubi#imageLiteral(resourceName: "alfiler")
            marker.map = mMap
          marker.icon = createIconMarkerBusWithText(text: textIcon, imagen:imagen)
            return marker
        }
    
    func createIconMarkerBusWithText(text:String, imagen:Any) -> UIImage{
                // image
                let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                iconView.image = imagen as! UIImage
                
                // text
            
                let label = UILabel(frame: CGRect(x: 8, y: -11, width: 35, height: 50))
                label.text = text
                label.font = label.font.withSize(10)

                label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1529411765, blue: 0.2666666667, alpha: 1)
                iconView.addSubview(label)
               
                // grab it
                UIGraphicsBeginImageContextWithOptions(label.bounds.size, _: false, _: UIScreen.main.scale)
                if let context = UIGraphicsGetCurrentContext() {
                    iconView.layer.render(in: context)
                }
                let icon = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return icon!
            }
    
    func getInfoWindowAnchorFor(_ angle: Double) -> CGPoint {
            let x = sin(-angle * Double.pi / 180) * 0.5 + 0.5
            let y = -(cos(-angle * Double.pi / 180) * 0.5 - 0.5)
            return CGPoint(x: x, y: y)
        }
    
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "es_ES")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM dd HH:mm:ss EEEE"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "GMT-6") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    func convertDateFormatter2(date: String) -> String {
        var fdate = date.split(separator: "T")
        
        let fecha = fdate[0] + " " + fdate[1]
        print("Fecha recibida ", fecha)
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let fechaI = dateFormatter.date(from: String(fecha))
        var fechaS = dateFormatter.string(from: fechaI!)//.split(separator: " ")
        
        let timeStamp = fechaS
        return timeStamp
    }
}

extension InicioViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

extension InicioViewController: GMSMapViewDelegate {
    //class code

    @objc(mapView:didTapMarker:) func mapView(_: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if(marker.title != nil){
            print("MArcador selected ",marker.title)
            self.MMap.selectedMarker = marker

            let m = marker.title
            //self.unidadAsignada.datos.forEach{ unidad in
          /*  self.paradasMod?.datos.forEach{ p in
                //print("MArcador selected 2",p)
                if(p.nombre_parada == m){
                  // print("MArcador selected 3 ")
                   let vc: ImagenParadaView = ImagenParadaView()
                          vc.viewModel = self.viewModel
                   vc.imgZoomR = p

                   let rowVC: PanModalPresentable.LayoutType = vc
                   
                        //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
                          dismiss(animated: true, completion: nil)
                          presentPanModal(rowVC)
               }
            }*/
        }
        
        return true
    }
}
extension GMSMapView {
    func updateMap(toLocation location: CLLocation, zoomLevel: Float? = nil) {
        print("update map ")
        if let zoomLevel = zoomLevel {
            let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: zoomLevel)
            animate(with: cameraUpdate)
        } else {
            animate(toLocation: location.coordinate)
        }
    }
}

class CustomInfoWindow: UIView {

    @IBOutlet var completedYearLbl: UILabel!
    @IBOutlet var architectLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!

}

extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}

