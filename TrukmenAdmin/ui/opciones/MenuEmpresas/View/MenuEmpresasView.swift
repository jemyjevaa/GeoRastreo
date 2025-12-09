//
//  MenuEmpresasViewmodel.swift
//  TrukmenAdmin
//
//  Created by Desarrollo Movil on 07/06/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import UIKit
import Spring
import FSnapChatLoading
import PanModal
class MenuEmpresasView: UIViewController {
    @IBOutlet weak var spring2: SpringView!
    @IBOutlet weak var spring3: SpringView!
    @IBOutlet weak var Acceder3: UIButton!
    @IBOutlet weak var spring1: SpringView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var Acceder2: UIButton!
    @IBOutlet weak var Acceder1: UIButton!
    var viewModel = MenuEmpresasViewModel()
    public weak var delegate: BackToFirstViewControllerDelegate?
    var delegate1: MenuEmpresaViewDelegate?
    var base64LoginString = ""
    var unidadesAux = [DataUni]()
    let loadingView = FSnapChatLoadingView()
    var servName = ""
    var servers : ItemServidores?
    var se1 =   ServersManager.currentServers?.datos.url1
    var se2 =   ServersManager.currentServers?.datos.url2
    var se3 =   ServersManager.currentServers?.datos.socket
    
    var user_name = ServersManager.currentServers?.datos.user
    var password = ServersManager.currentServers?.datos.pass
    
    let alertaL: AlertaLoading = AlertaLoading()
    var rowVC: PanModalPresentable.LayoutType?
    override func viewDidLoad(){
        super.viewDidLoad()
        editVista()
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnBusMex(_ sender: Any) {
        self.rowVC = alertaL
               //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
        dismiss(animated: true, completion: nil)
        presentPanModal(rowVC!)
        
        print("Busmen México")
        self.servName = "busmen"
        ServersManager.currentServers?.datos.nameServ = self.servName
        self.viewModel.getServers()
    }


    @IBAction func btnBusPan(_ sender: Any) {
        self.rowVC = alertaL
               //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
        dismiss(animated: true, completion: nil)
        presentPanModal(rowVC!)
        
        print("Busmen Panamá")
        self.servName = "busmenpa"
        ServersManager.currentServers?.datos.nameServ = self.servName
        self.viewModel.getServers()
    }
    
    @IBAction func btnTemMex(_ sender: Any) {
       
    }
    
    @IBAction func btnTemMex2(_ sender: Any) {
        self.rowVC = alertaL
               //  let rowVC: PanModalPresentable.LayoutType = AlertaHorarios()
        dismiss(animated: true, completion: nil)
        presentPanModal(rowVC!)
        
        print("Busmen Temsa")
        self.servName = "temsatransportes"
        ServersManager.currentServers?.datos.nameServ = self.servName
        self.viewModel.getServers()
    }
    
    @IBAction func btnBackInicio(_ sender: Any) {
        print("boton back ")
       // self.delegate1?.closeSession2()
        let alerta = UIAlertController(title: IdiomaSelect().seleccionIdioma(caso: "txt_SS"), message: IdiomaSelect().seleccionIdioma(caso: "txt_deCeSe"), preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_aceptar"), style: .default, handler: {(action) in
            ServersManager.currentServers?.datos.user = ""
            ServersManager.currentServers?.datos.pass = ""
            self.delegate?.closeSession2()
        })
        let guiaCancel = UIAlertAction(title: IdiomaSelect().seleccionIdioma(caso: "txt_cancelar"), style: .default, handler: {(action) in
                   })
        alerta.addAction(guiaOk)
        alerta.addAction(guiaCancel)
    
       self.present(alerta, animated:true, completion:nil)
        
       
    }
    
    func editVista(){
        self.scrollView.endEditing(true)
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
        scrollView.contentSize = CGSize(width: 0, height: 1000)
        spring1.layer.cornerRadius = 10
        spring2.layer.cornerRadius = 10
        spring3.layer.cornerRadius = 10
    }
    
    fileprivate func setupViewModel() {
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
                   self.rowVC?.dismiss(animated: true)

               }
        
        self.viewModel.didGetData = { data in
                   // update UI after get data
                     print(data.datos)
                     print(data.respuesta)
                     print(self.viewModel.count)
                     print(self.viewModel.selectedObject?.datos ?? AuthenticationModel.self)
            print("didGetData")
               }
        self.viewModel.didGetDataUser = { data, session in
            print("didGetDataUser")
                   print(data)
                   print(data)
            print("didGetDataUser")
            
            let userdata = UsuarioM(id: data.id!,
                                    name: data.name!,
                                    login: data.login!,
                                    email: data.email!,
                                    phone: data.phone!,
                                    readonly: data.readonly!,
                                    administrator: data.administrator!,
                                    map: data.map!,
                                    latitude: data.latitude!,
                                    longitude: data.longitude!,
                                    zoom: data.zoom!,
                                    twelveHourFormat: data.twelveHourFormat!,
                                    coordinateFormat: data.coordinateFormat!,
                                    disabled: data.disabled!,
                                    expirationTime: data.expirationTime ?? "",
                                    deviceLimit: data.deviceLimit!,
                                    userLimit: data.userLimit!,
                                    deviceReadonly: data.deviceReadonly!,
                                    token: data.token ?? "",
                                    limitCommands: data.limitCommands!,
                                    poiLayer: data.poiLayer!,
                                    sesionActiva: "",
                                    BasicAuthorization: self.base64LoginString )
            
            
            let sesion = SesionP(sesionUser: session, sesionAdmi: "")
            let mapa  = MapaM(id: "", clave: "", mapaM:"2")
            let user = User(respuesta: "correcto", datos: userdata, sesion: sesion, datosMapa: mapa)
            
            UserManager.currentUser = user
            
            let sesionData  = DatosS(sesionID: "")
            let sesEnvio = Sesion(datos: sesionData)
            SesionManager.currentSesion = sesEnvio
            
            let data = DataApp(GrupoSel: "Sin Información", idGrupoSel: 0, Seleccionadas: false)
            let datosenvio = Dataap(dataApp: data, dataUni: self.unidadesAux)
            
            DataManager.currentData = datosenvio
            
           // self.loadingView.hide()
            
                UserManager.currentUser?.datos.sesionActiva = "1"
            
            //self.vc.dismiss(animated: true, completion: nil)
            self.rowVC?.dismiss(animated: true)
            self.delegate?.ingresarBaseMain()
               }
        
        self.viewModel.didGetErrorLogin = { mensaje in
            self.rowVC?.dismiss(animated: true)

            let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
      /*  self.viewModel.selectIdioma = { idioma in
            print("idioma seleccionado ")
            let idiomax = IdiomaSelect().seleccionIdioma(caso: "txt_usuario")
            print("seleccion idioma ", idiomax)
            self.user_name.placeholder = IdiomaSelect().seleccionIdioma(caso: "txt_usuario")
            self.password.placeholder = IdiomaSelect().seleccionIdioma(caso: "txt_pass")
            self.LabelIdioma.text = IdiomaSelect().seleccionIdioma(caso: "esin")
            self.btnInicio.titleString = IdiomaSelect().seleccionIdioma(caso: "txt_iniciarsesion")
            self.LabelSesion.text = IdiomaSelect().seleccionIdioma(caso: "txt_seinicia")
           
        } */
        self.viewModel.didErrorServers = { datos in
            print("didErrorServers ", datos)
            self.rowVC?.dismiss(animated: true)
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
                                  print("URL bienvenida  ", s)
                              }
                          }
                    
                          if(s.clave == nam3){
                              if (s.url != self.se3) {
                                  print("Clave3 ", s.clave , "  nombre3  ", nam3)
                                  ServersManager.currentServers?.datos.socket = s.url
                                  self.se3 = s.url
                                  reiniciar = true
                        }
                    }
                }
              //  viewModel.loginService(usuario: user_name.text!, clave: password.text!)
            self.viewModel.loginService(usuario: self.user_name!, clave: self.password!)
                let username = self.user_name!
                let password = self.password!
                      let loginString = String(format: "%@:%@", username, password)
                      let loginData = loginString.data(using: String.Encoding.utf8)!
                self.base64LoginString = loginData.base64EncodedString()
        }
    }
}
