//
//  IdiomaComandos.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 05/07/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit

public class IdiomaComandos {
    
    var dato = ""
   var idioma = ""
       
       func seleccionIdiomaComandos(caso: String) -> String {
       
           if(IdiomaManager.currentIdioma != nil){
               idioma = IdiomaManager.currentIdioma!.datos.idioma
           }else{
               idioma = "1"
           }
       //case "txt_enviar": dato = "ENVÍAR"
           
           if(idioma == "1"){
               switch caso {
                case "deviceOverspeed" : dato = "Exceso de Velocidad"
                case "deviceOnline" : dato = "En línea"
                case "deviceOffline" : dato = "Fuera de línea"
                case "commandResult" : dato = "Resultado Comando"
                case "deviceStopped" : dato = "Se ha Detenido"
                case "ignitionOn" : dato = "Encendido ON"
                case "ignitionOff" : dato = "Encendido OFF"
                case "deviceMoving" : dato = "En Movimiento"
                case "geofenceExit" : dato = "Ha salido de la Geocerca"
                case "geofenceEnter" : dato = "Ha entrado en la Geocerca"
                case "alarm" : dato = "Alarma"
               default:
                   dato = "Sin información"
               }
           }else{
               switch caso {
                case "deviceOverspeed": dato = "Speed limit exceeded"
                case "deviceOnline": dato = "Status online"
                case "deviceOffline": dato = "Status offline"
                case "commandResult": dato = "Command result"
                case "deviceStopped": dato = "Device stopped"
                case "ignitionOn": dato = "Ignition ON"
                case "ignitionOff": dato = "Ignition OFF"
                case "deviceMoving": dato = "Device moving"
                case "geofenceExit": dato = "Geofence exited"
                case "geofenceEnter": dato = "Geofence entered"
                case "alarm" : dato = "Alarm"
               default:
                   dato = "Sin información"
               }
           }
         
           return dato
       }
}
