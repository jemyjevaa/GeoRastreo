//
//  ViajesViewStoryboard.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 09/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//
import UIKit
import WOWCheckbox
import PanModal

class ViajesViewStoryboard: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var unidadName: UILabel!
    @IBOutlet weak var grupoName: UILabel!
    @IBOutlet weak var periodoName: UILabel!
    @IBOutlet weak var btnChecbox: WOWCheckbox!
    @IBOutlet weak var scrollview: UIScrollView!
        
    var unidades  = [ItemUnidades]()
    var periodos  = [Periodo]()
    var grupos    = [ItemGrupo]()
    var viewModel = ViajesViewModel()
    var group : ItemGrupo!
    var unity : ItemUnidades!
    var period : Periodo!
    var fecha1 = ""
    var fecha2 = ""
    var base64LoginString = ""
       var idUsuario = 0
       public weak var delegate: ViajesViewDelegate?
    static var vc = ViajesViewStoryboard()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🚀 ViajesViewStoryboard viewDidLoad INICIADO")
        
        // Configurar gestos manuales (Fallback si @IBAction falla)
        if let btnUnidadView = self.view.viewWithTag(100) {
            print("✅ VISTA TAG 100 ENCONTRADA - Agregando Gesto")
            let tap = UITapGestureRecognizer(target: self, action: #selector(btnUnidad(_:)))
            btnUnidadView.addGestureRecognizer(tap)
            btnUnidadView.isUserInteractionEnabled = true
        } else {
            print("❌ VISTA TAG 100 NO ENCONTRADA")
        }
        
        if let btnGrupoView = self.view.viewWithTag(101) {
            print("✅ VISTA TAG 101 ENCONTRADA - Agregando Gesto")
            let tap = UITapGestureRecognizer(target: self, action: #selector(btnGrupo(_:)))
            btnGrupoView.addGestureRecognizer(tap)
            btnGrupoView.isUserInteractionEnabled = true
        } else {
            print("❌ VISTA TAG 101 NO ENCONTRADA")
        }
        
        if let btnPeriodoView = self.view.viewWithTag(102) {
            print("✅ VISTA TAG 102 ENCONTRADA - Agregando Gesto")
            let tap = UITapGestureRecognizer(target: self, action: #selector(btnPeriodo(_:)))
            btnPeriodoView.addGestureRecognizer(tap)
            btnPeriodoView.isUserInteractionEnabled = true
        } else {
            print("❌ VISTA TAG 102 NO ENCONTRADA")
        }
        
        setupViewModel()
        ViajesViewStoryboard.vc = self
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        
        // Cargar datos iniciales
        self.viewModel.getGrupos(authorization: base64LoginString, userId: idUsuario)
        self.viewModel.getPeriodos()
        self.viewModel.unidadesService(idUsuario: idUsuario, authorization: base64LoginString)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        print("🏁 ViajesViewStoryboard viewDidLoad COMPLETADO")
    }
    
    
    @IBAction func btnUnidad(_ sender: Any) {
        print("🔵 BOTON UNIDAD PRESIONADO")
        print("unidades envio alerta ", self.unidades.count)
        if(self.unidades.count > 0){
            let vc: UnidadesGeneral
                    = UnidadesGeneral(nibName: "UnidadesGeneral", bundle: nil)
                    vc.viewModel = self.viewModel
                    vc.unidadesData = self.unidades
                    vc.unidadesFilter = self.unidades
        let rowVC: PanModalPresentable.LayoutType = vc
                                //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
                                  presentPanModal(rowVC)
        }else {
            print("⚠️ NO HAY UNIDADES - INTENTANDO RECARGAR")
            let alert = UIAlertController(title: "Sin Datos", message: "No hay unidades cargadas. Intentando recargar...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.viewModel.unidadesService(idUsuario: idUsuario, authorization: base64LoginString)
        }
    }
    
    @IBAction func btnGrupo(_ sender: Any) {
        print("🟢 BOTON GRUPO PRESIONADO")
        print("grupos envio alerta ", self.grupos.count)
               if(self.grupos.count > 0){
                   let vc: AlertaGruposViajes = AlertaGruposViajes(nibName: "AlertaGruposViajes", bundle: nil)
                              vc.viewModel = self.viewModel
                              vc.grupoData = self.grupos
                              vc.grupoFilter = self.grupos
                              let rowVC: PanModalPresentable.LayoutType = vc
                   
                              presentPanModal(rowVC)
               }else{
                   print("⚠️ NO HAY GRUPOS - INTENTANDO RECARGAR")
                   let alert = UIAlertController(title: "Sin Datos", message: "No hay grupos cargados. Intentando recargar...", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                   
                   self.viewModel.getGrupos(authorization: self.base64LoginString, userId: self.idUsuario)
               }
    }
    
    @IBAction func btnPeriodo(_ sender: Any) {
        print("🟡 BOTON PERIODO PRESIONADO")
        print("periodos envio alerta ", self.periodos.count)
        if(self.periodos.count > 0){
            let vc: AlertaPeriodosViajes = AlertaPeriodosViajes(nibName: "AlertaPeriodosViajes", bundle: nil)
            vc.viewModel = self.viewModel
            vc.periodoData = self.periodos
            vc.periodoFilter = self.periodos
            let rowVC: PanModalPresentable.LayoutType = vc

            presentPanModal(rowVC)
        }else {
            print("⚠️ NO HAY PERIODOS - INTENTANDO RECARGAR")
            let alert = UIAlertController(title: "Sin Datos", message: "No hay periodos cargados. Intentando recargar...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.viewModel.getPeriodos()
        }
    }
    
    
    
    @IBAction func btnBuscar(_ sender: Any) {
        print ("buscar 2 story")
       
        
 
        
        let f1 =   "2022-06-07T00:00:00Z"
               let f2 =   "2022-06-08T12:59:59Z"
       // print("grupo id ", self.group.id! )
        var tipoReporte = 0
        var tipoReporte2 = 0
        if(self.group != nil){
            if(self.unity != nil ){
                tipoReporte = 3
            }else{
                tipoReporte = 1
            }
        }else{
            if(self.unity != nil ){
                tipoReporte = 2
            }
        }
        switch(tipoReporte){
        case 1:
            self.viewModel.TripsService2(authorization: base64LoginString, groupId: self.group.id!, from: self.fecha1, to: self.fecha2)
            break
        case 2:
            self.viewModel.TripsService(authorization: base64LoginString, deviceId: self.unity.id!, from: self.fecha1, to: self.fecha2)
            break
        case 3:
            self.viewModel.TripsServiceComplet(authorization: base64LoginString, groupId: self.group.id!,deviceId: unity.id!, from: self.fecha1, to: self.fecha2)
            break
        default:
            print("alerta de error de campos ")
            break
        }
        
        print("Tipo Reporte ",tipoReporte)
      /*  if(self.group != nil){
            if(self.group.id != 0){
                if(self.unity != nil){
                    if(self.unity.id != 0){
                        
                    }
                }
                self.viewModel.TripsService2(authorization: base64LoginString, groupId: self.group.id!, from: self.fecha1, to: self.fecha2)
            }
        }else{
            print("grupo nil ")
            self.viewModel.TripsService(authorization: base64LoginString, deviceId: self.unity.id!, from: self.fecha1, to: self.fecha2)
        } */
       
        
    }
    
    @IBAction func btnBuscar2(_ sender: Any) {
        print("buscar ")
      
       
    }
    
    @IBAction func btnCheck(_ sender: Any) {
    }
    
    @IBAction func btnHome(_ sender: Any) {
        print("Home")
        delegate?.Back()

    }
    
    fileprivate func setupViewModel(){
                 self.viewModel.showAlertClosure = {
                     let alertMsg = self.viewModel.alertMessage ?? "Error desconocido"
                     print("❌ ERROR ALERT: \(alertMsg)")
                     let alert = UIAlertController(title: "Error", message: alertMsg, preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
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
        
        self.viewModel.didGetGrupos = { grupo in
        print("grupos ")
            self.grupos = grupo
        }
        self.viewModel.didGetPeriodo = { Period in
            print("peridos ")
            self.periodos = Period
        }
        self.viewModel.didGetUnidades = { unidad in
            print("✅ RECIBIDAS UNIDADES: \(unidad.count)")
            self.unidades = unidad
        }
        
        self.viewModel.didGetTrips = {trips in
            print("Trips ", trips)
            let marcadores: Bool?
            if(self.btnChecbox.isChecked){
                marcadores = true
            }else{
                marcadores = false
            }
            print("marcadores ",marcadores)

               let vcn = UIStoryboard(name: "ListaReporteController", bundle: nil)
                     .instantiateViewController(withIdentifier: "ListaReporteController") as! ListaReporteController
            vcn.delegate = self.delegate
            vcn.viewModel = self.viewModel
            vcn.tripsData = trips
            vcn.tripsFilter = trips
            vcn.marcadores = marcadores
            vcn.unity = self.unity
            vcn.grupo = self.group
                 self.navigationController?.pushViewController(vcn,animated: true)
        }
        self.viewModel.selectUnidad = { unity in
            self.unity = unity
            self.unidadName.text = self.unity.name
        }
        
        self.viewModel.selectGrupo = { group in
            self.group = group
            self.grupoName.text = self.group.name
        }
        
        self.viewModel.selectPeriodo = { period in
            self.period = period
            self.periodoName.text = self.period.periodo
            self.getPeriodo(periodo: self.period.id)
            print("PEriodo Select ",self.period)
        }
        
    }
    
    @objc
       private func nextViewController() {
           print("Presenta View Controller B")
           self.navigationController?.pushViewController(ListaReporteController(),
                                                                animated: true)
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

extension Date {
  static func changeDaysBy(days : Int) -> Date {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.day = days
    return Calendar.current.date(byAdding: dateComponents, to: currentDate)!
  }
    
    static func nextMont(sunday: Date) ->  Date {
        let gregorian = Calendar(identifier: .gregorian)
           
        return gregorian.date(byAdding: .month, value: 1, to: sunday)!
    }
    
    static func nextDay2(sunday: Date) ->  Date {
        let gregorian = Calendar(identifier: .gregorian)
           
        return gregorian.date(byAdding: .day, value: 1, to: sunday)!
    }
    static func lastMont(sunday: Date) ->  Date {
        let gregorian = Calendar(identifier: .gregorian)
           
        return gregorian.date(byAdding: .month, value: -1, to: sunday)!
    }
    var startOfWeek: Date? {
          let gregorian = Calendar(identifier: .gregorian)
          guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
          return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
            let gregorian = Calendar(identifier: .gregorian)
            guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
            return gregorian.date(byAdding: .day, value: 8, to: sunday)
        }
    var startOfLastWeek: Date? {
          let gregorian = Calendar(identifier: .gregorian)
          guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
          return gregorian.date(byAdding: .day, value: -1, to: sunday)
    }
    var nextDay: Date? {
            let gregorian = Calendar(identifier: .gregorian)
            guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
            return gregorian.date(byAdding: .day, value: 2, to: sunday)
      }
}
