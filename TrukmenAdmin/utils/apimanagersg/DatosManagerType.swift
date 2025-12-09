//
//  DatosManagerType.swift
//  TrukmenAdmin
//
//  Created by Busmen Apps on 27/05/22.
//  Copyright © 2022 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent
import Cashier

public let DataManagerCacheKey = "DataManager"

public protocol DataManagerType {
    associatedtype DataType: Serializable
}


public extension DataManagerType {
    static var currentData: DataType? {
          get {
              // Retrieve object from cache
              return NOPersistentStore.cache(withId: DataManagerCacheKey).serializableForKey("Dataap")
          }
          set {
              if let newValue = newValue {
                  // If there is a new value, set it
                 NOPersistentStore.cache(withId: DataManagerCacheKey).setSerializable(newValue, forKey: "Dataap")
              } else {
                  // Otherwise delete from cache
                  NOPersistentStore.cache(withId: DataManagerCacheKey).setObject(nil, forKey: "Dataap")
              }
          }
      }
}
