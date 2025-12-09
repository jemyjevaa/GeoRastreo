//
//  EventosViewDelegate.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

public protocol EventosViewDelegate: class {
    func Back()
}

class EventosCoordinator: Coordinator{
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
            
            print("EventosViewStoryboard")
            let vc = UIStoryboard(name: "EventosViewStoryboard", bundle: nil)
                .instantiateViewController(withIdentifier: "EventosViewStoryboard") as! EventosViewStoryboard
            vc.delegate = self
            self.navigationController.pushViewController(vc, animated: true)
            
         /*     guard let topViewController = navigationController.topViewController else {
                      return navigationController.setViewControllers([vc], animated: false)
                  }
                  
                  //simple animation function
                  vc.view.frame = topViewController.view.frame
                  UIView.transition(from:topViewController.view, to: vc.view, duration: 0.50, options: .transitionCrossDissolve) {[unowned self] (_) in
                      self.navigationController.setViewControllers([vc], animated: false)
                  } */
           }
}

extension EventosCoordinator: EventosViewDelegate{
    func Back() {
        delegateBasemain?.backCoordinator()
    }
}
