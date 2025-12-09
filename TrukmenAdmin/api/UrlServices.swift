//
//  UrlServices.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/30/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation

struct API {
    static var baseUrl = ServersManager.currentServers?.datos.url1 // "https://rastreogps.geovoy.com/"
  //  static let baseUrl2 = "https://geovoy.com/"
    static var baseUrl3 = ServersManager.currentServers?.datos.url3
    static var baseUrl4 = ServersManager.currentServers?.datos.url2 //"https://rastreogps.geovoy.com:4000/"
    static var baseUrlServers = "https://status.geovoy.com/"

}

protocol Endpoint {
    var path: String{get}
}

enum Endpoints {
    enum Posts: Endpoint {
        //Servicios
        case validarusuario
        case sesionGps
        case getDevices
        case getGroups
        case devices
        case posicions
        case eventLectoras
        case ApiName
        case getPeriodos
        case searchTrips
        case route
        case events
        case datosServers
        public var path: String {
            switch self
            {
            case .validarusuario: return "api/session"
            case .sesionGps: return "api/session"
            case .getDevices: return "api/devices"
            case .getGroups: return "api/groups"
            case .devices: return "api/devices"
            case .posicions: return "api/positions"
            case .eventLectoras: return "api/eventoslectoraconteo"
            case .ApiName: return "api/eventoslectoraconteo"
            case .getPeriodos: return "api/periodos"
            case .searchTrips: return "api/reports/trips"
            case .route: return "api/reports/route"
            case .events: return "api/reports/events"
            case .datosServers: return "api/datosservidores"
            }
        }
    }
}
