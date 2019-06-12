//
//  SecondSellect.swift
//  Star
//
//  Created by jun on 2018/08/11.
//  Copyright © 2018年 jun. All rights reserved.
//


import UIKit
import SceneKit
import SpriteKit
import Foundation
import FirebaseAnalytics
import GoogleMobileAds



class SecondSellectViewController: UIViewController {
   
   
   var wall:[[[Int]]] = [
      [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0],
         ],
      [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0],
         ],
      [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0],
         ],
      [
         [0, 0, 0],
         [0, 0, 0],
         [0, 0, 0],
         ]
   ]
   
   
   var UserScore2: UserDefaults = UserDefaults.standard
   
   let SceneView = SCNView()
   var Node = SCNNode()
   var Camera_Node = SCNNode()
   var count1: Int = 1
   var count2: Int = 1
   var count3: Int = 1
   var deruta : Double = 0
   var sun = SCNNode()
   var Score = SKLabelNode()
   let bannreView = GADBannerView()
   let request:GADRequest = GADRequest()
   
   let bokeh = SCNParticleSystem(named: "Myparticle2.scnp", inDirectory: "")
   let Stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: "")

   let FlowStart = SCNParticleSystem(named: "FlowStar.scnp", inDirectory: "")

   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      let scene = SCNScene(named: "main.scn")!
      let SceneView = SCNView()
      self.view = SceneView
      SceneView.backgroundColor = UIColor.black
      SceneView.scene = scene
      SceneView.showsStatistics = false
      view.accessibilityIgnoresInvertColors = true
      SceneView.allowsCameraControl = true
      
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
      Camera_Node = CameraNode
      
      let Gorld = SCNSphere(radius: 0.23)
      Gorld.firstMaterial?.diffuse.contents = UIImage(named: "green")
      let GorldNode = SCNNode(geometry: Gorld)
      let bodyShape = SCNPhysicsShape(geometry: Gorld, options: [:])
      GorldNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
      GorldNode.physicsBody?.mass = 0
      GorldNode.position = SCNVector3(0, 10027.5, 0)
      SceneView.scene?.rootNode.addChildNode(GorldNode)
      GorldNode.addParticleSystem(self.bokeh!)
      GorldNode.addParticleSystem(self.Stars!)
      
      //GorldNode.addParticleSystem(self.FlowStart!)
      
      
      sun = GorldNode
      
      
      for tmp in 0 ... 3 {
         count1 = 0
         count2 = 0
         count3 = 0
         for x in 0 ... 2 {
            for y in 0 ... 2 {
               var num = Int(arc4random_uniform(3))
               if num == 0 && count1 == 3 {
                  num = 1
               }
               if num == 1 && count2 == 3 {
                  num = 2
               }
               if num == 2 && count3 == 3 {
                  num = 0
               }
               if num == 0 && count1 == 3 {
                  num = 1
               }
               wall[tmp][x][y] = num
               if num == 0 {
                  count1 += 1
               }else if num == 1{
                  count2 += 1
               }else if num == 2 {
                  count3 += 1
               }
            }
         }
      }
      
      for tmp in 0 ... 3 {
         for x in 0 ... 2 {
            for y in 0 ... 2 {
               if wall[tmp][x][y] == 0 {
                  let Wall0 = SCNPlane(width: 1.2, height: 1.2)
                  Wall0.firstMaterial?.diffuse.contents = UIImage(named: "green")
                  let WallNode0 = SCNNode(geometry: Wall0)
                  let WallShape0 = SCNPhysicsShape(geometry: Wall0, options: nil)
                  WallNode0.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape0)
                  WallNode0.physicsBody?.mass = 0
                  WallNode0.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode0.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2 - 0.2)
                  SceneView.scene?.rootNode.addChildNode(WallNode0)
               }else if wall[tmp][x][y] == 1 {
                  let Wall1 = SCNPlane(width: 1.19, height: 1.19)
                  Wall1.firstMaterial?.diffuse.contents = UIImage(named: "red")
                  let WallNode1 = SCNNode(geometry: Wall1)
                  let WallShape1 = SCNPhysicsShape(geometry: Wall1, options: nil)
                  WallNode1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape1)
                  WallNode1.physicsBody?.mass = 0
                  WallNode1.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode1.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2 - 0.2)
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
               }else if wall[tmp][x][y] == 2 {
                  let Wall1 = SCNPlane(width: 1.19, height: 1.19)
                  Wall1.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
                  let WallNode1 = SCNNode(geometry: Wall1)
                  let WallShape1 = SCNPhysicsShape(geometry: Wall1, options: nil)
                  WallNode1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape1)
                  WallNode1.physicsBody?.mass = 0
                  WallNode1.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode1.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2 - 0.2)
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
               }
            }
         }
      }
      
      
      
      let skScene = SKScene()
      let Size: CGSize = UIScreen.main.bounds.size
      skScene.size = CGSize(width: Size.width, height: Size.height)
      SceneView.overlaySKScene = skScene
      
      //overlayするノード
      var overlayNode: SKNode
      overlayNode = SKNode()
      overlayNode.position = CGPoint(x: 0.0, y: Size.height)
      skScene.addChild(overlayNode)
      
      
      // Setup the game overlays using SpriteKit.
      //scaleMode = .resizeFill
      
      let ScoreLabelChar = SKLabelNode(text: "Best Score")
      ScoreLabelChar.fontSize = 80
      //y座標はマイナスで下側に。
      ScoreLabelChar.position = CGPoint(x: Size.width / 2, y: -Size.height * 2 / 8)
      ScoreLabelChar.xScale = 0.5
      ScoreLabelChar.yScale = 0.5
      overlayNode.addChild(ScoreLabelChar)
      
      
      UserScore2.register(defaults: ["Stage2": 0])
      let HightScore2: Int = UserScore2.object(forKey: "Stage2") as! Int
      
      let ScoreLabel = SKLabelNode(text: String(HightScore2))
      ScoreLabel.fontSize = 90
      ScoreLabel.position = CGPoint(x: Size.width / 2, y: -Size.height * 3 / 8)
      ScoreLabel.xScale = 0.5
      ScoreLabel.yScale = 0.5
      overlayNode.addChild(ScoreLabel)
      Score = ScoreLabel
      
      
      let Arrow = SKLabelNode(text: "↑")
      Arrow.fontSize = 85
      Arrow.position = CGPoint(x: Size.width / 2, y: -Size.height * 9 / 16)
      Arrow.xScale = 0.5
      Arrow.yScale = 0.5
      overlayNode.addChild(Arrow)
      
      let StartLabel = SKLabelNode(text: "Tap To Start")
      StartLabel.fontSize = 80
      StartLabel.position = CGPoint(x: Size.width / 2, y: -Size.height * 10 / 16)
      StartLabel.xScale = 0.5
      StartLabel.yScale = 0.5
      overlayNode.addChild(StartLabel)
      
     
      
      bannreView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
      bannreView.frame = CGRect(x: 0, y: Size.height - (tabBarController?.tabBar.frame.size.height)! - 82, width: Size.width, height: 50)
      
      view.addSubview(bannreView)
      view.bringSubviewToFront(bannreView)
      
      print("\n--------INFO ADMOB--------------\n")
      print("Google Mobile ads SDK Versioin -> " + GADRequest.sdkVersion())
      
      bannreView.adUnitID = "ca-app-pub-1460017825820383/4975950503"
      bannreView.rootViewController = self
      
      print("Target ->", TARGET_OS_SIMULATOR)
      
      #if DEBUG
         print("this is test ad")
         request.testDevices = ["32469097af622f72ff0f6d1ded471f0c"]
      #else
         if TARGET_OS_SIMULATOR == 1{
            request.testDevices = [kGADSimulatorID]
         }else{
            request.testDevices = ["32469097af622f72ff0f6d1ded471f0c"]
         }
      
         bannreView.load(request)
      #endif
      
      
     
      
      
      
      // add a tap gesture recognizer
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      SceneView.addGestureRecognizer(tapGesture)
      

   }
   
   @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
      // retrieve the SCNView
      let SceneView = self.view as! SCNView
      
      // check what nodes are tapped
      let p = gestureRecognize.location(in: SceneView)
      let hitResults = SceneView.hitTest(p, options: [:])
      
      if hitResults.count > 0 {
         // retrieved the first clicked object
         let result: AnyObject = hitResults[0]
         
         // get its material
         let material = result.node!.geometry!.firstMaterial!
         //print(material)
         
         if material == sun.geometry?.firstMaterial {
            Analytics.logEvent("TapStage2Ball", parameters: nil)
            let nextvc = SecondViewController()
            self.present(nextvc, animated: false, completion: nil)
         }
      }
      
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      
      UserScore2.register(defaults: ["Stage2": 0])
      let HightScore2: Int = UserScore2.object(forKey: "Stage2") as! Int
      Score.text = String(HightScore2)
      
      Analytics.logEvent("LoadStage2", parameters: nil)


   }
   
   
  
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}
