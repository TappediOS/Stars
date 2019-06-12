//
//  ThirdSellect.swift
//  Star
//
//  Created by jun on 2018/08/11.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Foundation
import GameKit
import SceneKit
import FirebaseAnalytics
import GoogleMobileAds

class ThirdSellectViewController: UIViewController, GKGameCenterControllerDelegate{
   
   
   //Leaderboard ID
   let LEADERBOARD_ID = "Stage1"
   let bannreView = GADBannerView()
   let request:GADRequest = GADRequest()

   let BANNER_VIEW_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
   let BANNER_VIEW_ID: String = "ca-app-pub-1460017825820383/8459243400"
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      let scene = SCNScene(named: "main.scn")!
      let SceneView = SCNView()
      self.view = SceneView
      SceneView.backgroundColor = UIColor.black
      SceneView.scene = scene
      SceneView.showsStatistics = false
      view.accessibilityIgnoresInvertColors = true
      
      let lightNode = SCNNode()
      lightNode.light = SCNLight()
      lightNode.light?.type = SCNLight.LightType.omni
      lightNode.position = SCNVector3(x: 0, y: 1000000, z: 0)
      scene.rootNode.addChildNode(lightNode)
      
      let CameraNode = SCNNode()
      CameraNode.camera = SCNCamera()
      CameraNode.position = SCNVector3(x: 0, y: 10035 , z: -3.5)
      CameraNode.eulerAngles.x = -90
      scene.rootNode.addChildNode(CameraNode)
      
      let Gorld = SCNSphere(radius: 0.001)
      Gorld.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
      let GorldNode = SCNNode(geometry: Gorld)
      let bodyShape = SCNPhysicsShape(geometry: Gorld, options: [:])
      GorldNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
      GorldNode.physicsBody?.mass = 0
      GorldNode.position = SCNVector3(0, 10027.5, 0)
      SceneView.scene?.rootNode.addChildNode(GorldNode)
      let Stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: "")
      GorldNode.addParticleSystem(Stars!)
      
      
      
      
      
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      self.present(gcView, animated: true, completion: nil)
      
      let Size: CGSize = UIScreen.main.bounds.size
      bannreView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
      bannreView.frame = CGRect(x: 0, y: Size.height - (tabBarController?.tabBar.frame.size.height)! - 50, width: Size.width, height: 50)
      
      view.addSubview(bannreView)
      view.bringSubviewToFront(bannreView)
      
      print("\n--------INFO ADMOB--------------\n")
      print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion())
      
     
      bannreView.rootViewController = self
      
      print("Target ->", TARGET_OS_SIMULATOR)
      
      #if DEBUG
      print("this is test ad")
       bannreView.adUnitID = BANNER_VIEW_TEST_ID
      self.request.testDevices = ["9d012329e337de42666c706e842b7819"];
      #else
      print("\n\n--------INFO ADMOB--------------\n")
      print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion() + "\n")
      self.bannreView.adUnitID = BANNER_VIEW_ID
      print("バナー広告：本番環境")
      #endif
      
     bannreView.load(request)
      
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      
      let gcView = GKGameCenterViewController()
      gcView.gameCenterDelegate = self
      gcView.viewState = GKGameCenterViewControllerState.leaderboards
      self.present(gcView, animated: true, completion: nil)
      
      Analytics.logEvent("LoadRankingView", parameters: nil)

      
   }
   
   //GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: nil)
   }
   

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}
