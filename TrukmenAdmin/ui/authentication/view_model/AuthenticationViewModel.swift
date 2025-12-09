//
//  AuthenticationViewModel.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/30/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation
import PanModal

class AuthenticationViewModel{
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private let service: AuthenticationServiceProtocol
    private var model: [AuthenticationModel] = [AuthenticationModel]() {
           didSet {
            self.count = self.model.count
           }
       }
    private var modelUser: Usuario?

    /// Count your data in model
    var count: Int = 0

    //MARK: -- Network checking

       /// Define networkStatus for check network connection
       var networkStatus = Reach().connectionStatus()

       /// Define boolean for internet status, call when network disconnected
       var isDisconnected: Bool = false {
           didSet {
           
               self.internetConnectionStatus?()
           }
       }
    //MARK: -- UI Status

       /// Update the loading status, use HUD or Activity Indicator UI
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
    
    var idiomaSeleccionado: IdiomaM? {
          didSet {
              self.selectIdioma?(idiomaSeleccionado!)
              print("idioma seleccionado")
          }
      }
       /// Define selected model
       var selectedObject: AuthenticationModel?
       var selectedIdUser: String?
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: ((AuthenticationModel) -> ())?
    var didGetDataUser: ((Usuario, String) -> ())?
    var didGetErrorLogin:((String) -> ())?
    var selectIdioma:((IdiomaM) ->())?
    var didGetServers: ((ItemServidores) ->())?
    var didErrorServers: ((ItemErrorServers) -> ())?
    
    init(withAuthentication serviceProtocol: AuthenticationServiceProtocol = AuthenticationService()) {
           self.service = serviceProtocol
           NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
           Reach().monitorReachabilityChanges()
       }
    //MARK: Internet monitor status
      @objc func networkStatusChanged(_ notification: Notification) {
          self.networkStatus = Reach().connectionStatus()
          exampleBind()
      }
    
    func loginService(usuario: String, clave: String){
           switch networkStatus {
           case .offline:
               self.isDisconnected = true
               self.internetConnectionStatus?()
           case .online:
               // call your service here
               self.service.loginService(usuario: usuario, password: clave, success: { (data, session) in
                   print("login ",data)
                        self.isLoading = false
                        self.modelUser = data
                        print(data)
                   self.didGetDataUser?(data, session)
               }) { (error) in
                   self.alertMessage = "ERROR"
                   print("error login ")
                   self.didGetErrorLogin?("Error de sesión")
               }
           default:
               break
           }
       }
    
    func getServers(){
        print("getServersAVM: ")
        switch networkStatus {
                 case .offline:
                     self.isDisconnected = true
                     self.internetConnectionStatus?()
                 case .online:
                     // call your service here
            self.service.getServers(success: { (sesion) in
                             
                                  self.isLoading = false
                                //  self.modelSocket = data
                                  print("servers ", sesion)
                                 self.didGetServers?(sesion)
                         }) { (error) in
                            // self.alertMessage = [error.datos, error.respuesta]
                             self.didErrorServers?(error)
                         }
                 default:
                     break
                 }
    }
    
    func exampleBind() {
           switch networkStatus {
           case .offline:
               self.isDisconnected = true
               self.internetConnectionStatus?()
           case .online:
               // call your service here
               
               self.service.removeThisFuncName(success: { (data) in
                   self.isLoading = false
                   self.model = [data]
                   self.selectedObject = data
                   print(data.respuesta)
                   self.didGetData?(data)
               }) {
                   /*
                    if errorCode == 0 {
                    self.serverErrorStatus?()
                    } else {
                    self.isLoading = false
                    self.alertMessage = errorMsg
                    }
                    */
                   self.alertMessage = "ERROR"
                   
                   
               }
               
               
               /*
                self.service.removeThisFuncName(success: { data in
                
                self.isLoading = false
                // self.model = data
                self.didGetData?()
                
                })
                { errorMsg, errorCode in
                if errorCode == 0 {
                self.serverErrorStatus?()
                } else {
                self.isLoading = false
                self.alertMessage = errorMsg
                }
                }
                */
               
               
           default:
               break
           }
       }
}
extension AuthenticationViewModel {

}
