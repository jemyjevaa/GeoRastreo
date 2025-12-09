//
//  IdiomaManagerType.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 19/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent
import Cashier

public let IdiomaManagerCacheKey = "IdiomaManager"

public protocol IdiomaManagerType {
    associatedtype IdiomaType: Serializable
}


public extension IdiomaManagerType {
    static var currentIdioma: IdiomaType? {
          get {
              // Retrieve object from cache
              return NOPersistentStore.cache(withId: IdiomaManagerCacheKey).serializableForKey("Idioma")
          }
          set {
              if let newValue = newValue {
                  // If there is a new value, set it
                 NOPersistentStore.cache(withId: IdiomaManagerCacheKey).setSerializable(newValue, forKey: "Idioma")
              } else {
                  // Otherwise delete from cache
                  NOPersistentStore.cache(withId: IdiomaManagerCacheKey).setObject(nil, forKey: "Idioma")
              }
          }
      }
}
