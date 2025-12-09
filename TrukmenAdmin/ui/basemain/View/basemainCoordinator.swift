//
//  basemainCoordinator.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 29/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import UIKit

protocol BasemainDelegate: class{
    func closeSession()
    func openViajes()
    func openEventos()
    func goMenu()
}
protocol BackToBasemainViewControllerDelegate: class {
    func backCoordinator()
}
class BasemainCoordinator:Coordinator, BackToFirstViewControllerDelegate {
    func closeSession2() {
        print("closesession basemain cooordinator")
    }
    
   
    func navigateBackToFirstPage(newOrderCoordinator: LoginCoordinator) {
        
    }
    
    func ingresarBaseMain() {
        
    }
    
    var children: [Coordinator]
    var navigationController: UINavigationController
    var appCoordinator: CambiarFlujo?
    
    init(navigationController: UINavigationController) {
        children = []
        self.navigationController = navigationController
    }
    func start() {
      print("BaseMainCoordinator")
      let vc = UIStoryboard(name: "basemain", bundle: nil)
          .instantiateViewController(withIdentifier: "InicioViewController") as! InicioViewController
      vc.delegate = self
      
        guard let topViewController = navigationController.topViewController else {
                return navigationController.setViewControllers([vc], animated: false)
            }
            
            //simple animation function
            vc.view.frame = topViewController.view.frame
            UIView.transition(from:topViewController.view, to: vc.view, duration: 0.50, options: .transitionCrossDissolve) {[unowned self] (_) in
                self.navigationController.setViewControllers([vc], animated: false)
            }
  }
    
    func menu(){
        let vc : MenuEmpresasView = MenuEmpresasView()
        vc.delegate = self
        self.navigationController.viewControllers = [vc]
       print("menucoordinator")
    }
}

extension BasemainCoordinator: BasemainDelegate{
    func openViajes() {
        let viajes = ViajesCoordinator(navigationController: navigationController)
                viajes.delegateBasemain = self
                children.append(viajes)
                viajes.start()
    }
    
    func openEventos() {
        let eventos = EventosCoordinator(navigationController: navigationController)
        eventos.delegateBasemain = self
        children.append(eventos)
        eventos.start()
    }
    func closeSession() {
        appCoordinator?.cerrarSesion()
    }
    func goMenu() {
        print("gomenu basemaincoordinator")
           // children.removeLast()
        appCoordinator?.goMenu()
        }
   }

extension BasemainCoordinator: BackToBasemainViewControllerDelegate{
    func backCoordinator()  {
        print("Back basemain")
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.popToRootViewController(animated: true)
        children.removeLast()
    }
}
