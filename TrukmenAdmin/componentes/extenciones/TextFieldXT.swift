//
//  TextFieldTX.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 28/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import Spring

extension UITextField{
    
    
    func borde(){
        self.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
    }
    
    func bordewhite(){
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}
