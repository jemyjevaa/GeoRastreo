//
//  AlertShowExt.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 28/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertaGeneral(message: String, descMsg: String, actions: [String: () -> Void]?) {
        
        print("mensaje ", message, " descripcion ", descMsg )
        let alertVC = AlertaGeneral.init(nibName: "AlertaGeneral", bundle: nil)
        alertVC.txtTitulo.text = "hola da"
      
       /* alertVC.message = message
        alertVC.actionDic = actions
        alertVC.descriptionMessage = descMsg
        alertVC.imageItem = itemimage*/
        //Present
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalTransitionStyle = .coverVertical
       // alertVC.modalPresentationStyle = .overCurrentContext
        self.present(alertVC, animated: true, completion: nil)
    }
}
