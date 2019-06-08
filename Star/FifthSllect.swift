//
//  FifthSllect.swift
//  Star
//
//  Created by jun on 2018/08/11.
//  Copyright © 2018年 jun. All rights reserved.
//


import UIKit
import SceneKit
import SpriteKit
import Foundation
import StoreKit
import AudioToolbox
import FirebaseAnalytics

class FifthSellectViewController: UIViewController, IAPManagerDelegate {
   
   
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
   
   
   var UserScore4: UserDefaults = UserDefaults.standard
   var AreYouBuy: UserDefaults = UserDefaults.standard
   var YesOrNo: Bool = false
   let SceneView = SCNView()
   var Node = SCNNode()
   var Camera_Node = SCNNode()
   var count1: Int = 1
   var count2: Int = 1
   var count3: Int = 1
   var count4: Int = 1
   var count5: Int = 1
   var deruta : Double = 0
   var sun = SCNNode()
   var Score = SKLabelNode()
   
   let bokeh = SCNParticleSystem(named: "Myparticle3.scnp", inDirectory: "")
   let Stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: "")
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      AreYouBuy.register(defaults: ["AreYouBuy": false])
      YesOrNo = AreYouBuy.object(forKey: "AreYouBuy") as! Bool
      
      IAPManager.shared.delegate = self
      
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
      sun = GorldNode
     
      
      
      for tmp in 0 ... 3 {
         count1 = 0
         count2 = 0
         count3 = 0
         count4 = 0
         count5 = 0
         for x in 0 ... 2 {
            for y in 0 ... 2 {
               var num = Int(arc4random_uniform(5))
               
               if num == 0 && count1 == 2 {
                  num = 1
               }
               if num == 1 && count2 == 2 {
                  num = 2
               }
               if num == 2 && count3 == 2 {
                  num = 3
               }
               if num == 3 && count4 == 2 {
                  num = 4
               }
               if num == 4 && count5 == 2 {
                  num = 0
               }
               if num == 0 && count1 == 2 {
                  num = 1
               }
               if num == 1 && count2 == 2 {
                  num = 2
               }
               if num == 2 && count3 == 2 {
                  num = 3
               }
               if num == 3 && count4 == 2 {
                  num = Int(arc4random_uniform(5))
               }
               wall[tmp][x][y] = num
               if num == 0 {
                  count1 += 1
               }else if num == 1{
                  count2 += 1
               }else if num == 2 {
                  count3 += 1
               }else if num == 3 {
                  count4 += 1
               }else if num == 4 {
                  count5 += 1
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
               }else if wall[tmp][x][y] == 3 {
                  let Wall1 = SCNPlane(width: 1.19, height: 1.19)
                  Wall1.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
                  let WallNode1 = SCNNode(geometry: Wall1)
                  let WallShape1 = SCNPhysicsShape(geometry: Wall1, options: nil)
                  WallNode1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape1)
                  WallNode1.physicsBody?.mass = 0
                  WallNode1.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode1.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2 - 0.2)
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
               }else if wall[tmp][x][y] == 4 {
                  let Wall1 = SCNPlane(width: 1.19, height: 1.19)
                  Wall1.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
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
      
      
      UserScore4.register(defaults: ["Stage4": 0])
      let HightScore4: Int = UserScore4.object(forKey: "Stage4") as! Int
      
      let ScoreLabel = SKLabelNode(text: String(HightScore4))
      ScoreLabel.fontSize = 90
      ScoreLabel.position = CGPoint(x: Size.width / 2, y: -Size.height * 3 / 8)
      ScoreLabel.xScale = 0.5
      ScoreLabel.yScale = 0.5
      overlayNode.addChild(ScoreLabel)
      Score = ScoreLabel
      
      
      if YesOrNo == true {
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
      }
      
      
      
      
      
      // add a tap gesture recognizer
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      SceneView.addGestureRecognizer(tapGesture)
      
      if YesOrNo == false {
         let View = UIView(frame: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
         View.backgroundColor = UIColor.white
         View.alpha = 0.35
         SceneView.addSubview(View)
         View.bringSubviewToFront(SceneView)
         
         let BuyButton = UIButton(frame: CGRect(x: Size.width / 8, y: Size.height * 10 / 16, width: Size.width / 3, height: Size.height / 8))
         BuyButton.backgroundColor = UIColor.black.withAlphaComponent(0.85)
         BuyButton.layer.cornerRadius = 10.0
         BuyButton.layer.borderColor = UIColor.black.cgColor
         BuyButton.setTitle(NSLocalizedString("Purchase", comment: ""), for: .normal)
         //これで文字のサイズを可変にしてる。
         BuyButton.titleLabel?.adjustsFontSizeToFitWidth = true
         BuyButton.addTarget(self, action: #selector(FifthSellectViewController.Buy), for: .touchUpInside)
         View.addSubview(BuyButton)
         //self.view.bringSubview(toFront: bu)
         
         let ReBuyButton = UIButton(frame: CGRect(x: Size.width * 9 / 16, y: Size.height * 10 / 16, width: Size.width / 3, height: Size.height / 8))
         ReBuyButton.backgroundColor = UIColor.black.withAlphaComponent(0.85)
         ReBuyButton.layer.cornerRadius = 10.0
         ReBuyButton.layer.borderColor = UIColor.black.cgColor
         ReBuyButton.titleLabel?.adjustsFontSizeToFitWidth = true
         ReBuyButton.setTitle(NSLocalizedString("Restore", comment: ""), for: .normal)
         ReBuyButton.addTarget(self, action: #selector(FifthSellectViewController.ReBuy), for: .touchUpInside)
         View.addSubview(ReBuyButton)

      }
      
      
      
   }
   
   @objc func Buy() {
      print("tap buy")
      Analytics.logEvent("TapBuyButton", parameters: nil)

      
      //購入
      IAPManager.shared.buy(productIdentifier: "StageFifthBuy")
   }
   
   @objc func ReBuy() {
      print("tap Rebuy")
      Analytics.logEvent("TapRestoreButton", parameters: nil)
      
      //リストア
      IAPManager.shared.restore()
   }
   
   //購入が完了した時
   func iapManagerDidFinishPurchased() {
      //購入完了をユーザに知らせるアラートを表示
      //UserDefaultにBool値を保存する(例:isPurchased = true)
      //Indicatorを隠す処理
      //広告を消す処理など
      
      YesOrNo = true
      AreYouBuy.set(true, forKey: "AreYouBuy")
      
      print("Done buy")

      
      loadView()
      viewDidLoad()
   }
   //購入に失敗した時
   func iapManagerDidFailedPurchased() {
      //購入失敗をユーザに知らせるアラートなど
      //Indicatorを隠す処理
      print("You could not buy")
      AudioServicesPlaySystemSound(1521);
      AudioServicesPlaySystemSound(1521);
   }
   //リストアが完了した時
   func iapManagerDidFinishRestore(_ productIdentifiers: [String]) {
      for identifier in productIdentifiers {
         if identifier == "StageFifthBuy" {
            //リストア完了をユーザに知らせるアラートを表示
            //UserDefaultにBool値を保存する(例:isPurchased = true)
            //広告を消す処理など
            YesOrNo = true
            AreYouBuy.set(true, forKey: "AreYouBuy")
            
            print("Done Restore")
            
            loadView()
            viewDidLoad()
            SKStoreReviewController.requestReview()
         }
      }
      //Indicatorを隠す処理
   }
   //1度もアイテム購入したことがなく、リストアを実行した時
   func iapManagerDidFailedRestoreNeverPurchase() {
      //先に購入をお願いするアラートを表示
      //Indicatorを隠す処理
      print("You havent buy")
      AudioServicesPlaySystemSound(1521);
      AudioServicesPlaySystemSound(1521);
   }
   //リストアに失敗した時
   func iapManagerDidFailedRestore() {
      //リストア失敗をユーザに知らせるアラートを表示
      //Indicatorを隠す処理
      print("false restore")
      AudioServicesPlaySystemSound(1521);
      AudioServicesPlaySystemSound(1521);
   }
   //特殊な購入時の延期の時
   func iapManagerDidDeferredPurchased() {
      //購入失敗をユーザに知らせるアラートを表示
      //Indicatorを隠す処理
      print("?")
      AudioServicesPlaySystemSound(1521);
      AudioServicesPlaySystemSound(1521);
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
            if YesOrNo == true {
               Analytics.logEvent("TapStage4Ball", parameters: nil)
               let nextvc = FifthViewController()
               self.present(nextvc, animated: false, completion: nil)
            }else{
               print("you dont buy")
               AudioServicesPlaySystemSound(1521);
               AudioServicesPlaySystemSound(1521);
            }
         }
         
      }
      
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      
      UserScore4.register(defaults: ["Stage4": 0])
      let HightScore4: Int = UserScore4.object(forKey: "Stage4") as! Int
      Score.text = String(HightScore4)
      
      Analytics.logEvent("LoadStage4", parameters: nil)

      
   }
   
   
   
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}


