//
//  dataAppManager.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 27/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent

struct DataManager: DataManagerType {
    typealias DataType = Dataap
}

struct Dataap {
    var dataApp = DataApp()
    var dataUni = [DataUni]()
}

extension Dataap: Serializable{
    init(dictionary: NSDictionary?) {
        dataApp <== (self, dictionary, "dataApp")
        dataUni <== (self, dictionary, "dataUni")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "dataApp") <== dataApp
        (dict, "dataUni") <== dataUni
        return dict
    }
}

extension Dataap: Equatable {
    static func == (l:Dataap, r:Dataap)-> Bool{
        return l.dataApp == r.dataApp &&
        l.dataUni == r.dataUni
    }
}
struct DataApp {
    var GrupoSel: String = ""
    var idGrupoSel:Int = 0
    var Seleccionadas: Bool = false
}

extension DataApp: Equatable{
    static func == (l:DataApp, r: DataApp) -> Bool {
        return l.GrupoSel == r.GrupoSel &&
        l.idGrupoSel == r.idGrupoSel &&
        l.Seleccionadas == r.Seleccionadas
    }
}

extension DataApp: Serializable{
    init(dictionary: NSDictionary?) {
        GrupoSel <== (self, dictionary, "GrupoSel")
        idGrupoSel <== (self, dictionary, "idGrupoSel")
        Seleccionadas <== (self, dictionary, "Seleccionadas")
    }
    
     func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "GrupoSel") <== GrupoSel
         (dict, "idGrupoSel") <== idGrupoSel
         (dict, "Seleccionadas") <== Seleccionadas
        return dict
    }
}


/************************************/


struct DataUni {
    var IdUnidad: Int = 0
    var nameUnidad:String = ""
    var categoriaUnidad:String = ""
}

extension DataUni: Equatable{
    static func == (l:DataUni, r: DataUni) -> Bool {
        return l.IdUnidad == r.IdUnidad &&
        l.nameUnidad == r.nameUnidad &&
        l.categoriaUnidad == r.categoriaUnidad
    }
}

extension DataUni: Serializable{
    init(dictionary: NSDictionary?) {
        IdUnidad <== (self, dictionary, "IdUnidad")
        nameUnidad <== (self, dictionary, "nameUnidad")
        categoriaUnidad <== (self, dictionary, "categoriaUnidad")
    }
    
     func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "IdUnidad") <== IdUnidad
        (dict, "nameUnidad") <== nameUnidad
        (dict, "categoriaUnidad") <== categoriaUnidad
        return dict
    }
}
