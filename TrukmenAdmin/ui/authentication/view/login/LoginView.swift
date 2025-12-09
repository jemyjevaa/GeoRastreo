//
//  LoginView.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/25/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal
import Spring
import FSnapChatLoading
import WOWCheckbox
import LGButton
import Lottie
import SwiftUI
//typealias UserType = UserModel

class LoginView: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var springPass: SpringView!
    @IBOutlet weak var springUser: SpringView!
    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var seleccionIdioma: UIButton!
    @IBOutlet weak var btnInicio: LGButton!
    @IBOutlet weak var btnchek: WOWCheckbox!
    @IBOutlet weak var LabelIdioma: UILabel!
    @IBOutlet weak var LabelSesion: UILabel!
    @IBOutlet weak var versionName: UILabel!
    @IBOutlet weak var btnMostrar: LGButton!
    @IBOutlet weak var imgMostrarPass: UIImageView!
    
    var viewModel = AuthenticationViewModel()
    var base64LoginString = ""
  public weak var delegate: BackToFirstViewControllerDelegate?
    let loadingView = FSnapChatLoadingView()
    var unidadesAux = [DataUni]()
    var servers : ItemServidores?
    
    var se1 =   ServersManager.currentServers?.datos.url1
    var se2 =   ServersManager.currentServers?.datos.url2
    var se3 =   ServersManager.currentServers?.datos.socket
    var tipoServicio = 0
    var servName = ""
    var verpass = false
    let alertaL: AlertaLoading = AlertaLoading()
    var animation = AnimationView()
    var rowVC: PanModalPresentable.LayoutType?
    var tipoGeovoy = false
    @State private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        print("loginview")
        self.setupUIControls()
        self.bordesTextField()
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
        let version = nsObject as! String
        versionName.text = "Versión: "+version;
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
               //Descomentar, si el tap no debe interferir o cancelar otras acciones
               //tap.cancelsTouchesInView = false
               view.addGestureRecognizer(tap)
    }
    
    @IBAction func btnLogin(_ sender: Any){
        print("boton login")
        if(user_name.text!.isEmpty){
            let alert = UIAlertController(title: "Falta Campo", message: "Campo usuario requerido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            if(password.text!.isEmpty){
                let alert = UIAlertController(title: "Campo", message: "Campo contraseña requerido", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{
                loadingView.setColorBackground(color: .clear)
                loadingView.setBackgroundBlurEffect()
                loadingView.show(view: view, color: UIColor.green)
               // viewModel.loginService(usuario: user_name.text!, clave: password.text!)
                var user = user_name.text?.split(separator: "@")
                var us2 = user![1].split(separator: ".")
                print("tamaño " , us2.count)
            }
        }
    }
    
    @IBAction func btnSend(_ sender: Any) {
    print("boton send")
        if(user_name.text!.isEmpty){
            let alert = UIAlertController(title: "Falta Campo", message: "Campo usuario requerido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            if(password.text!.isEmpty){
                let alert = UIAlertController(title: "Campo", message: "Campo contraseña requerido", preferredStyle: .alert)
                          alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                          self.present(alert, animated: true)
            }else{
                var user = user_name.text?.split(separator: "@")
                print("tamaño arreglo ", user?.count)
                self.tipoServicio = 1
                if(user!.count > 1){
                    var us2 = user![1].split(separator: ".")
                    print("tamaño " , us2.count)
                    print("resultado1 ", user![1])
                    print("resultado2 ", us2.count)
                    
                    if(user![1] == "geovoy.com"){
                        ServersManager.currentServers?.datos.user = user_name.text!
                        ServersManager.currentServers?.datos.pass = password.text!
                        self.tipoGeovoy = true
                        self.servName = "busmen"
                        self.viewModel.getServers()
                    }
                    else if(user![1] == "escarh-busmen.com"){
                          self.rowVC = alertaL
                           dismiss(animated: true, completion: nil)
                           presentPanModal(rowVC!)
                        self.servName = "busmen"
                        ServersManager.currentServers?.datos.nameServ = self.servName
                        self.viewModel.getServers()
                    }else if(us2.count > 2){
                        self.rowVC = alertaL
                         dismiss(animated: true, completion: nil)
                         presentPanModal(rowVC!)
                        self.servName = us2[0] + "" + us2[2]
                        ServersManager.currentServers?.datos.nameServ = self.servName
                        self.viewModel.getServers()
                    }else {
                         self.rowVC = alertaL
                         dismiss(animated: true, completion: nil)
                         presentPanModal(rowVC!)
                        self.servName = us2[0] + ""
                        ServersManager.currentServers?.datos.nameServ = self.servName
                        self.viewModel.getServers()
                    }
                }else{
                     self.rowVC = alertaL
                     dismiss(animated: true, completion: nil)
                     presentPanModal(rowVC!)
                    self.servName = "busmen"
                    ServersManager.currentServers?.datos.nameServ = self.servName
                    self.viewModel.getServers()
                }
                /*viewModel.loginService(usuario: user_name.text!, clave: password.text!)
                let username = user_name.text!
                      let password = password.text!
                      let loginString = String(format: "%@:%@", username, password)
                      let loginData = loginString.data(using: String.Encoding.utf8)!
                self.base64LoginString = loginData.base64EncodedString()*/
            }
        }
    }
    
    @IBAction func btnIdioma(_ sender: Any) {
        let vc: AlertaIdioma = AlertaIdioma()
        vc.viewModel = self.viewModel
        let rowVC: PanModalPresentable.LayoutType = vc
        dismiss(animated: true, completion: nil)
        presentPanModal(rowVC)
    }
    
    @IBAction func btnMostrarPass(_ sender: Any) {
        print("btnMostrarPAss")
        switch(verpass){
        case false:
            password.isSecureTextEntry = false
            verpass = true
            self.imgMostrarPass.image =  #imageLiteral(resourceName: "ocultar")
            break
        case true:
            password.isSecureTextEntry = true
            verpass = false
            self.imgMostrarPass.image =  #imageLiteral(resourceName: "ver")
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupUIControls(){
        print(self.view.frame.height)
        print(UIScreen.main.bounds.height)
        
        user_name.delegate = self
        password.delegate = self

        self.scrollview.endEditing(true)
        scrollview.contentInset = .zero
        scrollview.scrollIndicatorInsets = .zero
        scrollview.contentSize = CGSize(width: 0, height: 1000)
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
            if(self.tipoGeovoy == false ){
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
                
                //self.loadingView.hide()
                
                if(self.btnchek.isChecked == true){
                    UserManager.currentUser?.datos.sesionActiva = "1"
                }else{
                    UserManager.currentUser?.datos.sesionActiva = "0"
                }
                //self.vc.dismiss(animated: true, completion: nil)
                self.rowVC?.dismiss(animated: true)
                
                self.delegate?.ingresarBaseMain()
            }else {
                self.delegate?.goMenu()
            }
               }
        
        self.viewModel.didGetErrorLogin = { mensaje in
            print("didGetErrorLogin")
            self.loadingView.hide()
            self.rowVC?.dismiss(animated: true)
            let alert = UIAlertController(title: "Alerta", message: "Verifique su usuario y contraseña sean correctos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        self.viewModel.selectIdioma = { idioma in
            print("idioma seleccionado ")
            let idiomax = IdiomaSelect().seleccionIdioma(caso: "txt_usuario")
            print("seleccion idioma ", idiomax)
            self.user_name.placeholder = IdiomaSelect().seleccionIdioma(caso: "txt_usuario")
            self.password.placeholder = IdiomaSelect().seleccionIdioma(caso: "txt_pass")
            self.LabelIdioma.text = IdiomaSelect().seleccionIdioma(caso: "esin")
            self.btnInicio.titleString = IdiomaSelect().seleccionIdioma(caso: "txt_iniciarsesion")
            self.LabelSesion.text = IdiomaSelect().seleccionIdioma(caso: "txt_seinicia")
           
        }
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
               self.viewModel.loginService(usuario: self.user_name.text!, clave: self.password.text!)
                let username = self.user_name.text!
                let password = self.password.text!
                      let loginString = String(format: "%@:%@", username, password)
                      let loginData = loginString.data(using: String.Encoding.utf8)!
                self.base64LoginString = loginData.base64EncodedString()
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
             let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
             let keyboardSize = keyboardInfo.cgRectValue.size
             var keyboh = 0.0
             if let keybo = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
                 keyboh = Double(keybo.height)
                 print(keyboh)
                 let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(keyboh + 16.0), right: 0)
                 scrollview.contentInset = contentInsets
                 scrollview.scrollIndicatorInsets = contentInsets
             }
    }
    @objc func keyboardWillHide(_ notification: Notification){
        scrollview.contentInset = .zero
              scrollview.scrollIndicatorInsets = .zero
    }
    
    func bordesTextField(){
        springUser.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.5725490196, blue: 0, alpha: 1)
        springUser.layer.borderWidth = 2.0
        springUser.layer.cornerRadius = 7
        
        springPass.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.5725490196, blue: 0, alpha: 1)
        springPass.layer.borderWidth = 2.0
        springPass.layer.cornerRadius = 7
        
       /* seleccionIdioma.layer.borderColor =  #colorLiteral(red: 0.01960784314, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
        seleccionIdioma.layer.borderWidth = 1.0
        seleccionIdioma.layer.cornerRadius = 5 */
    }
    @objc func dismissKeyboard() {
           //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
           view.endEditing(true)
       }
}
extension LoginView:  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
     //   placeholderLabel.isHidden = !textView.text.isEmpty
    //    self.lblPlaceholder.isHidden = !textView.text.isEmpty
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if(text == "\n") {
               textView.resignFirstResponder()
               return false
           }
           return true
       }
    
    //03 textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
      return true;
    }


    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      //dispose of any resources that can be recreated
    }
}
