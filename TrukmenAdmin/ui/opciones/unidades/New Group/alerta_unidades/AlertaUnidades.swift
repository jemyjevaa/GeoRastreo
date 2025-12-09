//
//  AlertaUnidades.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 11/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal
import SwiftUI

class AlertaUnidades: UIViewController {
    @IBOutlet weak var txtUnidadesSel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnTodas: UIButton!
    @IBOutlet weak var btnGrupos: UIButton!
    @IBOutlet weak var viewUnidadesSel: UIView!
    
    @IBOutlet weak var tabledata: UITableView!
    var viewModel : InicioViewModel?
    var viewControler : InicioViewController?
    
    var searchController : UISearchController!
       var resultsController = UITableViewController()

       private var currentPage: Int!
       
         var unidadesData = [ItemUnidades]()
         var unidadesFilter = [ItemUnidades]()
         var grupoData = [ItemGrupo]()
         var grupoFilter = [ItemGrupo]()
         var unidadesSelect = [ItemUnidades]()
         var ini = true
        var grupoSel = ""
        var idGrupo = 0
    var tipoVista = 0
       var searchActive : Bool = false
    var unidadesAux = [DataUni]()
 private var searchText = ""
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
        tabledata.delegate = self
        tabledata.dataSource = self
        searchBar.delegate = self
        txtUnidadesSel.layer.cornerRadius = 7
        viewUnidadesSel.layer.cornerRadius = 7
        btnTodas.layer.cornerRadius = 7
        btnGrupos.layer.cornerRadius = 7
        print("Unidades data ", self.unidadesData)
       // let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
       // view.addGestureRecognizer(tap)
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
    
    @IBAction func btnTab(_ sender: UIButton) {
        print("btn Tab ", sender.tag)
        
        
        if ini == false{
             ini = true
         }
         else{
             self.unidadesSelect.removeAll()
             if sender.tag-1 == 0{ // frecuentes
                print("Todas")
                 self.unidadesData = unidadesFilter
                 self.tipoVista = 0
                 self.tabledata.reloadData()
             }
             else if sender.tag-1 == 1 { // en tiempo
                print("grupos")
                 self.grupoData = grupoFilter
                 self.tipoVista = 1
                 self.tabledata.reloadData()
             }
         }
         resetTabBarForTag(tag: sender.tag-1)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        print("Boton Done ")
         if(self.tipoVista == 1){
            DataManager.currentData?.dataApp.idGrupoSel = idGrupo
            DataManager.currentData?.dataApp.GrupoSel = grupoSel
         }else {
            DataManager.currentData?.dataApp.idGrupoSel = 0
            DataManager.currentData?.dataApp.GrupoSel = "Ninguno"
         }
        DataManager.currentData?.dataApp.Seleccionadas = true
        
        self.unidadesSelect.forEach{ unidad in
            print("unidad vuelta ")
            let datoenvio = DataUni(IdUnidad: unidad.id!, nameUnidad: unidad.name!, categoriaUnidad: unidad.category!)
            self.unidadesAux.append(datoenvio)
        }
        DataManager.currentData?.dataUni = self.unidadesAux
        
        self.viewModel?.unidadesSeleccionadas = self.unidadesSelect
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func selectedButton(btn: UIButton) {
             print("selectedBoton ",btn)
              btn.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: UIControl.State.normal)
             btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
             
             UIView.animate(withDuration: 0.3) {
                 self.view.layoutIfNeeded()
             }
         }
         
         private func unSelectedButton(btn: UIButton) {
             btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
             
             btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
           print("unselectedButton ")
         }
       
       private func resetTabBarForTag(tag: Int) {
             print("resetTabBar ",tag)

             var sender: UIButton!
             
             if(tag == 0) {
                 searchActive = false
                 sender = btnTodas
             }
             else if(tag == 1) {
                 
                 searchActive = false
                 sender = btnGrupos
             }
         
             
             currentPage = tag
             unSelectedButton(btn: btnTodas)
             unSelectedButton(btn: btnGrupos)
             selectedButton(btn: sender)
             
         }
    @objc func dismissKeyboard() {
           //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
           view.endEditing(true)
       }

}



extension AlertaUnidades: PanModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        //return tabledata
        return nil
    }
    
   /* var longFormHeight: PanModalHeight {
       // return .maxHeightWithTopInset(200)
         return 200.0
    }*/
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(UIScreen.main.bounds.height)
    }

    
    var anchorModalToLongForm: Bool {
        return false
    }
}




extension AlertaUnidades: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    var entero = 0
    switch(self.tipoVista){
    case 0:
        entero = unidadesData.count
        break
    case 1:
        entero = grupoData.count
        break
    default:
        print(" SWitch ")
        break
    }
    return entero
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Index path ",indexPath.row)
    let cell = Bundle.main.loadNibNamed("AlertaUnidadCells", owner: self, options: nil)?.first as! AlertaUnidadCells
  
    switch(self.tipoVista){
    case 0:
        cell.tituloRuta.text = unidadesData[indexPath.row].name
        break
    case 1:
        cell.tituloRuta.text = grupoData[indexPath.row].name
        break
    default:
        print(" SWitch ")
        break
    }
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! AlertaUnidadCells
    view.endEditing(true)
   // cell.card.backgroundColor = UIColor(hexString: "#e6FFFFFF")
    cell.backgroundColor = UIColor(hexString: "#e62D572C")
    /*   cell.card.startColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
    cell.card.endColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
    */
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        // your code here
       // self.viewModel?.guardarRutaFrecuente(clave: self.rutasData[indexPath.row].clave)
     /*   self.viewModel?.alertMessage = "ok pan"
        if(self.tipoVista == 0){
            self.viewModel?.unidadSeleccionada = self.unidadesData[indexPath.row]
        }else if(self.tipoVista == 1){
            self.viewModel?.grupoSeleccionada = self.grupoData[indexPath.row]
        }
     
        self.dismiss(animated: true, completion: nil)
        print("tableView " )*/
        if(self.tipoVista == 0){
            let hasDuplicates = containsDuplicates(array: self.unidadesSelect)
            let cosa = returnDuplicates(array: self.unidadesSelect, dato: self.unidadesData[indexPath.row])
            print("resultado duplicado ", cosa)
            if(cosa == false){
                self.unidadesSelect.append(self.unidadesData[indexPath.row])
                if(self.txtUnidadesSel.text == ""){
                    self.txtUnidadesSel.text =  self.unidadesData[indexPath.row].name!
                }else{
                    self.txtUnidadesSel.text = self.txtUnidadesSel.text! + " , " + self.unidadesData[indexPath.row].name!
                }
                print("unidades seleccionadas ", self.unidadesSelect)
            }else{
                returnClean(array: self.unidadesSelect, dato: self.unidadesData[indexPath.row])
                self.txtUnidadesSel.text = ""
                for n in self.unidadesSelect {
                    if(self.txtUnidadesSel.text == ""){
                        self.txtUnidadesSel.text = n.name
                    }else {
                        self.txtUnidadesSel.text = self.txtUnidadesSel.text! + ", " + n.name!
                    }
                }
                cell.backgroundColor = UIColor(hexString: "#e6061B61")
            }
        }else if(self.tipoVista == 1){
            self.unidadesSelect.removeAll()
            self.unidadesSelect  = self.unidadesFilter.filter({ (text) -> Bool in
                text.groupId == self.grupoData[indexPath.row].id
            })
            self.grupoSel = self.grupoData[indexPath.row].name!
            self.idGrupo = self.grupoData[indexPath.row].id!
            print("grupo seleccionado ", self.grupoData[indexPath.row].id)
        }
    }
    
    func containsDuplicates(array: [ItemUnidades]) -> Bool {
        for (index, person) in array.enumerated() {
            for i in (index + 1)..<array.count {
                if person.name == array[i].name && person.id == array[i].id {
                    return true
                }
            }
        }
        return false
    }
    
    func containsDuplicates(array: [ItemUnidades], dato: ItemUnidades) -> Bool {
        for (index, person) in array.enumerated() {
            for i in (index + 1)..<array.count {
                if person.name == array[i].name && person.id == array[i].id {
                    return true
                }
            }
        }
        return false
    }
    
    func returnDuplicates(array: [ItemUnidades], dato: ItemUnidades) -> Bool {
        let resultado  = array.filter { $0 == dato }
        print("resultado resultado ", resultado)
        if(resultado.isEmpty){
            return false
        }else {
            return true
        }
    }
    func returnClean(array: [ItemUnidades], dato: ItemUnidades) -> Bool {
        let resultado  = array.filter { $0 != dato }
        print("resultado clean ", resultado)
        self.unidadesSelect.removeAll()
        self.unidadesSelect = resultado
        if(resultado.isEmpty){
            return false
        }else {
            return true
        }
    }
}

  
    
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if(searchText == ""){
        searchActive = false
     //   rutasFilter = rutasData
    }else{
        
        searchActive = true
        print("textoSearch ", searchText)
        if(self.tipoVista == 0){
            unidadesData = unidadesFilter.filter({ (text) -> Bool in
                      let tmp: NSString = text.name as! NSString
                      print("textoTemp ", tmp)

                      let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                      return range.location != NSNotFound
                  })
        } else if (self.tipoVista == 1){
            grupoData = grupoFilter.filter({ (text) -> Bool in
                                 let tmp: NSString = text.name as! NSString
                                 print("textoTemp 2", tmp)

                                 let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                                 return range.location != NSNotFound
                             })
        }
      
       /*  for route in rutasData {
            print("ruta nombre ",route.nombre)
            if route.nombre.lowercased().contains(searchText.lowercased()){
                print("coincidencia ",route)
                rutasFilter.append(route)
            }
        }*/
    }
    print("filtroRuta ", unidadesFilter)
    self.tabledata.reloadData()
}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder() // Cierra el teclado
           // Realiza las acciones adicionales que desees
       }
}


/*extension Array {
   mutating func removeObject<T : Equatable>(object: T, array: [T]) {
      if let index = find(array, object){
            self.removeAtIndex(index)
        }
    }
}*/
