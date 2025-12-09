//
//  UserManagerType.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 4/1/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import Foundation
import Serpent
import Cashier

public let UserManagerCacheKey = "UserManager"

public protocol UserManagerType {
    associatedtype UserType: Serializable
}


public extension UserManagerType {
    static var currentUser: UserType? {
          get {
              // Retrieve object from cache
              return NOPersistentStore.cache(withId: UserManagerCacheKey).serializableForKey("User")
          }
          set {
              if let newValue = newValue {
                  // If there is a new value, set it
                 NOPersistentStore.cache(withId: UserManagerCacheKey).setSerializable(newValue, forKey: "User")
              } else {
                  // Otherwise delete from cache
                  NOPersistentStore.cache(withId: UserManagerCacheKey).setObject(nil, forKey: "User")
              }
          }
      }
}
