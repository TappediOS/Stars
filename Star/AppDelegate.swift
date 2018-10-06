//
//  AppDelegate.swift
//  Star
//
//  Created by jun on 2018/07/04.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
//課金で使う
import StoreKit
//gamekit
import GameKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?


   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      
      
      //以下を追加 課金で使う
      SKPaymentQueue.default().add(IAPManager.shared)
      
      //gamecenter
      if let rootView = self.window?.rootViewController {
         let player = GKLocalPlayer.local
         
         player.authenticateHandler = {(viewController, error) -> Void in
            if player.isAuthenticated {
               //geme center login
               print("geme center authenticated")
               
            } else if viewController != nil {
               //game center not login. login page open
               print("game center not login. login page open")
               rootView.present(viewController!, animated: true, completion: nil)
               
            } else {
               if error != nil {
                  //game center login error
                  print("game center login error")
               }
            }
         }
      }
      ///gamecenter
      
      //--------------------FIREBASE-----------------------//
      #if DEBUG
      let fileName = "GoogleService-Info-Dev"
      print("テスト環境")
      #else
      let fileName = "GoogleService-Info"
      print("本番のfirebaseにアクセス")
      #endif
      
      let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")
      let fileopts = FirebaseOptions(contentsOfFile: filePath!)
      FirebaseApp.configure(options: fileopts!)
      //--------------------FIREBASE-----------------------//
      
      
      GADMobileAds.configure(withApplicationID: "ca-app-pub-1460017825820383/4573050858")
      GADMobileAds.configure(withApplicationID: "ca-app-pub-1460017825820383/4975950503")
      GADMobileAds.configure(withApplicationID: "ca-app-pub-1460017825820383/7550567986")
      GADMobileAds.configure(withApplicationID: "ca-app-pub-1460017825820383/8459243400")
      
      // Initialize Google Mobile Ads SDK
      GADMobileAds.configure(withApplicationID: "ca-app-pub-1460017825820383~9853297696")




      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(_ application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }


}

