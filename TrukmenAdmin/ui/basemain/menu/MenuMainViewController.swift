//
//  MenuMainViewController.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import LGButton
import Spring

class MenuMainViewController: UIViewController{
    @IBOutlet weak var btnSalir: LGButton!
    @IBOutlet weak var btnMenuEmpresa: LGButton!
    @IBOutlet weak var viewViajes: SpringView!
    @IBOutlet weak var viewEventos: SpringView!
    @IBOutlet weak var viewCentroSoporte: SpringView!
    @IBOutlet weak var btnReportes: LGButton!
    @IBOutlet weak var versionName: UILabel!
    @IBOutlet weak var usuarioName: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var menuV = false
    
    override func viewDidLoad() {
          super.viewDidLoad()
          print("Menu MAin View ")
        setupConfig()
        if(menuV == true){
                    animacionMenu(opcion: "2")
                }
    }
    
    @IBAction func btnReportes(_ sender: Any) {
        print("Boton informacion")
              switch(menuV){
              case false:
                  animacionMenu(opcion: "1")
                  menuV = true
                  btnReportes.rightImageSrc = #imageLiteral(resourceName: "flechaBack")
                  break
              case true:
                  animacionMenu(opcion: "2")
                  menuV = false
                  btnReportes.rightImageSrc = #imageLiteral(resourceName: "flecha")
                  break
              default: break
              }
    }
    @IBAction func btnEventos(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
                      InicioViewController.openEventos()
    }
    
    @IBAction func btnViajes(_ sender: Any) {
        
        self.dismiss(animated:true, completion:nil)
              InicioViewController.openViajes()
    }
    
    @IBAction func btnCentro(_ sender: Any) {
        InicioViewController.call()
    }
    
    
    @IBAction func btnSalir(_ sender: Any) {
        print("BtnCerrarSesion")
             self.dismiss(animated: true, completion: nil)
              
              InicioViewController.closeSesion()
    }
    
    @IBAction func btnMenuEmpresas(_ sender: Any) {
        print("BtnMenuEmpresas")
             self.dismiss(animated: true, completion: nil)
        InicioViewController.returnMenu()
    }
    
    
    func setupConfig(){
           self.scrollView.endEditing(true)
           scrollView.contentInset = .zero
           scrollView.scrollIndicatorInsets = .zero
           scrollView.contentSize = CGSize(width: 0, height: 1000)
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject?
        let version = nsObject as! String
                versionName.text = "Versión: "+version;
        
        let nombreC = UserManager.currentUser?.datos.name
               var name=""
               if nombreC != nil {
                   name = String(describing: nombreC!)
               }
        
        usuarioName.text = name
        let uss = ServersManager.currentServers?.datos.user
        print("user result ", uss)
        if(uss == ""){
            btnMenuEmpresa.isHidden = true
        }
       }
    
    func animacionMenu(opcion: String){
            switch(opcion){
            case "1":
                viewViajes.isHidden = false
                viewEventos.isHidden = false
                
                
                viewCentroSoporte.transform =  self.viewCentroSoporte.transform.translatedBy( x: 0.0, y: 100.0)
                viewViajes.autostart = true
                viewViajes.animation = "slideUp"
                viewViajes.delay = 0.2
                viewViajes.duration = 1
                
                viewEventos.autostart = true
                viewEventos.animation = "slideUp"
                viewEventos.delay = 0.4
                viewEventos.duration = 1.3
                
                break
            case "2":
                viewViajes.isHidden = true
                viewEventos.isHidden = true
                
                viewCentroSoporte.transform =  self.viewCentroSoporte.transform.translatedBy( x: 0.0, y: -100.0)
                
                break
            default: break
                
            }
        }
}
