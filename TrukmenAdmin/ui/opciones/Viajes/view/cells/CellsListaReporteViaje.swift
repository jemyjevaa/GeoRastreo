//
//  CellsListaReporteViaje.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 10/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class CellsListaReporteViaje: UITableViewCell {
    @IBOutlet weak var unidadName: UILabel!
    @IBOutlet weak var inicioName: UILabel!
    @IBOutlet weak var finName: UILabel!
    @IBOutlet weak var distanciaName: UILabel!
    
    
    override func awakeFromNib(){
              super.awakeFromNib()
              // Initialization code
          }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }

}
