//
//  ViajesCoordinator.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 06/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
public protocol ViajesViewDelegate: class {
    func Back()
   
}

class ViajesCoordinator: Coordinator {
   var children: [Coordinator] = []
         var navigationController: UINavigationController
         var delegateBasemain: BackToBasemainViewControllerDelegate?
    
          init(navigationController: UINavigationController) {
            children = []
            
             self.navigationController = navigationController
         }
         
     
     func start() {
         
      /* let vc : ViajesView = ViajesView()
       vc.delegate = self
        
       self.navigationController.pushViewController(vc, animated: true)
        print("Viajescoordinator")*/
         
         print("ViajesViewStoryboard")
         let vc = UIStoryboard(name: "ViajesViewStoryboard", bundle: nil)
             .instantiateViewController(withIdentifier: "ViajesViewStoryboard") as! ViajesViewStoryboard
         vc.delegate = self
         
         self.navigationController.pushViewController(vc, animated: true)
        /*  guard let topViewController = navigationController.topViewController else {
                   return navigationController.setViewControllers([vc], animated: false)
               }
               
               //simple animation function
               vc.view.frame = topViewController.view.frame
               UIView.transition(from:topViewController.view, to: vc.view, duration: 0.50, options: .transitionCrossDissolve) {[unowned self] (_) in
                   self.navigationController.setViewControllers([vc], animated: false)
               }*/
        }
    }
    


extension ViajesCoordinator: ViajesViewDelegate{
    func Back() {
        delegateBasemain?.backCoordinator()
    }
    
}
