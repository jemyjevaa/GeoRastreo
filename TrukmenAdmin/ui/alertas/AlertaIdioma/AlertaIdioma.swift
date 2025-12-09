//
//  AlertaIdioma.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 30/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal
class AlertaIdioma: UIViewController {
    @IBOutlet weak var btnEspanol: GRButton!
    @IBOutlet weak var btnIngles: GRButton!
    
    var viewModel : AuthenticationViewModel?
   var viewControler : LoginView?
    
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
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnEspanol(_ sender: Any) {
        btnIngles.startColor = #colorLiteral(red: 0.02745098039, green: 0.2901960784, blue: 0.631372549, alpha: 1)
        btnIngles.endColor = #colorLiteral(red: 0.02745098039, green: 0.2901960784, blue: 0.631372549, alpha: 1)
        btnEspanol.startColor = #colorLiteral(red: 0.01960784314, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
        btnEspanol.endColor = #colorLiteral(red: 0.01960784314, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
        self.cargaIdioma(valor: "1")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnIngles(_ sender: Any) {
        btnIngles.startColor = #colorLiteral(red: 0.01960784314, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
        btnIngles.endColor = #colorLiteral(red: 0.01960784314, green: 0.07058823529, blue: 0.2352941176, alpha: 1)
        btnEspanol.startColor = #colorLiteral(red: 0.02745098039, green: 0.2901960784, blue: 0.631372549, alpha: 1)
        btnEspanol.endColor = #colorLiteral(red: 0.02745098039, green: 0.2901960784, blue: 0.631372549, alpha: 1)
        self.cargaIdioma(valor: "2")
        self.dismiss(animated: true, completion: nil)
    }
    
    func cargaIdioma(valor: String){
        let id = IdiomaM(idioma: valor)
               let idioma = Idioma(datos: id)
               IdiomaManager.currentIdioma = idioma
        self.viewModel?.selectIdioma?(id)
    }
}

extension AlertaIdioma: PanModalPresentable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    /* var longFormHeight: PanModalHeight {
     // return .maxHeightWithTopInset(200)
     return 200.0
     }*/
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}
