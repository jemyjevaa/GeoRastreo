//
//  AlertaLoading.swift
//  TrukmenAdmin
//
//  Created by Desarrollo Movil on 16/06/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import UIKit
import Lottie
import PanModal
class AlertaLoading: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 1. Set animation content mode
               
               animationView.contentMode = .scaleAspectFit
               
               // 2. Set animation loop mode
               
               animationView.loopMode = .loop
               
               // 3. Adjust animation speed
               
               animationView.animationSpeed = 0.5
               
               // 4. Play animation
               animationView.play()
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

extension AlertaLoading: PanModalPresentable {
    
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
        return .contentHeight(2000)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }

}
