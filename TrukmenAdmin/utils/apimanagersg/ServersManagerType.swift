//
//  ServersManagerType.swift
//  TrukmenAdmin
//
//  Created by Desarrollo Movil on 11/04/23.
//  Copyright © 2023 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent
import Cashier

public let ServersManagerCacheKey = "ServersManager"

public protocol ServersManagerType {
    associatedtype ServersType: Serializable
}


public extension ServersManagerType {
    static var currentServers: ServersType? {
          get {
              // Retrieve object from cache
              return NOPersistentStore.cache(withId: ServersManagerCacheKey).serializableForKey("Servers")
          }
          set {
              if let newValue = newValue {
                  // If there is a new value, set it
                 NOPersistentStore.cache(withId: ServersManagerCacheKey).setSerializable(newValue, forKey: "Servers")
              } else {
                  // Otherwise delete from cache
                  NOPersistentStore.cache(withId: ServersManagerCacheKey).setObject(nil, forKey: "Servers")
              }
          }
      }
}
