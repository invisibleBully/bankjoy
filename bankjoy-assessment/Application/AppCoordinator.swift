//
//  AppCoordinator.swift
//  bankjoy-assessment
//
//  Created by Jude Botchwey on 2025-01-04.
//

import Foundation
import UIKit

class AppCoordinator {
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let loginViewController = LoginViewController()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}