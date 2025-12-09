//
//  LoginCoordinator.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/25/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import UIKit
public protocol LoginViewDelegate: class {
    func navigateToNextPage()
    func ingresarBaseMain()
}
protocol BackToFirstViewControllerDelegate: class {
    func navigateBackToFirstPage(newOrderCoordinator: LoginCoordinator)
    func ingresarBaseMain()
    func goMenu()
    func closeSession2()
}

class LoginCoordinator: Coordinator, BackToFirstViewControllerDelegate {
   var children: [Coordinator] = []
         var navigationController: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
         var appCoordinator: CambiarFlujo?
         
         required init(navigationController: UINavigationController) {
             self.navigationController = navigationController
         }
         
     func start() {
         let vc : LoginView = LoginView()
         vc.delegate = self
         self.navigationController.viewControllers = [vc]
        print("logincoordinator")
     }
    
    func menu(){
        let vc : MenuEmpresasView = MenuEmpresasView()
        vc.delegate = self
        self.navigationController.viewControllers = [vc]
       print("menucoordinator")
    }
    }

extension LoginCoordinator: LoginViewDelegate{
    func navigateToNextPage() {
        children.removeLast()
        //menu()
    }
    
    func navigateBackToFirstPage(newOrderCoordinator: LoginCoordinator) {
          navigationController.popToRootViewController(animated: true)
          children.removeLast()
      }
      
      func ingresarBaseMain() {
        appCoordinator?.changeflujo()
    }
    
    func goMenu() {
       // children.removeLast()
        menu()
    }
    func loginV(){
        
    }
    func closeSession2() {
        start()
    }
    }
