//
//  listaReporte.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 09/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit
import MarqueeLabel
class ListaReporteController: UIViewController{
    @IBOutlet weak var titleReporte: UILabel!
    @IBOutlet weak var subtitleReporte: MarqueeLabel!
    @IBOutlet weak var btnBack: GRButton!
    
    @IBOutlet weak var tabledata: UITableView!
    
    public weak var delegate: ViajesViewDelegate?
    
    var viewModel = ViajesViewModel()
    
    var tripsData = [ItemViajes]()
               var tripsFilter = [ItemViajes]()
    var marcadores : Bool?
    var unity : ItemUnidades!
    var grupo: ItemGrupo!
    override func viewDidLoad() {
    super.viewDidLoad()
    print("reporte view main")
        print("marcadores ",marcadores!)
        tabledata.delegate = self
        tabledata.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        CargaDatosInicial()
    }
    
    override func viewWillAppear(_ animated: Bool){
           super.viewWillAppear(animated)
      //  self.navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
     //  self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        print("boton back ")
        self.navigationController?.popViewController(animated: true)
    }
    
    func CargaDatosInicial(){
        if(self.grupo != nil){
            self.subtitleReporte.text = "Grupo: " + self.grupo.name!
        }else {
            self.subtitleReporte.text = "Unidad: " + unity.name!
        }
    }
}



extension ListaReporteController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return tripsData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Index path ",indexPath.row)
    let cell = Bundle.main.loadNibNamed("CellsListaReporteViaje", owner: self, options: nil)?.first as! CellsListaReporteViaje
    let distancia = tripsData[indexPath.row].distance! / 1000
    
    var f1 =  tripsData[indexPath.row].startTime!.split(separator: ".")
    var f2 = tripsData[indexPath.row].endTime!.split(separator: ".")
    let di : String = String(format: "%.2f", distancia)
    
    cell.unidadName.text = tripsData[indexPath.row].deviceName
    cell.inicioName.text = "Fecha Inicio: " + convertDateFormatter(date: String(f1[0]))
    cell.finName.text = "Fecha Fin: " + convertDateFormatter(date: String(f2[0]))
    cell.distanciaName.text = "Distancia: " + String(di) + " Km/h"
 
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 81
}
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           let cell = tableView.cellForRow(at: indexPath) as! CellsListaReporteViaje
       
        /*   cell.card.backgroundColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.startColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.endColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           */
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               // your code here
               self.viewModel.tripSeleccionada = self.tripsData[indexPath.row]
               self.dismiss(animated: true, completion: nil)
               print("tableView select ", self.tripsData[indexPath.row].deviceName )
               
               let vcn = UIStoryboard(name: "MapaViajesStoryboard", bundle: nil)
                     .instantiateViewController(withIdentifier: "MapaViajesStoryboard") as! MapaViajesStoryboard
            vcn.delegate = self.delegate
            vcn.viewModel = self.viewModel
            vcn.tripData = self.tripsData[indexPath.row]
            vcn.marcadores = self.marcadores!
          //  vcn.tripsFilter = trips
            
                 self.navigationController?.pushViewController(vcn,animated: true)
           }
       }
    func convertDateFormatter(date: String) -> String {
        print("fecha ",date )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "es_ES")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "EEEE dd MMM yyyy HH:mm:ss"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "GMT-6") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
}
