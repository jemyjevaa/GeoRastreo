//
//  ViajesNewView.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 09/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit

class ViajesNewView: UIViewController {
    var unidades  = [ItemUnidades]()
    var periodos  = [Periodo]()
    var grupos    = [ItemGrupo]()
    var viewModel = ViajesViewModel()
    var group : ItemGrupo!
    var unity : ItemUnidades!
    var period : Periodo!
    var base64LoginString = ""
       var idUsuario = 0
       public weak var delegate: ViajesViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
