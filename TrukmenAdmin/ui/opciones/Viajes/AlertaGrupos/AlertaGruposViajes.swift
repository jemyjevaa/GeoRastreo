//
//  AlertaGruposViajes.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 07/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal

class AlertaGruposViajes: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabledata: UITableView!
    
    var viewModel : ViajesViewModel?
       var viewControler : ViajesView?
       
       var searchController : UISearchController!
          var resultsController = UITableViewController()

          private var currentPage: Int!
          
            var grupoData = [ItemGrupo]()
            var grupoFilter = [ItemGrupo]()
            var ini = true
           var grupoSel = ""
           var idGrupo = 0
       var tipoVista = 0
          var searchActive : Bool = false
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabledata.delegate = self
                            tabledata.dataSource = self
                            searchBar.delegate = self
                    
                  
                   /* let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                           view.addGestureRecognizer(tap)*/
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
    @objc func dismissKeyboard() {
               //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
               view.endEditing(true)
           }
}


extension AlertaGruposViajes: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return grupoData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Index path ",indexPath.row)
    let cell = Bundle.main.loadNibNamed("CellsGruposViajes", owner: self, options: nil)?.first as! CellsGruposViajes
  

        cell.grupoName.text = grupoData[indexPath.row].name
 
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 75
}
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           let cell = tableView.cellForRow(at: indexPath) as! CellsGruposViajes
        view.endEditing(true)
        /*   cell.card.backgroundColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.startColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.endColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           */
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               // your code here
               self.viewModel?.grupoSeleccionada = self.grupoData[indexPath.row]
               self.dismiss(animated: true, completion: nil)
               print("tableView select ", self.grupoData[indexPath.row].name )
           }
       }
    
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if(searchText == ""){
        searchActive = false
        grupoData = grupoFilter
    }else{
        
        searchActive = true
        print("textoSearch ", searchText)
     
            grupoData = grupoFilter.filter({ (text) -> Bool in
                      let tmp: NSString = text.name as! NSString
                      print("textoTemp ", tmp)

                      let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                      return range.location != NSNotFound
                  })
        
      
       /*  for route in rutasData {
            print("ruta nombre ",route.nombre)
            if route.nombre.lowercased().contains(searchText.lowercased()){
                print("coincidencia ",route)
                rutasFilter.append(route)
            }
        }*/
    }
    print("filtroRuta ", grupoFilter)
    self.tabledata.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Cierra el teclado
            // Realiza las acciones adicionales que desees
        }
}

extension AlertaGruposViajes: PanModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return tabledata
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(400)
    }

    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }

    
    var anchorModalToLongForm: Bool {
        return false
    }
}
