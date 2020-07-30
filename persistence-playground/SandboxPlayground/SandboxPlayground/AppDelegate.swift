//
//  AppDelegate.swift
//  SandboxPlayground
//
//  Created by JON DEMAAGD on 7/4/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?
    
    func sandboxPlayground() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.last?.appendingPathComponent("file.txt")
        
        do {
            try "Hi there!".write(to: url!, atomically: true, encoding: .utf8)
        } catch {
            print("Error while writing")
        }
        
        do {
            let content = try String(contentsOf: url!, encoding: .utf8)
            if content == "Hi there!" {
                print("Yay!")
            } else {
                print("Ooops!")
            }
        } catch {
            print("Something went wrong")
        }
    }

    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sandboxPlayground()
        return true
    }
}
