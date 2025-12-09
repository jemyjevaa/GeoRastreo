//
//  AlertaPeriodoEventos.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 05/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal
class AlertaPeriodoEventos: UIViewController {
    @IBOutlet weak var tabledata: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel : EventosViewModel?
          var viewControler : EventosViewStoryboard?
          
          var searchController : UISearchController!
             var resultsController = UITableViewController()

             private var currentPage: Int!
             
               var periodoData = [Periodo]()
               var periodoFilter = [Periodo]()
               var ini = true
              var grupoSel = ""
              var idGrupo = 0
          var tipoVista = 0
             var searchActive : Bool = false
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tabledata.delegate = self
        tabledata.dataSource = self
        searchBar.delegate = self
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
}

extension AlertaPeriodoEventos: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return periodoData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Index path ",indexPath.row)
    let cell = Bundle.main.loadNibNamed("CellsPeriodosViajes", owner: self, options: nil)?.first as! CellsPeriodosViajes
  

        cell.tituloPeriodo.text = periodoData[indexPath.row].periodo
 
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 75
}
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           let cell = tableView.cellForRow(at: indexPath) as! CellsPeriodosViajes
        view.endEditing(true)
        /*   cell.card.backgroundColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.startColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           cell.card.endColor = UIColor(hexString: "#e6\((    FuncionesGlobales().deleteCodeColor2(code2:(UserManager.currentUser?.datosEmpresa.color2)!)))")
           */
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
               // your code here
               self.viewModel?.periodoSeleccionada = self.periodoData[indexPath.row]
               self.dismiss(animated: true, completion: nil)
               print("tableView select ", self.periodoData[indexPath.row].periodo )
           }
       }
    
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if(searchText == ""){
        searchActive = false
     //   rutasFilter = rutasData
    }else{
        
        searchActive = true
        print("textoSearch ", searchText)
     
            periodoData = periodoFilter.filter({ (text) -> Bool in
                      let tmp: NSString = text.periodo as! NSString
                      print("textoTemp ", tmp)

                      let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                      return range.location != NSNotFound
                  })
    }
    print("filtroRuta ", periodoFilter)
    self.tabledata.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Cierra el teclado
            // Realiza las acciones adicionales que desees
        }
}

extension AlertaPeriodoEventos: PanModalPresentable {

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
