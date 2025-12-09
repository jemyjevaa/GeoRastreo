//
//  SplashView.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 21/09/21.
//  Copyright © 2021 Adan Magaña. All rights reserved.
//

import UIKit
import Lottie

class SplashView: UIViewController {

    public weak var delegate : SplashViewDelegate?
 
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lottieAnimation()
          //  sleep(120)
           // gotoVista()
           /* let ser = Servidores(url1: "", url2: "", url3: "", socket: "")
            let serv = Servers(respuesta: "correcto", datos: ser)
            ServersManager.currentServers = serv */
          //  ServersManager.currentServers?.datos.url3
            
            do{
                var ss = ServersManager.currentServers?.datos.url1
                print("dorec rec", ss)
                print("dorec rec2")

                if(ss == nil){
                    print("voy agregar")
                    let ser = Servidores(url1: "", url2: "", url3: "", socket: "", nameServ: "")
                    let serv = Servers(respuesta: "correcto", datos: ser)
                    ServersManager.currentServers = serv
                }
            }catch{
                print("catch")
                let ser = Servidores(url1: "", url2: "", url3: "", socket: "")
                let serv = Servers(respuesta: "correcto", datos: ser)
                ServersManager.currentServers = serv
            }
    }

    func lottieAnimation(){
        // Commented out Lottie animation due to missing world_finder.json file
        /*
        let animationview = AnimationView(name: "world_finder")
        animationview.frame = CGRect(x: 0, y: 200, width: 300, height: 400)
        animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFit
        view.addSubview(animationview)
        animationview.play()
        animationview.loopMode = .loop
        */
        delayWithSeconds(5){
            print("delay ")
            self.gotoVista()
        }
     //   gotoVista()
    }
    
    func gotoVista() {
      //  self.vc.dismiss(animated: true, completion: nil)
        self.delegate?.gotoCoordinator()

    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
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
