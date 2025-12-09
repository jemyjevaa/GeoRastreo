//
//  IdiomaManager.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 19/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent

struct IdiomaManager: IdiomaManagerType{
    typealias IdiomaType = Idioma
}

struct Idioma {
    var datos = IdiomaM()
}

extension Idioma: Serializable{
    init(dictionary: NSDictionary?) {
        datos <== (self, dictionary, "datos")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "datos") <== datos
        return dict
    }
}

extension Idioma: Equatable {
    static func == (l:Idioma, r:Idioma) -> Bool {
        return l.datos == r.datos
    }
}

struct IdiomaM {
    var idioma: String = "1"
}
extension IdiomaM: Equatable{
    static func == (l:IdiomaM, r:IdiomaM) -> Bool {
        l.idioma == r.idioma
    }
}

extension IdiomaM: Serializable {
    init(dictionary: NSDictionary?){
        idioma <== (self, dictionary, "idioma")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "idioma") <== idioma
        return dict
    }
}
