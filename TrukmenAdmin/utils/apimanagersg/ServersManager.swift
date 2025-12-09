//
//  ServersManager.swift
//  TrukmenAdmin
//
//  Created by Desarrollo Movil on 11/04/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent

struct ServersManager: ServersManagerType {
    typealias ServersType = Servers
}

struct Servers {
    var respuesta = ""
    var datos = Servidores()
}

extension Servers: Serializable {
    init(dictionary: NSDictionary?) {
        respuesta    <== (self, dictionary, "respuesta")
        datos    <== (self, dictionary, "datos")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "respuesta") <== respuesta
        (dict, "datos")    <== datos
        return dict
    }
}

extension Servers: Equatable {
    static func ==(l:Servers, r:Servers) -> Bool {
        return l.datos == r.datos &&
        l.respuesta == r.respuesta
    }
}

struct Servidores {
    var url1: String = ""
    var url2: String = ""
    var url3: String = ""
    var socket: String = ""
    var nameServ: String = ""
    var user: String = ""
    var pass: String = ""
}

extension Servidores: Equatable {
    static func ==(l: Servidores, r: Servidores) -> Bool {
        return l.url1 == r.url1 &&
        l.url2 == r.url2 &&
        l.url3 == r.url3 &&
        l.socket == r.socket &&
        l.nameServ == r.nameServ &&
        l.user == r.user &&
        l.pass == r.pass
    }
}

extension Servidores: Serializable {
    init(dictionary: NSDictionary?) {
        url1 <== (self, dictionary, "url1")
        url2 <== (self, dictionary, "url2")
        url3 <== (self, dictionary, "url3")
        socket <== (self, dictionary, "socket")
        nameServ <== (self, dictionary, "nameServ")
        user <== (self, dictionary, "user")
        pass <== (self, dictionary, "pass")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "url1" )    <== url1
        (dict, "url2" )    <== url2
        (dict, "url3" )    <== url3
        (dict, "socket" )  <== socket
        (dict, "nameServ") <== nameServ
        (dict, "user") <== user
        (dict, "pass") <== pass
        return dict
        }
    }
