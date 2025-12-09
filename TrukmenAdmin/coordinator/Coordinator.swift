//
//  Coordinator.swift
//  TrukmenAdmin
//
//  Created by Adan Magaña on 3/25/20.
//  Copyright © 2020 Adan Magaña. All rights reserved.
//

import UIKit

protocol Coordinator {
    //1
    var children: [Coordinator] { set get }
    //2
    var navigationController: UINavigationController { set get }
    //3
    func start()
}
