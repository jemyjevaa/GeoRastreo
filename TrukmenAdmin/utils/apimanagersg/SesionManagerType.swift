//
//  SesionManagerType.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 24/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent
import Cashier

public let SesionManagerCacheKey = "SesionManager"

public protocol SesionManagerType {
    associatedtype SesionType: Serializable
}


public extension SesionManagerType {
    static var currentSesion: SesionType? {
          get {
              // Retrieve object from cache
              return NOPersistentStore.cache(withId: SesionManagerCacheKey).serializableForKey("Sesion")
          }
          set {
              if let newValue = newValue {
                  // If there is a new value, set it
                 NOPersistentStore.cache(withId: SesionManagerCacheKey).setSerializable(newValue, forKey: "Sesion")
              } else {
                  // Otherwise delete from cache
                  NOPersistentStore.cache(withId: SesionManagerCacheKey).setObject(nil, forKey: "Sesion")
              }
          }
      }
}
