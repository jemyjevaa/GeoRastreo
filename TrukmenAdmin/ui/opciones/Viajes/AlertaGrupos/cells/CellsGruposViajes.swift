//
//  CellsGruposViajes.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 08/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class CellsGruposViajes: UITableViewCell {
    @IBOutlet weak var itemGrupo: UIImageView!
    @IBOutlet weak var grupoName: UILabel!
    
    
    override func awakeFromNib(){
              super.awakeFromNib()
              // Initialization code
          }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
}
