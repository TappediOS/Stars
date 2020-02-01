//
//  FifthView.swift
//  Star
//
//  Created by jun on 2018/08/12.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import AudioToolbox
import AVFoundation
import Foundation
import GameKit
import FirebaseAnalytics
import GoogleMobileAds
import TapticEngine
import FlatUIKit
import ChameleonFramework
import SCLAlertView
import Firebase


class FifthViewController: UIViewController, SCNPhysicsContactDelegate, GKGameCenterControllerDelegate, GADRewardBasedVideoAdDelegate, SCNSceneRendererDelegate ,GADInterstitialDelegate {
   
   var wall:[[[Int]]] = [[[]]]
   let FoundSpeed: Float = 0.1752
   var dr: Float = 0.000505
   var PlusSpeed: Float = 0.00498
   var AfterAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: 480)
   var score:Int = 0
   var y_speed:CGFloat = -22
   let BoxCategory: UInt32 = 0b0001
   let SunCategory: UInt32 = 0b0100
   let FloorCategoyr: UInt32 = 0b010
   let Wall0Category: UInt32 = 0b1000
   let Wall1Category: UInt32 = 0b1001
   var Sunposition = 3.1
   var sunspeed = 0.5
   var set:Bool = true
   let SceneView = SCNView()
   var Node = SCNNode()
   var Camera_Node = StageCamera()
   var count: Int = 100
   var Speed: Double = 419
   var up: Int = 0
   var right: Int = 1
   var left: Int = 0
   var down: Int = 0
   let speed = 0.05
   let sunposi = -15
   var MoveCount: Int = 400
   var MoveCount_tate: Int = 2
   var sun = SCNNode()
   var wall0 = SCNNode()
   var wall1 = SCNNode()
   var deruta : Double = 0
   var SpeedUpCount = 0
   var count1: Int = 1
   var count2: Int = 1
   var count3: Int = 1
   var count4: Int = 1
   var count5: Int = 1
   var watch: Int = 0
   var hozon: Int = 1
   var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス
   var audio1 : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス
   var Score = SKLabelNode()
   var UserScore4: UserDefaults = UserDefaults.standard
   var SpotLightNode = StageSpotLight()
   let LEADERBOARD_ID = "Stage4"
   let userDefault = UserDefaults.standard
   //3
   let Size: CGSize = UIScreen.main.bounds.size
   
   //4
   let View = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
   let View2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
   
   //5
   let AdMobID = "ca-app-pub-1460017825820383/4745063368"
   //この394で始まってるやつはgoogleが用意しているテストID
   let TEST_ID = "ca-app-pub-3940256099942544/1712485313"
   var AdUnitID:String? = nil
   /// Is an ad being loaded.
   var adRequestInProgress = false
   var adRedy = false
   
   let request:GADRequest = GADRequest()
   
   
   //6
   /// The reward-based video ad.
   var rewardBasedVideo: GADRewardBasedVideoAd?
   var RewardAD: Bool = true
   
   let key1 = SCNParticleSystem(named: "key1.scnp", inDirectory: "")
   let key2 = SCNParticleSystem(named: "key2.scnp", inDirectory: "")
   let key3 = SCNParticleSystem(named: "key3.scnp", inDirectory: "")
   
   let bokeh = SCNParticleSystem(named: "Myparticle3.scnp", inDirectory: "")
   let Stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: "")
   
   let GrowStar = SCNParticleSystem(named: "Conffi.scnp", inDirectory: "")
   
   let gameBGM = BGM()
   
   var MyTimer = Timer()
   
   var LockSunMove = false
   
   var Interstitial: GADInterstitial!
   let INTERSTITIAL_TEST_ID = "ca-app-pub-3940256099942544/4411468910"
   let INTERSTITIAL_ID = "ca-app-pub-1460017825820383/8064464410"
   
   let CanPosiBall = CanMoveBall()
   
   

   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      // シーン設定
      let scene = SCNScene(named: "main.scn")!
      /////超重要!!!!!!!!!!!!!!!!!!!!!!!!!!
      scene.physicsWorld.contactDelegate = self
      
      let SceneView = SCNView()
      self.view = SceneView
      SceneView.backgroundColor = UIColor.black
      SceneView.scene = scene
      SceneView.showsStatistics = false
      SceneView.delegate = self
      view.accessibilityIgnoresInvertColors = true
      SceneView.preferredFramesPerSecond = 60
      
      scene.rootNode.addChildNode(SpotLightNode)
      
      let floor = SCNFloor()
      floor.reflectivity = 0.5
      floor.firstMaterial?.diffuse.contents = UIImage(named: "Snow1")
      floor.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(512 / 30, 1024 / 30, 0)
      let floorNode = SCNNode(geometry: floor)
      let floorShape = SCNPhysicsShape(geometry: floor, options: nil)
      let floorBody = SCNPhysicsBody(type: .static, shape: floorShape)
      floorNode.physicsBody = floorBody
      floorNode.physicsBody?.friction = 1
      floorNode.physicsBody?.restitution = 1
      floorNode.physicsBody?.contactTestBitMask = 0
      floorNode.physicsBody?.collisionBitMask = Int(BoxCategory) + Int(SunCategory)
      floorNode.physicsBody?.categoryBitMask = Int(FloorCategoyr)
      scene.rootNode.addChildNode(floorNode)
      
     
      wall.removeAll()
      
      for tmp in 0 ... 175 {
         count1 = 0
         count2 = 0
         count3 = 0
         count4 = 0
         count5 = 0
         wall.append([[0, 0, 0], [0, 0, 0], [0, 0, 0]])
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
      
      for tmp in 0 ... 175 {
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
                  WallNode0.physicsBody?.categoryBitMask = Int(Wall0Category)
                  WallNode0.physicsBody?.collisionBitMask = 0
                  WallNode0.physicsBody?.contactTestBitMask = Int(SunCategory)
                  WallNode0.castsShadow = false
                  SceneView.scene?.rootNode.addChildNode(WallNode0)
                  wall0 = WallNode0
                  
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
                  WallNode1.physicsBody?.categoryBitMask = Int(Wall1Category)
                  WallNode1.physicsBody?.collisionBitMask = 0
                  WallNode1.physicsBody?.contactTestBitMask = Int(SunCategory)
                  WallNode1.castsShadow = false
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
                  wall1 = WallNode1
                  
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
                  WallNode1.physicsBody?.categoryBitMask = Int(Wall1Category)
                  WallNode1.physicsBody?.collisionBitMask = 0
                  WallNode1.physicsBody?.contactTestBitMask = Int(SunCategory)
                  WallNode1.castsShadow = false
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
                  wall1 = WallNode1
                  
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
                  WallNode1.physicsBody?.categoryBitMask = Int(Wall1Category)
                  WallNode1.physicsBody?.collisionBitMask = 0
                  WallNode1.physicsBody?.contactTestBitMask = Int(SunCategory)
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
                  WallNode1.castsShadow = false
                  wall1 = WallNode1
                  
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
                  WallNode1.physicsBody?.categoryBitMask = Int(Wall1Category)
                  WallNode1.physicsBody?.collisionBitMask = 0
                  WallNode1.physicsBody?.contactTestBitMask = Int(SunCategory)
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
                  WallNode1.castsShadow = false
                  wall1 = WallNode1
                  
               }
            }
         }
      }
      
      let Gorld = SCNSphere(radius: 0.23)
      //テクスチャ
      Gorld.firstMaterial?.diffuse.contents = UIImage(named: "green")
      //ノード
      let GorldNode = SCNNode(geometry: Gorld)
      let bodyShape = SCNPhysicsShape(geometry: Gorld, options: [:])
      GorldNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
      
      GorldNode.physicsBody?.categoryBitMask = Int(SunCategory)
      GorldNode.physicsBody?.contactTestBitMask = Int(Wall1Category) + Int(Wall0Category)
      GorldNode.physicsBody?.collisionBitMask = Int(BoxCategory) + Int(FloorCategoyr) + Int(SunCategory)
      GorldNode.physicsBody?.mass = 0
      
      //位置を決める
      //z is Position
      GorldNode.position = SCNVector3(0, 10027.5, 0)
      //やっとシーンに追加できる
      SceneView.scene?.rootNode.addChildNode(GorldNode)
      GorldNode.castsShadow = true
      sun = GorldNode
      
      //パーティクルシステムのオブジェクト生成、およびノードへの追加
      
      GorldNode.addParticleSystem(self.bokeh!)
      GorldNode.addParticleSystem(self.Stars!)
      GorldNode.addParticleSystem(self.GrowStar!)
      
      let Transform = SCNTransformConstraint(inWorldSpace: true, with: { (sun, transform) -> SCNMatrix4 in
         let pos = sun.position
         return SCNMatrix4MakeTranslation(pos.x, pos.y - 7.5, pos.z)
      })
      
      let LookAt = SCNLookAtConstraint(target: sun)
      
      let Replicator = SCNReplicatorConstraint(target: sun)
      
      let Distance = SCNDistanceConstraint(target: sun)
      Distance.maximumDistance = 11
      Distance.minimumDistance = 7.5
      
      
      let Acceleration = SCNAccelerationConstraint()
      
      Acceleration.maximumLinearVelocity = 150
      Acceleration.maximumLinearAcceleration = 150
      
      
      LookAt.isGimbalLockEnabled = false
      LookAt.influenceFactor = 0.001
      Replicator.replicatesPosition = true
      
      //Camera_Node.constraints = [LookAt, Acceleration ]
      
      
      scene.rootNode.addChildNode(Camera_Node)
      
      
      print("Bounds width: \(Size.width) height: \(Size.height)")
      //use Size.width or Size.height
      
      let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panView(sender:)))  //Swift3
      self.view.addGestureRecognizer(panGesture)
      
      
      // サウンドファイルのパスを生成
      let soundFilePath = Bundle.main.path(forResource: "pan", ofType: "mp3")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
      } catch {
         print("AVAudioPlayerインスタンス作成失敗")
      }
      // バッファに保持していつでも再生できるようにする
      audioPlayerInstance.prepareToPlay()
      
      //sksceneの生成。スコア表示に使う。
      let skScene = SKScene()
      skScene.size = CGSize(width: Size.width, height: Size.height)
      
      //sceneViewの最前面にsksceneを貼り付ける。これ重要！
      SceneView.overlaySKScene = skScene
      
      //overlayするノード
      var overlayNode: SKNode
      overlayNode = SKNode()
      overlayNode.position = CGPoint(x: 0.0, y: Size.height)
      skScene.addChild(overlayNode)
      
      
      // Setup the game overlays using SpriteKit.
      //scaleMode = .resizeFill
      
      let ScoreLabel = SKLabelNode(text: String(score))
      ScoreLabel.fontSize = 75
      ScoreLabel.fontName = "HelveticaNeue-Medium"
      //y座標はマイナスで下側に。
      ScoreLabel.position = CGPoint(x: Size.width / 8, y: -Size.height / 8)
      ScoreLabel.xScale = 0.5
      ScoreLabel.yScale = 0.5
      overlayNode.addChild(ScoreLabel)
      
      Score = ScoreLabel
      
      UserScore4.register(defaults: ["Stage4": 0])
      
      
      //7owarimade
      View.backgroundColor = UIColor.white
      View.alpha = 0.35
      View2.backgroundColor = UIColor.white
      
      InitReward()
      InitInstitial()
      StartBGM()
   }
   
   private func InitInstitial() {
      print(userDefault.integer(forKey: "PlayStage"))
      
      #if DEBUG
      print("インターステイシャル:テスト環境")
      Interstitial = GADInterstitial(adUnitID: INTERSTITIAL_TEST_ID)
      if let ADID = Interstitial.adUnitID {
         print("インタースティシャルテスト広告ID読み込み完了")
         print("TestID = \(ADID)")
      }else{
         print("インタースティシャルテスト広告ID読み込み失敗")
      }
      #else
      print("インターステイシャル:本番環境")
      Interstitial = GADInterstitial(adUnitID: INTERSTITIAL_ID)
      #endif
      
      self.Interstitial.delegate = self
      Interstitial.load(GADRequest())
   }
   
   private func InitReward() {
      rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
      rewardBasedVideo?.delegate = self
      #if DEBUG
      print("リワード:テスト環境")
      rewardBasedVideo?.load(GADRequest(), withAdUnitID: TEST_ID)
      print("ID = \(TEST_ID)")
      #else
      print("リワード:本番環境")
      rewardBasedVideo?.load(GADRequest(), withAdUnitID: AdMobID)
      print("ID = \(AdMobID)")
      #endif
      
      
   }
   
   private func StartBGM() {
      gameBGM.PlaySounds()
   }
   
   func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
      
      let firstNode = contact.nodeA
      let secondNode = contact.nodeB
      
      let WallPosiX = Int(firstNode.position.x + 1.2)
      let WallPosiY = 499 - Int((firstNode.position.y + 2) / 20)
      let WallPosiZ = Int(firstNode.position.z + 1.2)
      let num = Int(arc4random_uniform(5))
      
      
      if WallPosiY == hozon {
         return
      }
      
      hozon = WallPosiY
      
      //点数処理
      score += 1
      Score.text = String(score)
      
      ///処理
      if wall[WallPosiY][WallPosiX][WallPosiZ] == 0  && watch == 0{
         if num == 0 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "green")
            watch = 0
         }else if num == 1 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "red")
            watch = 1
         }else if num == 2 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
            watch = 2
         }else if num == 3 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
            watch = 3
         }else if num == 4 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
            watch = 4
         }
         Play3DtouchHeavy()
         
         
      }else if wall[WallPosiY][WallPosiX][WallPosiZ] == 1  && watch == 1{
         
         if num == 0 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "green")
            watch = 0
         }else if num == 1 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "red")
            watch = 1
         }else if num == 2 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
            watch = 2
         }else if num == 3 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
            watch = 3
         }else if num == 4 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
            watch = 4
         }
         Play3DtouchHeavy()
         
      }else if wall[WallPosiY][WallPosiX][WallPosiZ] == 2  && watch == 2{
         
         if num == 0 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "green")
            watch = 0
            
         }else if num == 1 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "red")
            watch = 1
            
         }else if num == 2 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
            watch = 2
         }else if num == 3 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
            watch = 3
         }else if num == 4 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
            watch = 4
         }
         Play3DtouchHeavy()
         
      }else if wall[WallPosiY][WallPosiX][WallPosiZ] == 3  && watch == 3{
         
         if num == 0 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "green")
            watch = 0
            
         }else if num == 1 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "red")
            watch = 1
            
         }else if num == 2 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
            watch = 2
         }else if num == 3 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
            watch = 3
         }else if num == 4 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
            watch = 4
         }
         Play3DtouchHeavy()
         
      }else if wall[WallPosiY][WallPosiX][WallPosiZ] == 4  && watch == 4{
         
         if num == 0 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "green")
            watch = 0
            
         }else if num == 1 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "red")
            watch = 1
            
         }else if num == 2 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kiiro")
            watch = 2
         }else if num == 3 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "murasaki")
            watch = 3
         }else if num == 4 {
            sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "kimidori")
            watch = 4
         }
         Play3DtouchHeavy()
         
      }else{
         //失敗
         AudioServicesPlaySystemSound(1521);
         AudioServicesPlaySystemSound(1521);
         
         GameOver()
         return
      }
      
      firstNode.removeFromParentNode()
      
      if secondNode == sun {
         
         // オペレーションキューを生成。
         let queue0 = OperationQueue()
         // オペレーションオブジェクトを生成。
         // Swiftの場合、クロージャを使うといい。
         let operation0 = BlockOperation {
            // 並列で行いたい処理
            self.sun.addParticleSystem(self.key3!)
            self.sun.addParticleSystem(self.key1!)
            
            self.sun.addParticleSystem(self.key2!)
            
            self.audioPlayerInstance.volume = 0.35
            self.audioPlayerInstance.currentTime = 0
            self.audioPlayerInstance.play()
         }
         queue0.addOperation(operation0)
         
         self.sun.removeAllActions()
         dr += PlusSpeed
         PlusSpeed += PlusSpeed / 110
      }
   }
   
   func renderer(_ aRenderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
      
      self.Camera_Node.position.y = self.sun.position.y + 8
      self.SpotLightNode.position.y  =  self.sun.position.y + 58
      
      // per-frame code here
      if sun.position.z > 1.5 {
         Play3DtouchLight()
         self.sun.position.z = 1.5
      }
      if sun.position.z < -1.5 {
         Play3DtouchLight()
         self.sun.position.z = -1.5
      }
      
      if sun.position.x > 1.5 {
         Play3DtouchLight()
         self.sun.position.x = 1.5
      }
      if sun.position.x < -1.5 {
         Play3DtouchLight()
         self.sun.position.x = -1.5
      }
      
      guard LockSunMove == false else {
         return
      }
      
      self.sun.position.y -= FoundSpeed + dr + dr / 15
   }
   
   
   
   @objc func panView(sender: UIPanGestureRecognizer) {
      //移動後の相対位置を取得
      let location: CGPoint = sender.translation(in: self.view)  //Swift3
      let x = CGFloat(location.x / 80)
      let z = CGFloat(location.y / 80)
      
      
      let queue = OperationQueue()
      let operation = BlockOperation {
         self.sun.position.z = self.sun.position.z + Float(z)
         self.sun.position.x = self.sun.position.x + Float(x)
         self.SpotLightNode.position.x = self.sun.position.x
         self.SpotLightNode.position.z = self.sun.position.z
      }
      queue.addOperation(operation)
      sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
   }
   
   
   func GameOver(){
      
      gameBGM.BeSmallSound()
      sun.removeAllActions()
      LockSunMove = true
      
      if RewardAD == true {
         
         RewardAD = false
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            
            
            let Appearanse = SCLAlertView.SCLAppearance(showCloseButton: false)
            let ComleateView = SCLAlertView(appearance: Appearanse)
            ComleateView.addButton(NSLocalizedString("ReTry", comment: "")){
               print("tap ReTry")
               self.gameBGM.StopSound()
               if GADRewardBasedVideoAd.sharedInstance().isReady && self.adRedy {
                  GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
                  self.adRedy = false
                  self.NOT_TryAgain()
               }else{
                  self.NOT_TryAgain()
               }
            }
            ComleateView.addButton(NSLocalizedString("Return", comment: "")){
               print("tap Return")
               self.Return()
            }
            
            let YourScoerIs = "Your Score is " + String(self.score - 1)
            
            ComleateView.showWarning(NSLocalizedString("Game Over", comment: ""), subTitle: YourScoerIs)
         }
         
      }else{
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.Return()
         }
      }
   }
   
   func NOT_TryAgain() {
      
      self.View2.removeFromSuperview()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.54) {
         
         self.View2.frame = CGRect(x: self.Size.width / 4, y: self.Size.height / 2, width: self.Size.width / 2, height: self.Size.height / 4)
         self.View2.backgroundColor = UIColor.flatWhiteColorDark()
         
         let RestartButton = FUIButton(frame: CGRect(x: 0, y: 0, width: self.View2.frame.width, height: self.View2.frame.height))
         RestartButton.titleLabel?.adjustsFontSizeToFitWidth = true
         RestartButton.titleLabel?.adjustsFontForContentSizeCategory = true
         RestartButton.buttonColor = UIColor.turquoise()
         RestartButton.shadowColor = UIColor.greenSea()
         RestartButton.shadowHeight = 3.0
         RestartButton.cornerRadius = 6.0
         RestartButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
         RestartButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
         RestartButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
         RestartButton.setTitle(NSLocalizedString(NSLocalizedString("Return", comment: ""), comment: ""), for: .normal)
         RestartButton.addTarget(self, action: #selector(self.Return), for: .touchUpInside)
         
         self.View2.addSubview(RestartButton)
         
         self.view.addSubview(self.View2)
      }
   }
   
   
   //10
   @objc func TryAgain() {
      
      self.View2.removeFromSuperview()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.54) {
         
         self.View2.frame = CGRect(x: self.Size.width / 4, y: self.Size.height / 2, width: self.Size.width / 2, height: self.Size.height / 4)
         self.View2.backgroundColor = UIColor.flatWhiteColorDark()
         
         let RestartButton = FUIButton(frame: CGRect(x: 0, y: 0, width: self.View2.frame.width, height: self.View2.frame.height))
         RestartButton.titleLabel?.adjustsFontSizeToFitWidth = true
         RestartButton.titleLabel?.adjustsFontForContentSizeCategory = true
         RestartButton.buttonColor = UIColor.turquoise()
         RestartButton.shadowColor = UIColor.greenSea()
         RestartButton.shadowHeight = 3.0
         RestartButton.cornerRadius = 6.0
         RestartButton.titleLabel?.font = UIFont.boldFlatFont (ofSize: 16)
         RestartButton.setTitleColor(UIColor.clouds(), for: UIControl.State.normal)
         RestartButton.setTitleColor(UIColor.clouds(), for: UIControl.State.highlighted)
         RestartButton.setTitle(NSLocalizedString(NSLocalizedString("ReStart", comment: ""), comment: ""), for: .normal)
         RestartButton.addTarget(self, action: #selector(self.ReStart), for: .touchUpInside)
         
         self.View2.addSubview(RestartButton)
         self.view.addSubview(self.View2)
      }
   }
   
   @objc func ReStart() {
      
      self.View2.removeFromSuperview()
      gameBGM.RestartSound()
      
      let BallBackAnimation = SCNAction.move(to: SCNVector3(self.sun.position.x, self.sun.position.y + 17.5, self.sun.position.z), duration: 1.35)
      self.sun.runAction(BallBackAnimation)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
         let queue = OperationQueue()
         let operation = BlockOperation {
            //self.sun.runAction(self.AfterAction)
            self.LockSunMove = false
         }
         self.Speed -= 4
         //self.AfterAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: self.Speed)
         queue.addOperation(operation)
         
      }
      
   }
   
   
   @objc func Return() {
      
      let HightScore4: Int = UserScore4.object(forKey: "Stage4") as! Int
 
      Analytics.logEvent("GamePlayCount", parameters: ["GamePlaylayCount": 1 as Int])
      Analytics.logEvent("Stage5PlayCount", parameters: ["GamePlaylayCount": 1 as Int])
      
      let UserScore = score - 1
      
      switch UserScore {
      case 0:
         Analytics.logEvent("Stage5Score0", parameters: ["Score": UserScore as Int])
      case 1 ... 9:
         Analytics.logEvent("Stage5Score1to9", parameters: ["Score": UserScore as Int])
      case 10 ... 19:
         Analytics.logEvent("Stage5Score10to19", parameters: ["Score": UserScore as Int])
      case 20 ... 29:
         Analytics.logEvent("Stage5Score20to29", parameters: ["Score": UserScore as Int])
      case 30 ... 39:
         Analytics.logEvent("Stage5Score30to39", parameters: ["Score": UserScore as Int])
      case 40 ... 49:
         Analytics.logEvent("Stage5Score40to49", parameters: ["Score": UserScore as Int])
      case 50 ... 59:
         Analytics.logEvent("Stage5Score50to59", parameters: ["Score": UserScore as Int])
      case 60 ... 69:
         Analytics.logEvent("Stage5Score60to69", parameters: ["Score": UserScore as Int])
      case 70 ... 79:
         Analytics.logEvent("Stage5Score70to79", parameters: ["Score": UserScore as Int])
      case 80 ... 89:
         Analytics.logEvent("Stage5Score80to89", parameters: ["Score": UserScore as Int])
      case 90 ... 99:
         Analytics.logEvent("Stage5Score90to99", parameters: ["Score": UserScore as Int])
      case 100 ... 10000:
         Analytics.logEvent("Stage5ScoreOver100", parameters: ["Score": UserScore as Int])
      default:
         Analytics.logEvent("ErroScore5", parameters: ["Score": UserScore as Int])
      }
      
      
      if HightScore4 < score {
         UserScore4.set(score - 1, forKey: "Stage4")
         UserScore4.synchronize()
         
         //send score
         let SendScore: GKScore = GKScore()
         SendScore.value = Int64(score - 1)
         SendScore.leaderboardIdentifier = LEADERBOARD_ID
         
         let scoreArr: [GKScore] = [SendScore]
         GKScore.report(scoreArr, withCompletionHandler: {(error: NSError?) -> Void in
            if error != nil {
               print("report score error")
            } else {
               print("report score OK")
            }
            } as? (Error?) -> Void)
         //send score finished
      }
      
      self.MyTimer.invalidate()
      if userDefault.integer(forKey: "PlayStage") % 3 == 0{
         if Interstitial.isReady {
            print("インタースティシャル広告の準備できてるからpresentする!")
            Interstitial.present(fromRootViewController: self)
            return
         }else{
            self.dismiss(animated: true)
            return
         }
      }
      self.dismiss(animated: true)
      
      
   }
   
   
   // MARK: GADRewardBasedVideoAdDelegate implementation
   func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
      adRequestInProgress = false
      print("reword:失敗したよ（準備できてない？）: \(error.localizedDescription)")
   }
   
   func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      adRequestInProgress = false
      adRedy = true
      print("動画の準備整ったよ")
   }
   
   func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("動画プレイヤーが開かれたよ。")
   }
   
   func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("動画の再生を開始っ！")
   }
   
   func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      #if DEBUG
      print("リワード:テスト環境")
      rewardBasedVideo?.load(GADRequest(), withAdUnitID: TEST_ID)
      print("ID = \(TEST_ID)")
      #else
      print("リワード:本番環境")
      rewardBasedVideo?.load(GADRequest(), withAdUnitID: AdMobID)
      print("ID = \(AdMobID)")
      #endif
      
   }
   
   func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Reward based video ad will leave application.\n呼ばれないらしい。")
   }
   
   //ココの関数に特典を与える処理を入れる
   func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
      self.TryAgain()
      
   }
   
   //GKGameCenterControllerDelegate実装用
   func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
      gameCenterViewController.dismiss(animated: true, completion: nil)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   //広告の読み込みが完了した時
   func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("\n-- Interstitial広告の読み込み完了 --\n")
      //Analytics.logEvent("AdReadyOK", parameters: nil)
   }
   //広告の読み込みが失敗した時
   func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("\n-- Interstitial広告の読み込み失敗 --\n")
      //Analytics.logEvent("AdNotReady", parameters: nil)
      
   }
   //広告画面が開いた時
   func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告開いた")
      gameBGM.StopSound()
   }
   //広告をクリックして開いた画面を閉じる直前
   func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告閉じる直前")
   }
   //広告をクリックして開いた画面を閉じる直後
   func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("インタースティシャル広告閉じる直後")
      AudioServicesPlaySystemSound(1519)
      
      self.dismiss(animated: true)
   }
   //広告をクリックした時
   func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("インタースティシャル広告ボタンクリックした")
   }
   
   
   private func Play3DtouchLight()  {
      DispatchQueue.main.async {
         TapticEngine.impact.feedback(.light)
      }
   }
   
   private func Play3DtouchMedium() {
      DispatchQueue.main.async {
         TapticEngine.impact.feedback(.medium)
      }
   }
   
   private func Play3DtouchHeavy()  {
      DispatchQueue.main.async {
         TapticEngine.impact.feedback(.heavy)
      }
      
   }
   
}
