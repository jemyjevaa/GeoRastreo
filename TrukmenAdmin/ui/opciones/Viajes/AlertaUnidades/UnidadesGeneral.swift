//
//  UnidadesGeneral.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 04/06/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal

class UnidadesGeneral: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabledata: UITableView!
    
    var viewModel : ViajesViewModel?
    var viewControler : ViajesView?
    
    var searchController : UISearchController!
       var resultsController = UITableViewController()

       private var currentPage: Int!
       
         var unidadesData = [ItemUnidades]()
         var unidadesFilter = [ItemUnidades]()
         var ini = true
        var grupoSel = ""
        var idGrupo = 0
    var tipoVista = 0
       var searchActive : Bool = false
    var unidadesAux = [DataUni]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("cantidad unidades ",self.unidadesData.count)
        tabledata.delegate = self
                     tabledata.dataSource = self
                     searchBar.delegate = self
             
           
           /*  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
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

extension UnidadesGeneral: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return unidadesData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Index path ",indexPath.row)
    let cell = Bundle.main.loadNibNamed("UnidadesGeneralCells", owner: self, options: nil)?.first as! UnidadesGeneralCells
  

        cell.tituloUnidad.text = unidadesData[indexPath.row].name
 
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 75
}
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           let cell = tableView.cellForRow(at: indexPath) as! UnidadesGeneralCells
        view.endEditing(true)
        /*   cell.card.backgroundColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.startColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.endColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           */
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               // your code here
               self.viewModel?.unidadSeleccionada = self.unidadesData[indexPath.row]
               self.dismiss(animated: true, completion: nil)
               print("tableView select ", self.unidadesData[indexPath.row].name )
           }
       }
    
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if(searchText == ""){
        searchActive = false
        unidadesData = unidadesFilter
    }else{
        searchActive = true
        print("textoSearch ", searchText)
     
            unidadesData = unidadesFilter.filter({ (text) -> Bool in
                      let tmp: NSString = text.name as! NSString
                      print("textoTemp ", tmp)

                      let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                      return range.location != NSNotFound
                  })
    }
    print("filtroRuta ", unidadesFilter)
    self.tabledata.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Cierra el teclado
            // Realiza las acciones adicionales que desees
        }
}

extension UnidadesGeneral: PanModalPresentable {

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
