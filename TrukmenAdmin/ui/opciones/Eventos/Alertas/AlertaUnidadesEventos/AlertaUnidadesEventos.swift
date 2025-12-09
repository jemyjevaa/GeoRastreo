//
//  AlertaUnidadesEventos.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 05/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import UIKit
import PanModal

class AlertaUnidadesEventos: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    static var vc = AlertaUnidadesEventos()
    var unidadesData = [ItemUnidades]()
    var unidadesFilter = [ItemUnidades]()
    var viewModel : EventosViewModel?
    var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("AlertaUnidadesEventos viewDidLoad")
        print("Unidades Data Count: \(self.unidadesData.count)")
        if self.collectionView == nil {
            print("ERROR: collectionView is NIL")
        } else {
            print("collectionView is connected")
        }
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CellAlertaUnidadEventos", bundle: Bundle.main), forCellWithReuseIdentifier: "CellAlertaUnidadEventos")
        
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

extension AlertaUnidadesEventos: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.unidadesData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("MAnual cellss")
       //     let cell = Bundle.main.loadNibNamed("ManualCollectionViewCell", owner: self, options: nil)?.first as! ManualCollectionViewCell
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellAlertaUnidadEventos", for: indexPath) as! CellAlertaUnidadEventos
           
        cell.nombreUnidad.text = self.unidadesData[indexPath.row].name
        
            return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     print("UnidadSeleccionada")
         view.endEditing(true)
         self.viewModel?.unidadSeleccionada = self.unidadesData[indexPath.row]
         self.dismiss(animated: true, completion: nil)
         print("tableView select ", self.unidadesData[indexPath.row].name )
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
           /*  for route in rutasData {
                print("ruta nombre ",route.nombre)
                if route.nombre.lowercased().contains(searchText.lowercased()){
                    print("coincidencia ",route)
                    rutasFilter.append(route)
                }
            }*/
        }
        print("filtroRuta ", unidadesFilter)
        self.collectionView.reloadData()
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Cierra el teclado
            // Realiza las acciones adicionales que desees
        }
}

extension AlertaUnidadesEventos: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 80)
    }
}

extension AlertaUnidadesEventos: PanModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? {
        return collectionView
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
