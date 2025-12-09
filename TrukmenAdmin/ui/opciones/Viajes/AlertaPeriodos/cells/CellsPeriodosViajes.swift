//
//  CellsPeriodosViajes.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 07/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class CellsPeriodosViajes: UITableViewCell {
    @IBOutlet weak var iconoItem: UIImageView!
    @IBOutlet weak var tituloPeriodo: UILabel!
    
    
    override func awakeFromNib(){
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }

}
