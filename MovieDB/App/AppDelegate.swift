//
//  AppDelegate.swift
//  MovieDB
//
//  Created by yakup caglan on 28.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var coreDataManeger = CoreDataManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let container = DependencyContainer()
        
        let rootViewController = container.makeHomeViewController()
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ aplication: UIApplication) {
        
        do {
            try coreDataManeger.saveContext()
        } catch {
            debugPrint("Could not save context on app termination.")

        }
    }
}

