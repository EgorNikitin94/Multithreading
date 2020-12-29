//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        buildApp()
        
        return true
    }
    
    
    func buildApp() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarViewController = TabBarViewController()
        
        tabBarViewController.view.backgroundColor = .white
        
        window?.rootViewController = tabBarViewController
        
        window?.makeKeyAndVisible()
    }
    
    /// Сообщает делегату, что приложение собирается перейти на передний план.
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    /// Сообщает делегату, что приложение стало активным.
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    /// Сообщает делегату, что приложение скоро станет неактивным.
    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    
    /// Сообщает делегату, что приложение теперь работает в фоновом режиме.
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(type(of: self), #function)
        
        // My background work time = 29.48264756199933 seconds
    }
    
    /// Сообщает делегату о завершении работы приложения.
    func applicationWillTerminate(_ application: UIApplication) {
        print(type(of: self), #function)
    }
    
    /// Просит делегата открыть ресурс, указанный URL-адресом, и предоставляет словарь параметров запуска.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(type(of: self), #function)
        return true
    }
    
    /// Сообщает делегату, что доступны данные для продолжения действия.
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print(type(of: self), #function)
        return true
    }
    
}


