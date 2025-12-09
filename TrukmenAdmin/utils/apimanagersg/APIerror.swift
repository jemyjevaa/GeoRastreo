//
//  APIerror.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 4/1/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation

class APIerror: Codable {
    var messages : String? = ""
       var statusCode : Int?

       var error : String? = ""
       var status : Bool?
}
