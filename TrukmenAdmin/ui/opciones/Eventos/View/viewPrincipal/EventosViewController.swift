                                                                                                                                                                                                                                                           
//  EventosViewController.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import PanModal
class EventosViewStoryboard: UIViewController {
    @IBOutlet weak var btnHome: GRButton!
    @IBOutlet weak var textUnidad: UILabel!
    @IBOutlet weak var textPeriodo: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var unidades  = [ItemUnidades]()
    var periodos  = [Periodo]()
    var viewModel = EventosViewModel()
    var unity : ItemUnidades!
    var period : Periodo!
    var fecha1 = ""
    var fecha2 = ""
    var base64LoginString = ""
    var idUsuario = 0
    var eventos = [ItemEvents]()
    let alertaL: AlertaLoading = AlertaLoading()
    var rowVCG: PanModalPresentable.LayoutType?
    public weak var delegate: EventosViewDelegate?
    static var vc = EventosViewStoryboard()
    override func viewDidLoad() {
           super.viewDidLoad()
        
        // Configurar gestos manuales para asegurar que los botones funcionen
        if let btnUnidadView = self.view.viewWithTag(100) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(btnUnidad(_:)))
            btnUnidadView.addGestureRecognizer(tap)
            btnUnidadView.isUserInteractionEnabled = true
        }
        
        if let btnPeriodoView = self.view.viewWithTag(101) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(btnPeriodo(_:)))
            btnPeriodoView.addGestureRecognizer(tap)
            btnPeriodoView.isUserInteractionEnabled = true
        }
        
        CargaDatosInicio()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool){
           super.viewWillAppear(animated)
     //   self.navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
      //  self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        print("boton home ")
        delegate?.Back()

    }
    
    @IBAction func btnUnidad(_ sender: Any) {
        print(" BOTON UNIDAD PRESIONADO")
        print(" Cantidad de unidades: \(self.unidades.count)")
        
        if(self.unidades.count > 0){
            print(" Intentando abrir modal... Unidades count: \(self.unidades.count)")
            let vc: AlertaUnidadesEventos
                    = AlertaUnidadesEventos(nibName: "AlertaUnidadesEventos", bundle: nil)
                    vc.viewModel = self.viewModel
                    vc.unidadesData = self.unidades
                    vc.unidadesFilter = self.unidades
        let rowVC: PanModalPresentable.LayoutType = vc
                                //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
                                  dismiss(animated: true, completion: nil)
                                  print(" Presenting PanModal for Unidades...")
                                  presentPanModal(rowVC)
        }else {
            print(" No hay unidades, intentando recargar...")
            self.viewModel.unidadesService(idUsuario: idUsuario, authorization: base64LoginString)
        }
    }
    
    @IBAction func btnPeriodo(_ sender: Any) {
        if(self.periodos.count > 0){
                  let vc: AlertaPeriodoEventos = AlertaPeriodoEventos(nibName: "AlertaPeriodoEventos", bundle: nil)
                  vc.viewModel = self.viewModel
                  vc.periodoData = self.periodos
                  vc.periodoFilter = self.periodos
                  let rowVC: PanModalPresentable.LayoutType = vc

                  dismiss(animated: true, completion: nil)
                  presentPanModal(rowVC)
              }else {
                  self.viewModel.getPeriodos()
              }
    }
    
    @IBAction func btnBucar(_ sender: Any) {
        if( self.fecha1 != "" &&  self.fecha2 != "" && self.unity.id != 0 ){
            self.viewModel.EventsService(Authorization: base64LoginString, deviceId: unity.id!, type: "allEvents", from: self.fecha1, to: self.fecha2)
        }else{
           print("Algo hay vacio")
        }
    }
    
    func CargaDatosInicio(){
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        
        self.viewModel.unidadesService(idUsuario: idUsuario, authorization: base64LoginString)
        
        self.viewModel.getPeriodos()
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


self.viewModel.didGetPeriodo = { Period in
   print("periodos ")
   self.periodos = Period
}
self.viewModel.didGetUnidades = { unidad in
   print(" RECIBIDAS UNIDADES DEL SERVICIO: \(unidad.count)")
   self.unidades = unidad
}


self.viewModel.selectUnidad = { unity in
   self.unity = unity
   self.textUnidad.text = self.unity.name
}



self.viewModel.selectPeriodo = { period in
   self.period = period
   self.textPeriodo.text = self.period.periodo
   self.getPeriodo(periodo: self.period.id)
   print("PEriodo Select ",self.period)
}
        self.viewModel.didGetEvent = { evnets in
            self.eventos = evnets
            print("Eventos ", self.eventos)
     
            let vcn = UIStoryboard(name: "EventosListaViewController", bundle: nil)
                  .instantiateViewController(withIdentifier: "EventosListaViewController") as! EventosListaViewController
         vcn.delegate = self.delegate
         vcn.viewModel = self.viewModel
         vcn.eventsData = evnets
         vcn.eventsFilter = evnets
         vcn.unity = self.unity
              self.navigationController?.pushViewController(vcn,animated: true)
        }
    }
    
    func getPeriodo(periodo: Int) -> (String, String) {
    
        let data = Date()
        let calendar = NSCalendar.current
        var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: data)
        var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: data)
        let currentDate = NSDate()
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        var fmt = DateFormatter()
       
        switch(periodo){
        case 1:
         print("nada ")
            break
        case 2:
            print("case 3 hoy ", data)
            var nextDAy = Date.nextDay2(sunday: data)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: nextDAy)
            
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan Standard Time
            
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
                        
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
            
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                     
                     print("fecha1 C ",fecha1, " fecha2 C ", self.fecha2)
            break
        case 3:
            print("case 3 ayer ", data)
            var lastDAy = Date.changeDaysBy(days: -1)
            var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: lastDAy)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: data)
            
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
            
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                     
        print("fecha1 C ",fecha1, " fecha2 C ", self.fecha2)
            
            break
        case 4:
            print("case 4 semana actual")
            var lastDAy = Date().startOfWeek
            let endWeek = Date().endOfWeek
            var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: lastDAy!)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: endWeek!)
            
            
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
                       
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                                
            print("fecha1 C ",fecha1, " fecha2 C ", self.fecha2)
            
            print("inicio de semana ", lastDAy)
            break
        case 5:
            print("case 5 semana anterior")
            
            var lastweek = Date().startOfLastWeek
            let lastDAy = lastweek?.startOfWeek
            let endWeek = Date().startOfWeek
            var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: lastDAy!)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: endWeek!)
                        
                        
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
                        
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
                        
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
                                   
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                                            
            print("fecha1 C5 ",fecha1, " fecha2 C5 ", self.fecha2)
                        
            print("inicio de semana ", lastDAy, " lastWeek ", lastweek)
            break
        case 6:
            print("case 6 mes actual")
            let nextMonth = Date.nextMont(sunday: data)
            var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: data)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: nextMonth)
            
            firstDateComponents.day = 01
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            secondDateComponents.day = 01
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
                                   
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                                            
            print("fecha1 C6 ",fecha1, " fecha2 C6 ", self.fecha2)
            
            break
        case 7:
            print("case 7 mes anterior")
            let lastMonth = Date.lastMont(sunday: data)
            var firstDateComponents = calendar.dateComponents([.day, .month, .year], from: lastMonth)
            var secondDateComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: data)
            
            firstDateComponents.day = 01
            firstDateComponents.hour = 05
            firstDateComponents.minute = 00
            firstDateComponents.second = 00
            firstDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            secondDateComponents.day = 01
            secondDateComponents.hour = 05
            secondDateComponents.minute = 00
            secondDateComponents.second = 00
            secondDateComponents.timeZone = TimeZone(abbreviation: "UTC") // Japan
            
            self.fecha1 = numeros(numero: firstDateComponents.year!) + "-" + numeros(numero: firstDateComponents.month!) + "-"  + numeros(numero: firstDateComponents.day!) + "T" +  numeros(numero: firstDateComponents.hour!) + ":" + numeros(numero: firstDateComponents.minute!) + ":" + numeros(numero: firstDateComponents.second!) + "Z"
                                   
            self.fecha2 = numeros(numero: secondDateComponents.year!) + "-" + numeros(numero: secondDateComponents.month!) + "-"  + numeros(numero: secondDateComponents.day!) + "T" +  numeros(numero: secondDateComponents.hour!) + ":" + numeros(numero: secondDateComponents.minute!) + ":" + numeros(numero: secondDateComponents.second!) + "Z"
                                            
            print("fecha1 C7 ",fecha1, " fecha2 C7 ", self.fecha2)

            break
        default:
            print("case 8")

            break
        }
        
        return ("", "")
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
    
    
     func getLastDay(_ nowDay: Date) -> String {
         var fmt = DateFormatter()
         let calendar = NSCalendar.current
         let fech =     calendar.date(byAdding: .day, value: -1, to: nowDay)
         
         return fmt.string(from: fech!)
        }
}
