//
//  SplashCoordinator.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 23/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import UIKit
public protocol SplashViewDelegate: class {
   func gotoCoordinator()
}

class SplashCoordinator: Coordinator, BackToBasemainViewControllerDelegate{
    func backCoordinator() {
        basemain()
    }
    
    var children: [Coordinator] = []
          var navigationController: UINavigationController
          var appCoordinator: CambiarFlujo?
          var window: UIWindow?
          required init(navigationController: UINavigationController) {
              self.navigationController = navigationController
          }
    func start() {
        let vc : SplashView = SplashView()
        vc.delegate = self
        self.navigationController.viewControllers = [vc]
    }
    
    func basemain(){
           let baseMain = BasemainCoordinator(navigationController: navigationController)
           baseMain.appCoordinator = self
           children.append(baseMain)
           baseMain.start()
       }

    func authentication(){
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.appCoordinator = self
        
        children.append(loginCoordinator)
        loginCoordinator.start()
       }
    

    func menuEmpresas(){
        print("menuempresas splascoordinator")
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

extension SplashCoordinator: SplashViewDelegate{
    func gotoCoordinator() {
        self.navegationStyle()
          print("appCoordinator splash ", UserManager.currentUser?.datos.sesionActiva)
          if UserManager.currentUser != nil {
            if(UserManager.currentUser?.datos.sesionActiva == "1"){
                // do your stuff here
                basemain()
            }else if(UserManager.currentUser?.datos.sesionActiva == "3"){
                menuEmpresas()
            } else {
                authentication()
            }
                }else{
                authentication()
        }
    }
}

extension SplashCoordinator: CambiarFlujo{
    func changeflujo() {
        children.removeLast()
        basemain()
    }
    
    func cerrarSesion(){
        children.removeLast()
        //authentication()
        start()
    }
    
    func goMenu(){
        children.removeLast()
        menuEmpresas()
    }
}
