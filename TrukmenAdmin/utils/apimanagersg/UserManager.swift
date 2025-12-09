//
//  UserManager.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 4/1/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//


import Foundation
import Serpent

struct UserManager: UserManagerType {
    typealias UserType = User
}

struct User {
    var respuesta = ""
    var datos = UsuarioM()
    var sesion = SesionP()
    var datosMapa = MapaM()
}

extension User: Serializable {
    init(dictionary: NSDictionary?) {
        datos    <== (self, dictionary, "datos")
        respuesta   <== (self, dictionary, "respuesta")
        sesion  <== (self, dictionary, "sesion")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "datos")    <== datos
        (dict, "respuesta")   <== respuesta
        (dict, "sesion")   <== sesion
        return dict
    }
}

extension User: Equatable {
    static func ==(l:User, r:User) -> Bool {
        return l.datos == r.datos &&
            l.respuesta == r.respuesta &&
            l.sesion == l.sesion
    }
}

struct UsuarioM {
    var id: Int = 0
    var name: String = ""
    var login: String = ""
    var email: String = ""
    var phone: String = ""
    var readonly: Bool = false
    var administrator: Bool = false
    var map: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var zoom: Int = 0
    var twelveHourFormat: Bool = false
    var coordinateFormat: String = ""
    var disabled: Bool = false
    var expirationTime: String = ""
    var deviceLimit: Int = 0
    var userLimit: Int = 0
    var deviceReadonly: Bool = false
    var token: String = ""
    var limitCommands: Bool = false
    var poiLayer: String = ""
    var sesionActiva:String = ""
    var BasicAuthorization:String = ""
}

extension UsuarioM: Equatable {
    static func ==(l: UsuarioM, r: UsuarioM) -> Bool {
        return l.id == r.id &&
        l.name == r.name &&
        l.login == r.login &&
        l.email == r.email &&
        l.phone == r.phone &&
        l.readonly == r.readonly &&
        l.administrator == r.administrator &&
        l.map == r.map &&
        l.latitude == r.latitude &&
        l.longitude == r.longitude &&
        l.zoom == r.zoom &&
        l.twelveHourFormat == r.twelveHourFormat &&
        l.coordinateFormat == r.coordinateFormat &&
        l.disabled == r.disabled &&
        l.expirationTime == r.expirationTime &&
        l.deviceLimit == r.deviceLimit &&
        l.userLimit == r.userLimit &&
        l.deviceReadonly == r.deviceReadonly &&
        l.token == r.token &&
        l.limitCommands == r.limitCommands &&
        l.poiLayer == r.poiLayer &&
        l.sesionActiva == r.sesionActiva &&
        l.BasicAuthorization == r.BasicAuthorization
    }
}

extension UsuarioM: Serializable {
    init(dictionary: NSDictionary?) {
        id <== (self, dictionary, "id")
        name <== (self, dictionary, "name")
        login <== (self, dictionary, "login")
        email <== (self, dictionary, "email")
        phone <== (self, dictionary, "phone")
        readonly <== (self, dictionary, "readonly")
        administrator <== (self, dictionary, "administrator")
        map <== (self, dictionary, "map")
        latitude <== (self, dictionary, "latitud")
        longitude <== (self, dictionary, "longitude")
        zoom <== (self, dictionary, "zoom")
        twelveHourFormat <== (self, dictionary, "twelveHourFormat")
        coordinateFormat <== (self, dictionary, "coordinateFormat")
        disabled <== (self, dictionary, "disabled")
        expirationTime <== (self, dictionary, "expirationTime")
        deviceLimit <== (self, dictionary, "deviceLimit")
        userLimit <== (self, dictionary, "userLimit")
        deviceReadonly <== (self, dictionary, "deviceReadonly")
        token <== (self, dictionary, "token")
        limitCommands <== (self, dictionary, "limitCommands")
        poiLayer <== (self, dictionary, "poiLayer")
        sesionActiva   <== (self, dictionary, "sesionActiva")
        BasicAuthorization <== (self, dictionary, "BasicAuthorization")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id" )    <== id
        (dict, "name" )    <== name
        (dict, "login" )    <== login
        (dict, "email" )    <== email
        (dict, "phone" )    <== phone
        (dict, "readonly" )    <== readonly
        (dict, "administrator" )    <== administrator
        (dict, "map" )    <== map
        (dict, "latitude" )    <== latitude
        (dict, "longitude" )    <== longitude
        (dict, "zoom" )    <== zoom
        (dict, "twelveHourFormat" )    <== twelveHourFormat
        (dict, "coordinateFormat" )    <== coordinateFormat
        (dict, "disabled" )    <== disabled
        (dict, "expirationTime" )    <== expirationTime
        (dict, "deviceLimit" )    <== deviceLimit
        (dict, "userLimit" )    <== userLimit
        (dict, "deviceReadonly" )    <== deviceReadonly
        (dict, "token" )    <== token
        (dict, "limitCommands" )    <== limitCommands
        (dict, "poiLayer" )    <== poiLayer
        (dict, "sesionActiva")     <== sesionActiva
        (dict, "BasicAuthorization") <== BasicAuthorization
        return dict
        }
    }


struct SesionP {
    var sesionUser: String = ""
    var sesionAdmi: String = ""

}

extension SesionP: Equatable {
    static func ==(l: SesionP, r: SesionP) -> Bool {
        return l.sesionUser == r.sesionUser &&
        l.sesionAdmi == r.sesionAdmi
    }
}

extension SesionP: Serializable {
    init(dictionary: NSDictionary?) {
        sesionUser <== (self, dictionary, "sesionUser")
        sesionAdmi <== (self, dictionary, "sesionAdmi")
        
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "sesionUser" )    <== sesionUser
        (dict, "sesionAdmi" )    <== sesionAdmi
        return dict
    }
}

struct MapaM{
    var id: String=""
    var clave: String=""
    var mapaM: String=""
}
extension MapaM:Equatable{
    static func ==(l:MapaM, r:MapaM)-> Bool{
        return l.id == r.id &&
            l.clave == r.clave &&
            l.mapaM == r.mapaM
    }
}
extension MapaM: Serializable{
    init (dictionary: NSDictionary?){
    id <== (self, dictionary, "id")
    clave <== (self, dictionary,"clave")
    mapaM <== (self, dictionary, "mapaM")
    }
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id") <== id
        (dict, "clave") <== clave
        (dict, "mapaM") <== mapaM
        return dict
    }
}
