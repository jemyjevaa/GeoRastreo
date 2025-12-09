//
//  MapaViajesStoryboard.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 17/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Alamofire
import Polyline
import MapKit

class MapaViajesStoryboard: UIViewController, UIGestureRecognizerDelegate{
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var MMap: GMSMapView!
    @IBOutlet weak var newBusqueda: GRButton!
    @IBOutlet weak var btnBackt: GRButton!
    @IBOutlet weak var btnCapas: GRButton!
    
    public weak var delegate: ViajesViewDelegate?
    
    var viewModel = ViajesViewModel()
    var tripData: ItemViajes?
    var rutaItem = [ItemRuta]()
    var base64LoginString = ""
       var idUsuario = 0
    var fecha1 = ""
    var fecha2 = ""
    var icono: UIImage?=nil
    var marcadores : Bool?
    var rutapoint =  [ItemRuta]()

    var path = GMSPath()
    var isDrawPath = false
    var i: UInt = 0
    var timer: Timer!
    var animationPath = GMSMutablePath()
    var animationPolyline = GMSPolyline()
    var polyline : Array<GMSPolyline> = []
    var coordinates: Array<CLLocationCoordinate2D> = []
    var typeMap: String = "1"
    override func viewDidLoad() {
    super.viewDidLoad()
    print("marcadores ",marcadores!)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        setupMap()
        setupViewModel()
        cargaRuta()
    }
    
    @IBAction func btnCapas(_ sender: Any) {
        print("boton capas ")
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
                      self.MMap.mapType = .satellite
                  default:
                      self.MMap.mapType = .normal
                      break
                  }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        print("boton back")
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnBusqueda(_ sender: Any) {
        print("boton busqueda")
        //self.navigationController?.popToRootViewController(animated: true)
        self.popBack(3)

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
        
        self.viewModel.didGetRout = {  ruta in
            print("ruta seleccionada ", ruta)
            self.rutaItem = ruta
            
            self.successRuta()
        
        }
        
        // Or for a functional approach :
        //let encodedPolyline: String = encodeCoordinates(coordinates)
    }
    
    func successRuta(){
        let path = GMSMutablePath()
        self.rutaItem.forEach{ rute in
                    var speed = rute.speed!*1.852
                    
                    let number3digits =  Double(speed).redondear(numeroDeDecimales: 2)
                    
                    let location = CLLocation(latitude: rute.latitude!, longitude: rute.longitude!)
                    let coordinate = CLLocationCoordinate2D(latitude: rute.latitude!, longitude: rute.longitude!)
                    
                    let myLocationMarker = GMSMarker(position: location.coordinate)
                    myLocationMarker.icon = self.icono
                    myLocationMarker.snippet = rute.address
                    myLocationMarker.title = "Velocidad: " + number3digits + " km/h"
                    myLocationMarker.rotation = rute.course!
                    myLocationMarker.map = self.MMap
                   
                    self.rutapoint.append(rute)
                    self.coordinates.append(coordinate)
                    print("Coordenate ",coordinate)
                    path.add(coordinate)
            
                }

            let rectangle = GMSPolyline(path: path)
            rectangle.strokeWidth = 2.0
            rectangle.map = self.MMap

        
        
        /*
        
        let wpt = self.viewModel.generarWaypointsXL(obj: self.rutaItem)
        let wpf = self.viewModel.generarWaypointsFin(obj: self.rutaItem)
        var wp = wpt.split(separator: "@")
        var wf = wpf.split(separator: "@")
        var x = 0
      
        for w in wp {
          //
            print("datos w ", w)
            print("datos x ", x)
            
            let wr = w.split(separator: "$")
            print("datos wr ", wr.count)
            print("datos wf ",wf.count)
            print("datos wp ",wp.count)

            if(wr[0] != nil){
                let lt = wr[1].split(separator: ",")
               
                
                if(x == wf.count){
                    let latOrigen =  lt[0]
                    let lonOrigen =  lt[1]
                    let latDestino = String(self.rutaItem[self.rutaItem.count - 1].latitude!)
                    let lonDestino = String(self.rutaItem[self.rutaItem.count - 1].longitude!)
                    print("inicioLN ",latOrigen," ",lonOrigen," fin ",latDestino," ",lonDestino)
                    self.drawRuta(latOrigen: String(latOrigen), lonOrigen: String(lonOrigen), latDestino: String(latDestino), lonDestino: String(lonDestino), wayPoints: String(wr[0]))
                }else {
                let lt2 = wf[x].split(separator: ",")
                let latOrigen =  lt[0]
                let lonOrigen =  lt[1]
                let latDestino = lt2[0]
                let lonDestino = lt2[1]
                print("inicioLN ",latOrigen," ",lonOrigen," fin ",latDestino," ",lonDestino)
                self.drawRuta(latOrigen: String(latOrigen), lonOrigen: String(lonOrigen), latDestino: String(latDestino), lonDestino: String(lonDestino), wayPoints: String(wr[0]))
                }
            }
            x = x + 1
        }
        */
                /*let polyline = Polyline(coordinates: self.coordinates)
                        let encodedPolyline: String = polyline.encodedPolyline
                        
                print("POLYLINE ", self.rutapoint.count ," -- ",encodedPolyline)
                let waypoints = self.viewModel.generarWaypoints(obj: self.rutapoint)
                
                self.drawRuta(latOrigen: String(self.rutapoint[0].latitude!) , lonOrigen: String(self.rutapoint[0].longitude!), latDestino: String(self.rutapoint[(self.rutapoint.count-1)].latitude!), lonDestino: String(self.rutapoint[(self.rutapoint.count-1)].longitude!), wayPoints: waypoints)*/
    }
    
    func cargaRuta(){
        print("fecha1 carga  ",tripData?.startTime, " fecha2 carga  ", self.tripData?.endTime)

        let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let d1 = self.tripData?.startTime?.split(separator: ".")
        let d2 = self.tripData?.endTime?.split(separator: ".")
        let d11 = dateFormatter.date(from: String(d1![0]))
        let d22 = dateFormatter.date(from: String(d2![0]))
        let calendar = NSCalendar.current
        var firstDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: d11!)
        
        var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from:d22!)
        
      

        self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
                   
        self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                            
        print("fecha1 Mapa  ",fecha1, " fecha2 Mapa  ", self.fecha2)
        
        self.viewModel.RouteService(authorization: base64LoginString, deviceId: (tripData?.deviceId)!, from: (self.fecha1), to: (self.fecha2))
        
        if(self.marcadores == true ){
            self.icono = #imageLiteral(resourceName: "puntero")
        }else{
            self.icono = #imageLiteral(resourceName: "puntos")
        }
    }
    
    func numeros(numero: Int) -> String {
           var nn = ""
           
           if(numero<10){
               nn = "0" + String(numero)
           }else{
               nn = String(numero)
           }
           
           return nn
       }
    
    func drawRuta(latOrigen: String,lonOrigen: String,latDestino: String,lonDestino: String, wayPoints:String){
        print("drawruta ",latOrigen," - ", latDestino," - ", lonDestino," - ", lonOrigen," - ", wayPoints)
        let url = self.viewModel.getURL(latitude: latOrigen, longitude: lonOrigen, latitudeto: latDestino, longitudeto: lonDestino, waypoints: wayPoints)
                   Alamofire.request(url).responseJSON{ response in
                       
                       print(response.request as Any)
                       print(response.response as Any)
                       print(response.data as Any)
                       print(response.result as Any)
                       
                       //let json = JSON(data: response.data!)
                       do {
                       
                       let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                       
                           let routesArray = json["routes"] as! NSArray
                           
                           if (routesArray.count > 0)
                           {
                               let routeDict = routesArray[0] as! Dictionary<String, Any>
                               let routeOverviewPolyline = routeDict["overview_polyline"] as! Dictionary<String, Any>
                               let points = routeOverviewPolyline["points"]
                               let poly = GMSPolyline()
                               self.path = GMSPath.init(fromEncodedPath: points as! String)!
                               
                            poly.path = self.path
                            poly.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                           poly.strokeWidth = 3.0
                           poly.map = self.MMap
                           
                               self.isDrawPath = true
                               self.i = 0
                               self.animationPath = GMSMutablePath()
                               self.animationPolyline.map = nil
                               
                               self.polyline.append(poly)
                              // poly.map = nil
                               self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.animatePolylinePath), userInfo: nil, repeats: true)
                           }
                           
                        } catch let error as NSError {
                           print(error)
                        }
                   }
    }
    
    @objc func animatePolylinePath() {
         if isDrawPath {
         if (self.i < self.path.count()) {
             self.animationPath.add(self.path.coordinate(at: self.i))
             self.animationPolyline.path = self.animationPath
             self.animationPolyline.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
             self.animationPolyline.strokeWidth = 3
             self.animationPolyline.map = self.MMap
             self.i += 1
         }
         else {
             self.i = 0
             self.animationPath = GMSMutablePath()
             self.animationPolyline.map = nil
         }
       }
     }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}



extension MapaViajesStoryboard: GMSMapViewDelegate {
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
    func updateMap1(toLocation location: CLLocation, zoomLevel: Float? = nil) {
        print("update map ")
        if let zoomLevel = zoomLevel {
            let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: zoomLevel)
            animate(with: cameraUpdate)
        } else {
            animate(toLocation: location.coordinate)
        }
    }
}

