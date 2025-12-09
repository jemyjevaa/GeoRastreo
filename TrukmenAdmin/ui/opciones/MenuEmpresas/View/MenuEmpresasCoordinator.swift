//
//  MenuEmpresasCoordinator.swift
//  TrukmenAdmin
//
//  Created by Desarrollo Movil on 07/06/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import UIKit
public protocol MenuEmpresaViewDelegate: class {
    func navigateToNextPage()
    func ingresarBaseMain()
    func closeSession2()
}

class MenuEmpresaCoordinator: Coordinator, BackToFirstViewControllerDelegate {
    func goMenu() {
        children.removeLast()
    }
    
  
   var children: [Coordinator] = []
         var navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
         var appCoordinator: CambiarFlujo?
         
         required init(navigationController: UINavigationController) {
             self.navigationController = navigationController
         }
         
     
     func start() {
         let vc : MenuEmpresasView = MenuEmpresasView()
         vc.delegate = self
         vc.delegate1 = self
         self.navigationController.viewControllers = [vc]
        print("logincoordinator")
     }
    }
    


extension MenuEmpresaCoordinator: MenuEmpresaViewDelegate{
    func navigateToNextPage() {
        appCoordinator?.cerrarSesion()
    }
    
    func navigateBackToFirstPage(newOrderCoordinator: LoginCoordinator) {
          navigationController.popToRootViewController(animated: true)
          children.removeLast()
      }
      
      func ingresarBaseMain() {
        appCoordinator?.changeflujo()
    }
    func closeSession(){
        appCoordinator?.cerrarSesion()
    }
    func closeSession2(){
        print("closeseion 2")
        appCoordinator?.cerrarSesion()
    }
}
