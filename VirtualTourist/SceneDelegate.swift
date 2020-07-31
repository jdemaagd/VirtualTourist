//
//  SceneDelegate.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: K.dataModelName)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        let navigationController = window?.rootViewController as! UINavigationController
        let mapViewController = navigationController.topViewController as! MapViewController
        mapViewController.dataController = dataController
        dataController.load()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // applicationWillTerminate
        saveViewContext()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // applicationDidEnterBackground
        saveViewContext()
    }

    func saveViewContext() {
        try? dataController.viewContext.save()
    }
}
