//
//  IdiomaSelect.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 19/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import UIKit


public class IdiomaSelect {
      var dato = ""
var idioma = ""
    
    func seleccionIdioma(caso: String) -> String {
    
        if(IdiomaManager.currentIdioma != nil){
            idioma = IdiomaManager.currentIdioma!.datos.idioma
        }else{
            idioma = "1"
        }

        if(idioma == "1"){
            print("idioma español")
            switch caso {
            case "txt_enviar":
                dato = "ENVÍAR"
            case "txt_usuario":
                dato  = "Usuario"
            case "txt_pass":
                dato = "Contraseña"
            case  "txt_selectiodima":
                dato = "Seleccionar idioma"
            case  "txt_olvidar":
                dato = "Recuperar Contraseña"
            case "txt_iniciarsesion":
                dato = "Iniciar sesión"
            case "txt_registrar":
                dato = "¿No tienes cuenta?, "
            case "txt_registrar2":
                dato = "Registrate"
            case "txt_idempresa":
                dato = "Id Empresa"
            case "txt_espanol":
                dato = "Español"
            case  "txt_ingles":
                dato = "Ingles"
            case "txt_nombre":
                dato = "Nombre Completo"
            case "txt_correo":
                dato = "Correo"
            case "txt_horario":
                dato = "Horario"
            case "txt_selectruta":
                dato = "Seleccionar Ruta"
            case "txt_notificaciones":
                dato = "Notificaciones"
            case "txt_promociones":
                dato = "Promociones"
            case "txt_perfil":
                dato = "Perfil"
            case "cerrar_sesion":
                dato = "Cerrar Sesión"
            case "punto_partida":
                dato = "Punto de Partida"
            case "punto_final":
                dato = "Punto Final"
            case "txt_objetosperdidos":
                dato = "Objetos Perdidos/Encontrados"
            case "txt_cambiarpass":
                dato = "Cambiar Contraseña"
            case "txt_telefonollamar":
                dato = "LLAMAR A CENTRO DE CONTROL"
            case "txt_elobjeto":
                dato = "El objeto fue:"
            case "txt_selecthorario":
                dato = "Seleccionar Horario"
            case "txt_itineario":
                dato = "Itinerario"
            case "txt_version":
                dato = "Versión 2.0"
            case "txt_objeto":
                dato = "Objecto"
            case "txt_telefono":
                dato = "Teléfono"
            case "txt_route":
                dato = "Ruta"
            case "txt_perdido":
                dato = "Perdido"
            case "txt_encontrado":
                dato = "Encontrado"
            case "txt_turno":
                dato = "Turno"
            case "txt_nuevacontrasena":
                dato = "Nueva ccontraseña"
            case "txt_guardar":
                dato = "GUARDAR"
            case "txt_olvidar2":
                dato = "RECUPERAR"
            case "txt_error_indi":
                dato = "Verifique su usuario o contraseña sean correctas"
            case "txt_alert":
                dato = "Alerta"
            case "txt_aceptar":
                dato = "Aceptar"
            case "txt_cancelar":
                dato = "Cancelar"
            case "exito":
                dato = "Exito!!"
            case "enviocorrecto":
                dato = "Sus datos fuerón envíados correctamente, pronto le daremos respuesta"
            case "enviocorrecto2":
                dato = "Sus datos de recuperación fuerón recibídos, de favor verifique su email"
            case "txt_select":
                dato = "Empresa"
            case "txt_alert_incorrect":
                dato = "Acceso incorrecto"
            case "txt_cerrar":
                dato = "Cerrar"
            case "txt_error":
                dato = "Lo sentimos, algo salió mal, intente más tarde de favor"
            case "actua_correc":
                dato = "Actualización correcta"
            case "actua_incorrec":
                dato = "Actualización incorrecta"
            case "unidad":
                dato = "Unidad"
            case "grupo":
                dato =  "Grupo"
            case "periodo":
                dato = "Periodo"
            case "busca":
                dato = "Buscar"
            case "deviceOffline":
                dato = "Fuera de Línea"
            case "datosIncompletos":
                dato = "Datos de Reporte Incompletos"
            case "txt_fueraH":
                dato = "Fuera de Horario"
            case "txt_DesTi":
                dato = "Ruta no Seleccionada, Fuera de Horario    "
            case "txt_activa":
                dato = "Ruta Activa"
            case "txt_NoHorario":
                dato = "Ruta seleccionada fuera de horario    "
            case "txt_geocerca":
                dato = " en Parada"
            case "txt_SS":
                dato = "Sesión"
            case "txt_deCeSe":
                dato = "¿Deseas Cerrar Sesión?"
            case "txt_frecuentes":
                dato = "Frecuentes"
            case "txt_entiempo":
                dato = "En Tiempo"
            case "txt_todas":
                dato = "Todas"
            case "txt_seinicia":
                dato = "Mantener Sesión Iniciada"
            case "txt_registro":
                dato = "Registro"
            case "txt_recover":
                dato = "Recuperar contraseña"
            case "txt_proxima":
                dato = "Proxima parada unidad"
            case "txt_recuerde":
                dato = "Recuerde estar unos minutos antes en su parada   "
            case "txt_unidadC":
                dato = "Carga de unidad"
            case "txt_unidadN":
                dato = "Unidad No Asignada"
            case "txt_rutafH":
                dato = "Ruta seleccionada fuera de horario    "
            case "txt_enPara":
                dato = "en Parada"
            case "esin":
                dato = "Español"
            case "txt_seInic":
                dato = "Mantener sesión iniciada"
            case "txt_regUse":
                dato = "Registro de usuario"
            case "txt_nomUse":
                dato = "Nombre"
            case "txt_regiBo":
                dato = "Registrar"
            case "txt_regres":
                dato = "Regresar"
            case "txt_ingres":
                dato = "Ingresa tu usuario"
            case "txt_coremp":
                dato = "usuario@empresa.com"
            case "txt_horari":
                dato = "Horarios"
            case "txt_monito":
                dato = "Centro Monitoreo"
            case "txt_inform":
                dato = "Información"
            case "txt_report":
                dato = "Reporte Transporte"
            case "txt_objper":
                dato = "Objetos Perdidos"
            case "txt_comuni":
                dato = "Comunicados"
            case "txt_reglam":
                dato = "Reglamentación"
            case "txt_regla2":
                dato = "Reglamentación de servicio"
            case "txt_manual":
                dato = "Manual de usuario"
            case "txt_frecue":
                dato = "Frecuentes"
            case "txt_entiem":
                dato = "En Tiempo"
            case "txt_todas":
                dato = "Todas"
            case "txt_llega":
                dato = "Llegada"
            case "txt_admpa":
                dato = "Administración Contraseña"
            case "txt_ingre":
                dato = "Ingresa contraseña nueva"
            case "txt_csale":
                dato = "¿Deseas cerrar sesión?"
            case "error_reg":
                dato = "Error en registro"
            case "error_dus":
                dato = "Verifica que tus datos de usuario sean correctos"
            case "error_cno":
                dato = "Correo no permitido"
            case "txt_corem":
                dato = "Ingresa usuario empresa por favor"
            case "txt_useok":
                dato = "Registro usuario correcto"
            case "txt_bndja":
                dato = "Ingresa a la bandeja de entrada de tu correo para validar tus datos de acceso"
            case "txt_spera":
                dato = "Espera un momento"
            case "txt_valid":
                dato = "Estamos validando tus datos"
            case "camp_name":
                dato = "Campo nombre requerido"
            case "camp_mail":
                dato = "Campo correo requerido"
            case "camp_user":
                dato = "Campo usuario requerido"
            case "txt_fomus":
                dato = "Formato usuario no válido"
            case "camp_pass":
                dato = "Campo contraseña nueva requerido"
            case "txt_regok":
                dato = "Registro correcto"
            case "txt_mlpas":
                dato = "La contraseña se ha recuperado con éxito, por favor revise su correo"
            case "txt_okpas":
                dato  = "La contraseña se ha guardado con éxito"
            case "txt_noinf":
                dato = "Por el momento sin información"
            case "txt_regbu":
                dato = "Registrar"
            case "rutaNo":
                dato = "Ruta no seleccionada"
            case "txt_campo":
                dato = "Campo requerido "
            case "txt_fomfield":
                dato = "Formato no válido"
            case "error_formato":
                dato = "Error Formato"
            case "txt_objDet":
                dato = "Objeto Perdidos / Detalles "
            case "txt_fecha":
                dato = "Fecha "
            case "txt_okobjeto":
                dato =  "Data sent successfully"
            case "txt_correcto":
                dato = "Envío correcto"
            case "txt_datosinco":
                dato = "Datos incompletos "
            case "txt_datosva":
                dato = "Por favor llena todos los datos del formulario"
            case "txt_namUser":
                dato = "Nombre usuario"
            case "txt_enviado":
                dato = "Enviado"
            case "error_Envio":
                dato = "Error de envío"
            case "error_EnvOP":
                dato = "Error de envío correo, usuario no encontrado"
            case "error_Enobpe":
                dato = "Error de envío datos de objeto "
            default:
                dato = ""
            }

        }else{
            switch caso {
            case "txt_enviar":
                dato = "SUBMIT"  //SEND
            case "txt_usuario":
                dato = "User"
            case "txt_pass":
                dato = "Password"
            case  "txt_selectiodima":
                dato = "Select Language"
            case  "txt_olvidar":
                dato = "Recover Password"
            case "txt_iniciarsesion":
                dato = "Sign in"
            case "txt_registrar":
                dato = "Don't have an account?, "
            case "txt_registrar2":
                dato = "Sign up"
            case "txt_idempresa":
                dato = "Id Company"
            case "txt_espanol":
                dato = "Spanish"
            case  "txt_ingles":
                dato = "English"
            case "txt_nombre":
                dato = "Full name"
            case "txt_correo":
                dato = "Email"
            case "txt_horario":
                dato = "Schedule"
            case "txt_selectruta":
                dato  = "Select Route"
            case "txt_notificaciones":
                dato = "Notifications"
            case "txt_promociones":
                dato = "Promotions"
            case "txt_perfil":
                dato = "Profile"
            case "cerrar_sesion":
                dato = "Logout"
            case "punto_partida":
                dato = "Start Point"
            case "punto_final":
                dato = "End Point"
            case "txt_objetosperdidos":
                dato = "Lost / Found Objects"
            case "txt_cambiarpass":
                dato = "Change Password"
            case "txt_telefonollamar":
                dato = "CALL MONITORING CENTER"
            case "txt_elobjeto":
                dato = "The Object was:"
            case "txt_selecthorario":
                dato = "Select Schedule"
            case "txt_itineario":
                dato = "Itinerary"
            case "txt_version":
                dato = "Version 2.0"
            case "txt_objeto":
                dato = "Object"
            case "txt_telefono":
                dato = "Phone"
            case "txt_route":
                dato = "Route"
            case "txt_perdido":
                dato = "Lost"
            case "txt_encontrado":
                dato = "Found"
            case "txt_turno":
                dato = "Turn"
            case "txt_nuevacontrasena":
                dato = "New password"
            case "txt_guardar":
                dato = "save"
            case "txt_olvidar2":
                dato = "RECOVER"
            case "txt_error_indi":
                dato = "Verify your Username or Password are correct."
            case "txt_alert":
                dato = "Alert"
            case "txt_aceptar":
                dato = "Acept"
            case "txt_cancelar":
                dato = "Cancel"
            case "exito":
                dato = "Success!!"
            case "enviocorrecto":
                dato = "Your data was sent correctly, we will respond soon"
            case "enviocorrecto2":
                dato = "Your recovery data was received, please check your email"
            case "txt_select":
                dato = "Company"
            case "txt_alert_incorrect":
                dato = "Incorrect Access"
            case "txt_cerrar":
                dato = "Close"
            case "txt_error":
                dato = "Sorry, something went wrong, try later please   "
            case "actua_correc":
                dato = "Correct update"
            case "actua_incorrec":
                dato = "Incorrect update"
            case "unidad":
                dato = "Bus"
            case "grupo":
                dato  = "Group"
            case "periodo":
                dato = "Period"
            case "busca":
                dato = "Search"
            case "deviceOffline":
                dato = "Status offline"
            case "datosIncompletos":
                dato = "Incomplete Report Data"
            case "txt_fueraH":
                dato = "Out of Time"
            case "txt_DesTi":
                dato = "Route not Selected, Out of Time   "
            case "txt_activa":
                dato = "Active Route"
            case "txt_NoHorario":
                dato = "Selected route out of hours   "
            case "txt_geocerca":
                dato = " at Bus stop"
            case "txt_SS":
                dato = "Session"
            case "txt_deCeSe":
                dato = "Do you want to Logout?"
            case "txt_frecuentes":
                dato = "Frequently"
            case "txt_entiempo":
                dato = "On Time"
            case "txt_todas":
                dato = "All"
            case "txt_seinicia":
            dato = "Keep me signed in"
            case "txt_registro":
                dato = "Sign up"
            case "txt_recover":
                dato = "Recover password"
            case "txt_proxima":
                dato = "Next bus stop"
            case "txt_recuerde":
                dato = "Remember to be a few minutes before on your bus-stop  "
            case "txt_unidadC":
                dato = "Charge of bus"
            case "txt_unidadN":
                dato = "Unassigned bus"
            case "txt_rutafH":
                dato = "Selected route after hours     "
            case "txt_enPara":
                dato = "at Stop"
            case "esin":
                dato = "Inglés"
            case "txt_seInic":
                dato = "Keep me signed in"
            case "txt_regUse":
                dato = "User register"
            case "txt_nomUse":
                dato = "Name"
            case "txt_regiBo":
                dato = "Sign up"
            case "txt_regres":
                dato = "To return"
            case "txt_ingres":
                dato = "Enter your username"
            case "txt_coremp":
                dato = "user@company.com"
            case "txt_horari":
                dato = "Schedules"
            case "txt_monito":
                dato = "Monitoring Center"
            case "txt_inform":
                dato = "Information"
            case "txt_report":
                dato = "Transport Report"
            case "txt_objper":
                dato = "Lost Objects"
            case "txt_comuni":
                dato = "Announcements"
            case "txt_reglam":
                dato = "Regulation"
            case "txt_regla2":
                dato = "Service Regulation"
            case "txt_manual":
                dato = "User Manual"
            case "txt_frecue":
                dato = "Frequently"
            case "txt_entiem":
                dato = "On Time"
            case "txt_todas":
                dato = "All"
            case "txt_llega":
                dato = "Arrival"
            case "txt_admpa":
                dato = "Password Management"
            case "txt_ingre":
                dato = "Enter new password"
            case "txt_csale":
                dato = "Do you want to log out?"
            case "error_reg":
                dato = "Registration error"
            case "error_dus":
                dato = "Verify that your user data is correct"
            case "error_cno":
                dato = "Mail not allowed"
            case "txt_corem":
                dato = "Enter company user please"
            case "txt_useok":
                dato = "Correct user registration"
            case "txt_bndja":
                dato = "Enter your email inbox to validate your access data"
            case "txt_spera":
                dato = "Wait a minute"
            case "txt_valid":
                dato = "We are validating your data"
            case "camp_name":
                dato = "Name field required"
            case "camp_mail":
                dato = "Mail field required"
            case "camp_user":
                dato = "User field required"
            case "txt_fomus":
                dato = "Not valid user format"
            case "camp_pass":
                dato = "New password field required"
            case "txt_regok":
                dato = "Correct registration"
            case "txt_mlpas":
                dato = "The password has been recovered successfully, please check your email"
            case "txt_okpas":
                dato = "The password has been saved successfully"
            case "txt_noinf":
                dato = "No information at the moment"
            case "txt_regbu":
                dato = "Register"
            case "rutaNo":
                dato = "Route not selected"
            case "txt_campo":
                dato = "Field required "
            case "txt_fomfield":
                dato = "Not valid format "
            case "error_formato":
                dato = "Format error "
            case "txt_objDet":
                dato = "Missing Item / Detailes "
            case "txt_fecha":
                dato = "Date "
            case "txt_okobjeto":
                dato = "Data sent successfully"
            case "txt_correcto":
                dato = "Sent succesfully"
            case "txt_datosinco":
                dato = "Incomplet data "
            case "txt_datosva":
                dato = "Please fill in all the information on the form"
            case "txt_namUser":
                dato = "User name"
            case "txt_enviado":
                dato = "Send"
            case "error_Envio":
                dato = "Send error"
            case "error_EnvOP":
                dato = "Mail sending error, user not found"
            case "error_Enobpe":
                dato = "Send object data error"
            default:
                dato = ""
            }
        }
        return dato
    }
}
