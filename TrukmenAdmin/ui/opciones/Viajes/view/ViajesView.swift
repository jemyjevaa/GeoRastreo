//
//  ViajesView.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 28/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import WOWCheckbox
import PanModal

class ViajesView: UIViewController {
    @IBOutlet weak var unidadName: UILabel!
    @IBOutlet weak var grupoName: UILabel!
    @IBOutlet weak var periodoName: UILabel!
    
    @IBOutlet weak var btnChecbox: WOWCheckbox!
    
    var unidades  = [ItemUnidades]()
    var periodos  = [Periodo]()
    var grupos    = [ItemGrupo]()
    var viewModel = ViajesViewModel()
    var group : ItemGrupo!
    var unity : ItemUnidades!
    var period : Periodo!
    var base64LoginString = ""
       var idUsuario = 0
       public weak var delegate: ViajesViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        self.base64LoginString = (UserManager.currentUser?.datos.BasicAuthorization)!
        self.idUsuario = (UserManager.currentUser?.datos.id)!
        // Do any additional setup after loading the view.
        self.viewModel.getGrupos(authorization: base64LoginString, userId: idUsuario)
        self.viewModel.getPeriodos()
        self.viewModel.unidadesService(idUsuario: idUsuario, authorization: base64LoginString)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        print("buscar ")
     /*
        let f1 =   "2022-06-07T00:00:00Z"
        let f2 =   "2022-06-08T12:59:59Z"

        self.viewModel.TripsService(authorization: base64LoginString, deviceId: self.unity.id!, from: f1, to: f2)
        
        */
        
       
    }
    
    @IBAction func btnCheck(_ sender: Any) {
    }
    
    @IBAction func btnHome(_ sender: Any) {
        print("btn home ")
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
        }
        
    }
}
