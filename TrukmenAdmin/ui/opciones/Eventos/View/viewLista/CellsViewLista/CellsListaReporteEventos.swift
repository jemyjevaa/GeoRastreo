//
//  CellsListaReporteEventos.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 05/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class CellsListaReporteEventos: UITableViewCell {
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var unidadName: UILabel!
    @IBOutlet weak var horaName: UILabel!
    
    override func awakeFromNib(){
                 super.awakeFromNib()
                 // Initialization code
             }
          
          override func setSelected(_ selected: Bool, animated: Bool) {
               super.setSelected(selected, animated: animated)
               // Configure the view for the selected state
           }

}
