//
//  SesionManager.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 24/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent

struct SesionManager: SesionManagerType {
    typealias SesionType = Sesion
}

struct Sesion {
    var datos = DatosS()
}

extension Sesion: Serializable{
    init(dictionary: NSDictionary?) {
        datos <== (self, dictionary, "datos")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "datos") <== datos
        return dict
    }
}

extension Sesion: Equatable {
    static func == (l:Sesion, r:Sesion)-> Bool{
        return l.datos == r.datos
    }
}
struct DatosS {
    var sesionID: String = ""
}

extension DatosS: Equatable{
    static func == (l:DatosS, r: DatosS) -> Bool {
        return l.sesionID == r.sesionID
    }
}

extension DatosS: Serializable{
    init(dictionary: NSDictionary?) {
        sesionID <== (self, dictionary, "sesionID")
    }
    
     func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "sesionID") <== sesionID
        return dict
    }
}
