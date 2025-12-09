//
//  EventoViewMapa.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Alamofire
import Polyline
import MapKit
class EventoViewMapa: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var MMap: GMSMapView!
    @IBOutlet weak var newBusqueda: GRButton!
    @IBOutlet weak var btnBackt: GRButton!
    @IBOutlet weak var btnCapas: GRButton!
    
    public weak var delegate: EventosViewDelegate?
    
    var viewModel = EventosViewModel()
    var eventData: ItemEvents?
    var eventItem = [ItemEvents]()
    var base64LoginString = ""
    var idUsuario = 0
    var fecha1 = ""
    var fecha2 = ""
    var icono: UIImage?=nil
    var marcadores : Bool?
    var rutapoint =  [ItemEvents]()
    var unidadName = ""
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
        print("Evento DAta ", self.eventData)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        setupMap()
        setupViewModel()
        self.icono = #imageLiteral(resourceName: "puntero")
        self.viewModel.positionService(Authorization: base64LoginString, id: (self.eventData?.positionId)!)
    }
    
    @IBAction func btnBackt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCapas(_ sender: Any) {
       
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
    
    @IBAction func btnBusqueda(_ sender: Any) {
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
    func setupViewModel(){
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
        
        self.viewModel.didGetPosition = { posicion in
            var f1 =  self.eventData?.eventTime!.split(separator: ".")
            var speed = posicion.speed!*1.852
                                
            let number3digits =  Double(speed).redondear(numeroDeDecimales: 2)
            
            let posicion2 = CLLocationCoordinate2D(latitude: Double(posicion.latitude!), longitude: Double(posicion.longitude!))
            let myLocationMarker = GMSMarker(position: posicion2)
            myLocationMarker.icon = self.icono
            myLocationMarker.snippet = "Fecha : " + self.convertDateFormatter(date: String(f1![0])) + " \n"+" Velocidad: " + number3digits + " Km/h"
            myLocationMarker.title = IdiomaComandos().seleccionIdiomaComandos(caso: (self.eventData?.type!)!)
            myLocationMarker.rotation = Double(posicion.course!)
            myLocationMarker.map = self.MMap
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
    func convertDateFormatter(date: String) -> String {
        print("fecha ",date )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "es_ES")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "EEEE dd MMM yyyy HH:mm:ss"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "GMT-5") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
}

extension EventoViewMapa: GMSMapViewDelegate {
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

