//
//  AlertaUnidadCells.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 11/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class AlertaUnidadCells: UITableViewCell {

    @IBOutlet weak var iconoItem: UIImageView!
    
    @IBOutlet weak var tituloRuta: UILabel!
    
    override func awakeFromNib(){
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: false)
         // Configure the view for the selected state
     }
}
