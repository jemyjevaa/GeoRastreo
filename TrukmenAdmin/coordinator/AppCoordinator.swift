//
//  AppCoordinator.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/25/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import UIKit

protocol CambiarFlujo {
    func changeflujo()
    func cerrarSesion()
    func goMenu()
}

class AppCoordinator: Coordinator, BackToBasemainViewControllerDelegate {
    func backCoordinator() {
    basemain()
    }
    
    var children: [Coordinator] = []
       var navigationController: UINavigationController
       private var window: UIWindow
       var isLoguuead = false
    var timerVerificarFueradeHoraio: Timer!
    public var rootViewController: UIViewController {
           return navigationController
       }
    
    init(in window: UIWindow) {
        self.children = []
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: true)
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    public func splashScreen(){
        splash()
    }
    func start() {
      /*  self.navegationStyle()
        
        //authentication()*/
        self.navegationStyle()
        splash()

                 print("appCoordinator -> ", UserManager.currentUser?.datos.sesionActiva)
        
             /*    if UserManager.currentUser != nil {
                   if(UserManager.currentUser?.datos.sesionActiva == "1"){
                       // do your stuff here
                    
                           basemain()
                       
                   }else{
                        authentication()
                       //basemain()
                   }
                         }else{
                              authentication()
                            // basemain()
                         }
        */
    }
    
    func basemain(){
           let baseMain = BasemainCoordinator(navigationController: navigationController)
           baseMain.appCoordinator = self
           children.append(baseMain)
           baseMain.start()
       }
    
    func authentication(){
        print("login coordinator")
             let loginCoordinator = LoginCoordinator(navigationController: navigationController)
       
        loginCoordinator.appCoordinator = self
        
        children.append(loginCoordinator)
        loginCoordinator.start()
       }
    
    func splash(){
        print("Splash ")
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.appCoordinator = self
        children.append(splashCoordinator)
        splashCoordinator.start()
    }
    
    func menuEmpresas(){
        print("menuempresas appcoordinator")
        let menu = MenuEmpresaCoordinator(navigationController: navigationController)
        menu.appCoordinator = self
        children.append(menu)
        menu.start()
       }
    
    func navegationStyle(){
           self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
           self.navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.2784313725, blue: 0.7294117647, alpha: 1)
           self.navigationController.navigationBar.backItem?.backBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      }
}

extension AppCoordinator:CambiarFlujo{
    func changeflujo() {
        children.removeLast()
        basemain()
    }
    
    func cerrarSesion(){
        children.removeLast()
        authentication()
       // splash()
    }
    func goMenu(){
        children.removeLast()
        menuEmpresas()
    }
}
