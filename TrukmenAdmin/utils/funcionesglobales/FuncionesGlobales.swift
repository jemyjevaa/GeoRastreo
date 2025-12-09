//
//  FuncionesGlobales.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/30/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import UIKit
import Foundation

struct FuncionesGlobales {
    func scaleIphone8(tamO : CGFloat, heightView: CGFloat) -> CGFloat {
           
           let a = (tamO * heightView) / 627
           
           return a
       }
       
       
       func scaleIphoneX(tamO : CGFloat, heightView: CGFloat ) -> CGFloat {
           
           let a = (tamO * heightView) / 812
           
           return a
       }
       
       
       func scaleIphoneXWindth(tamO : CGFloat, widthView: CGFloat ) -> CGFloat {
           
           let a = (tamO * widthView) / 375
           
           return a
       }

}
