//
//  UnidadesGeneralCells.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class UnidadesGeneralCells: UITableViewCell {
    @IBOutlet weak var iconoItem: UIImageView!
    @IBOutlet weak var tituloUnidad: UILabel!
    

    override func awakeFromNib(){
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }

}
