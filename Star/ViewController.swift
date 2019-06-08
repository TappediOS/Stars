//
//  ViewController.swift
//  Star
//
//  Created by jun on 2018/07/04.
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
//1
import GoogleMobileAds

//2
class ViewController: UIViewController, SCNPhysicsContactDelegate, GKGameCenterControllerDelegate, SCNSceneRendererDelegate, GADRewardBasedVideoAdDelegate {
   
   var wall:[[[Int]]] = [[[]]]
   
   var score:Int = 0
   var Action = SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: -24, z: 0, duration: 1))
   var Speed: Double = 419
   var BeforAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: 419)
   var AfterAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: 419)
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
   var Camera_Node = SCNNode()
   var SpotLightNode = SCNNode()
   var count: Int = 100
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
   var batucount: Int = 1
   var marucount: Int = 1
   var hozon: Int = 1
   var audioPlayerInstance : AVAudioPlayer! = nil
   var Score = SKLabelNode()
   var UserScore1: UserDefaults = UserDefaults.standard
   //Leaderboard ID
   let LEADERBOARD_ID = "Stage1"
   
   
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
   
   let bokeh = SCNParticleSystem(named: "Myparticle.scnp", inDirectory: "")
   let Stars = SCNParticleSystem(named: "Stars.scnp", inDirectory: "")
   
   
   var MyTimer = Timer()

   
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
      SceneView.allowsCameraControl = false
      view.accessibilityIgnoresInvertColors = true
      
      
      let MoveSpotLightNode = SCNNode()
      MoveSpotLightNode.light = SCNLight()
      MoveSpotLightNode.light?.type = SCNLight.LightType.spot
      MoveSpotLightNode.light?.castsShadow = true
      MoveSpotLightNode.position = SCNVector3(x: 0, y: 10035, z: 0)
      MoveSpotLightNode.eulerAngles.x = -90
      MoveSpotLightNode.light?.spotOuterAngle = 65
      MoveSpotLightNode.light?.spotInnerAngle = 48
      MoveSpotLightNode.light?.shadowMapSize.width = 4500
      MoveSpotLightNode.light?.shadowMapSize.height = 4500
      MoveSpotLightNode.light?.zNear = 48
      scene.rootNode.addChildNode(MoveSpotLightNode)
      SpotLightNode = MoveSpotLightNode
      
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
      
      let CameraNode = SCNNode()
      CameraNode.camera = SCNCamera()
      CameraNode.position = SCNVector3(x: 0, y: 10035 , z: -3.5)
      CameraNode.eulerAngles.x = -90
      CameraNode.castsShadow = false
      //CameraNode.runAction(AfterAction)
      scene.rootNode.addChildNode(CameraNode)
      Camera_Node = CameraNode
      
      wall.removeAll()
      
      for tmp in 0 ... 126 {
         batucount = 1
         marucount = 1
         
         wall.append([[0, 0, 0], [0, 0, 0], [0, 0, 0]])
         
         for x in 0 ... 2 {
            for y in 0 ... 2 {
               var num = Int(arc4random_uniform(2))
               if marucount >= 3 && num == 1 {
                  num = Int(arc4random_uniform(2))
               }
               if batucount == 8{
                  num = 1
               }
               wall[tmp][x][y] = num
               if num == 0 {
                  batucount += 1

               }else{
                  marucount += 1
               }
               
            }
         }
      }
      
      
      for tmp in 0 ... 126 {
         for x in 0 ... 2 {
            for y in 0 ... 2 {
               if wall[tmp][x][y] == 0 {
                  
                  let Wall0 = SCNPlane(width: 1.2, height: 1.2)
                  Wall0.firstMaterial?.diffuse.contents = UIImage(named: "batu")
                  let WallNode0 = SCNNode(geometry: Wall0)
                  let WallShape0 = SCNPhysicsShape(geometry: Wall0, options: nil)
                  WallNode0.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape0)
                  WallNode0.physicsBody?.mass = 0
                  WallNode0.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode0.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2)
                  WallNode0.physicsBody?.categoryBitMask = Int(Wall0Category)
                  WallNode0.physicsBody?.collisionBitMask = 0
                  WallNode0.physicsBody?.contactTestBitMask = Int(SunCategory)
                  WallNode0.castsShadow = false
//                  WallNode0.light?.castsShadow = true
                  SceneView.scene?.rootNode.addChildNode(WallNode0)

                  
               }else if wall[tmp][x][y] == 1 {
                  
                  let Wall1 = SCNPlane(width: 1.19, height: 1.19)
                  Wall1.firstMaterial?.diffuse.contents = UIImage(named: "maru")
                  let WallNode1 = SCNNode(geometry: Wall1)
                  let WallShape1 = SCNPhysicsShape(geometry: Wall1, options: nil)
                  WallNode1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: WallShape1)
                  WallNode1.physicsBody?.mass = 0
                  WallNode1.eulerAngles.x = -90
                  deruta = Double(9980 - tmp * 20) + Double(y) * 0.4
                  WallNode1.position = SCNVector3(1.2 * Double(x) - 1.2, deruta, 1.2 * Double(y) - 1.2)
                  WallNode1.physicsBody?.categoryBitMask = Int(Wall1Category)
                  WallNode1.physicsBody?.collisionBitMask = 0
                  WallNode1.physicsBody?.contactTestBitMask = Int(SunCategory)
                  WallNode1.castsShadow = false
//                  WallNode1.light?.castsShadow = true
                  SceneView.scene?.rootNode.addChildNode(WallNode1)
  
                  
               }
               
            }
         }
      }
      
      let Gorld = SCNSphere(radius: 0.23)
      //テクスチャ
      Gorld.firstMaterial?.diffuse.contents = UIImage(named: "Sun")
      //ノード
      let GorldNode = SCNNode(geometry: Gorld)
      let bodyShape = SCNPhysicsShape(geometry: Gorld, options: [:])
      GorldNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
   
      GorldNode.physicsBody?.categoryBitMask = Int(SunCategory)
      GorldNode.physicsBody?.contactTestBitMask = Int(Wall1Category) + Int(Wall0Category)
      GorldNode.physicsBody?.collisionBitMask = Int(BoxCategory) + Int(FloorCategoyr) + Int(SunCategory)
      GorldNode.physicsBody?.mass = 0
      GorldNode.runAction(AfterAction)
      GorldNode.castsShadow = true
//      GorldNode.light?.castsShadow = true

   
      //位置を決める
      //z is Position
      GorldNode.position = SCNVector3(0, 10027.5, 0)
      //やっとシーンに追加できる
      SceneView.scene?.rootNode.addChildNode(GorldNode)
      sun = GorldNode
      sun.castsShadow = true
//      sun.light?.castsShadow = true
      //パーティクルシステムのオブジェクト生成、およびノードへの追加
      
      GorldNode.addParticleSystem(self.bokeh!)
      
      GorldNode.addParticleSystem(self.Stars!)

      
      //use Size.width or Size.height
      
      //FIXME:- me
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
      ScoreLabel.fontSize = 70
      //y座標はマイナスで下側に。
      ScoreLabel.position = CGPoint(x: Size.width / 8, y: -Size.height / 8)
      ScoreLabel.xScale = 0.5
      ScoreLabel.yScale = 0.5
      overlayNode.addChild(ScoreLabel)
      
      Score = ScoreLabel
      
      UserScore1.register(defaults: ["Stage1": 0])
      
      
      
      //7owarimade
      View.backgroundColor = UIColor.white
      View.alpha = 0.35
      View2.backgroundColor = UIColor.white
      View2.alpha = 0.21
      
      
      
      self.MyTimer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(ViewController.TimerUpdate(timer:)), userInfo: nil, repeats: true)
      
      
      #if DEBUG
         print("This is debug, so NOT AD")
         //SceneView.showsStatistics = true
      #else
      
         if TARGET_OS_SIMULATOR == 1 {
            print("テスト広告")
            AdUnitID = TEST_ID
         }else{
            print("本番広告")
            AdUnitID = AdMobID
         }

         rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
         rewardBasedVideo?.delegate = self

         setupRewardBasedVideoAd()
      #endif

   }
   
   @objc func TimerUpdate(timer : Timer){
     
      self.Camera_Node.position.y = self.sun.position.y + 7.5
      self.SpotLightNode.position.y  =  self.sun.position.y + 54.78125
      
   }
   
   
   //8
   func setupRewardBasedVideoAd(){
      
      if !adRequestInProgress && rewardBasedVideo?.isReady == false {
         
         rewardBasedVideo?.load(GADRequest(), withAdUnitID: AdUnitID! )
         adRequestInProgress = true
      
      }else{
         print("Error: setup RewardBasedVideoAd")
      }
   }
   

   
   
   func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
      
      
      let firstNode = contact.nodeA
      let secondNode = contact.nodeB
      
      let WallPosiX = Int(firstNode.position.x + 1.2)
      let WallPosiY = 499 - Int((firstNode.position.y + 2) / 20)
      let WallPosiZ = Int(firstNode.position.z + 1.2)
      
      if WallPosiY == hozon {
         return
      }
      
      hozon = WallPosiY
      
      //点数処理
      score += 1
      Score.text = String(score)

      ///処理
      if wall[WallPosiY][WallPosiX][WallPosiZ] == 0 {
         AudioServicesPlaySystemSound(1521);
         AudioServicesPlaySystemSound(1521);
         GameOver()
         return
      }else{
         AudioServicesPlaySystemSound(1519);

      }

      firstNode.removeFromParentNode()

      
  
      let queue0 = OperationQueue()
      let operation0 = BlockOperation {

            
         self.sun.addParticleSystem(self.key3!)
         self.sun.addParticleSystem(self.key1!)
         self.sun.addParticleSystem(self.key2!)
            
         self.audioPlayerInstance.volume = 0.05
         self.audioPlayerInstance.currentTime = 0
         self.audioPlayerInstance.play()
            
      }
      queue0.addOperation(operation0)

 
      self.sun.removeAllActions()

      self.sun.runAction(self.AfterAction)
  
      
 
      
      self.Speed -= 4
      self.AfterAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: self.Speed)

   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
   }
   
   
   @objc func panView(sender: UIPanGestureRecognizer) {
      //移動後の相対位置を取得
      let location: CGPoint = sender.translation(in: self.view)  //Swift3
      let x = CGFloat(location.x / 55) // 65
      let z = CGFloat(location.y / 55)
      
      
      let queue = OperationQueue()
      let operation = BlockOperation {
         
         //self.sun.position = SCNVector3( self.sun.position.x + Float(x), self.sun.position.y, self.sun.position.z + Float(z))
         
         self.sun.position.z +=  Float(z)
         self.sun.position.x += Float(x)
         self.Camera_Node.position.y = self.sun.position.y + 7.5
         self.SpotLightNode.position.x = self.sun.position.x
         self.SpotLightNode.position.z = self.sun.position.z
      }
      queue.addOperation(operation)



      if sun.position.z > 1.5 {
         self.sun.position.z = 1.5
      }
      if sun.position.z < -1.5 {
         self.sun.position.z = -1.5
      }

      if sun.position.x > 1.5 {
         self.sun.position.x = 1.5
      }
      if sun.position.x < -1.5 {
         self.sun.position.x = -1.5
      }
      

      sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
   }
   
   
   
   //9
   func GameOver(){
      
      sun.removeAllActions()
      
      if RewardAD == true {
      
         RewardAD = false
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {

            self.view.addSubview(self.View)
            self.View.bringSubviewToFront(self.SceneView)
            
            let ReturnButton = UIButton(frame: CGRect(x: self.Size.width / 10, y: self.Size.height * 11 / 16, width: self.Size.width * 8 / 10, height: self.Size.height / 4))
            ReturnButton.backgroundColor = UIColor.black.withAlphaComponent(0.85)
            ReturnButton.layer.cornerRadius = 10.0
            ReturnButton.layer.borderColor = UIColor.black.cgColor
            ReturnButton.setTitle(NSLocalizedString("Return", comment: ""), for: .normal)
            ReturnButton.titleLabel?.adjustsFontSizeToFitWidth = true
            ReturnButton.addTarget(self, action: #selector(ViewController.Return), for: .touchUpInside)
            self.View.addSubview(ReturnButton)
            //self.view.bringSubview(toFront: bu)
            
            let TryAgainButton = UIButton(frame: CGRect(x: self.Size.width / 10, y: self.Size.height * 6 / 16, width: self.Size.width * 8 / 10, height: self.Size.height / 4))
            TryAgainButton.backgroundColor = UIColor.black.withAlphaComponent(0.85)
            TryAgainButton.layer.cornerRadius = 10.0
            TryAgainButton.layer.borderColor = UIColor.black.cgColor
            TryAgainButton.titleLabel?.adjustsFontSizeToFitWidth = true
            TryAgainButton.setTitle(NSLocalizedString("ReTry", comment: ""), for: .normal)
            TryAgainButton.addTarget(self, action: #selector(ViewController.TryAgain), for: .touchUpInside)
            self.View.addSubview(TryAgainButton)
            
         }
         
      }else{
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.Return()
         }
      }
 
   }
   
   
   
   
   
   //10
   @objc func TryAgain() {
      
      
      print("adRedy=\(adRedy)")
      
      if GADRewardBasedVideoAd.sharedInstance().isReady && adRedy {
         GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
         adRedy = false
      }else{
         print("Error: Reward based video not ready")
      }
      
      View.removeFromSuperview()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.54) {
         self.view.addSubview(self.View2)
         self.View2.bringSubviewToFront(self.SceneView)
         
         let ReStartButton = UIButton(frame: CGRect(x: self.Size.width / 10, y: self.Size.height * 11 / 16, width: self.Size.width * 8 / 10, height: self.Size.height / 4))
         ReStartButton.backgroundColor = UIColor.black.withAlphaComponent(0.85)
         ReStartButton.layer.cornerRadius = 10.0
         ReStartButton.layer.borderColor = UIColor.black.cgColor
         //ReStartButton.setTitle(NSLocalizedString("Restart", comment: ""), for: .normal)
         ReStartButton.setTitle(NSLocalizedString("ReStart", comment: ""), for: .normal)
         ReStartButton.titleLabel?.adjustsFontSizeToFitWidth = true
         ReStartButton.addTarget(self, action: #selector(ViewController.ReStart), for: .touchUpInside)
         self.View2.addSubview(ReStartButton)
      }
      
      
   }
   
   @objc func ReStart() {
      
      View2.removeFromSuperview()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
         let queue = OperationQueue()
         let operation = BlockOperation {
            self.sun.runAction(self.AfterAction)
         }
         self.Speed -= 4
         self.AfterAction = SCNAction.move(by: SCNVector3(x: 0, y: -10000, z: 0), duration: self.Speed)
         queue.addOperation(operation)
      }
      
   }
   
   
   
   
   @objc func Return() {
      
      let HightScore1: Int = UserScore1.object(forKey: "Stage1") as! Int
      
      
      
      Analytics.logEvent("GamePlayCount", parameters: ["GamePlaylayCount": 1 as Int])
      Analytics.logEvent("Stage1PlayCount", parameters: ["GamePlaylayCount": 1 as Int])
      
      let UserScore = score - 1
      
      switch UserScore {
      case 0:
         Analytics.logEvent("Stage1Score0", parameters: ["Score": UserScore as Int])
      case 1 ... 9:
         Analytics.logEvent("Stage1Score1to9", parameters: ["Score": UserScore as Int])
      case 10 ... 19:
         Analytics.logEvent("Stage1Score10to19", parameters: ["Score": UserScore as Int])
      case 20 ... 29:
         Analytics.logEvent("Stage1Score20to29", parameters: ["Score": UserScore as Int])
      case 30 ... 39:
         Analytics.logEvent("Stage1Score30to39", parameters: ["Score": UserScore as Int])
      case 40 ... 49:
         Analytics.logEvent("Stage1Score40to49", parameters: ["Score": UserScore as Int])
      case 50 ... 59:
         Analytics.logEvent("Stage1Score50to59", parameters: ["Score": UserScore as Int])
      case 60 ... 69:
         Analytics.logEvent("Stage1Score60to69", parameters: ["Score": UserScore as Int])
      case 70 ... 79:
         Analytics.logEvent("Stage1Score70to79", parameters: ["Score": UserScore as Int])
      case 80 ... 89:
         Analytics.logEvent("Stage1Score80to89", parameters: ["Score": UserScore as Int])
      case 90 ... 99:
         Analytics.logEvent("Stage1Score90to99", parameters: ["Score": UserScore as Int])
      case 100 ... 10000:
         Analytics.logEvent("Stage1ScoreOver100", parameters: ["Score": UserScore as Int])
      default:
         Analytics.logEvent("ErroScore1", parameters: ["Score": UserScore as Int])
      }
      
      if HightScore1 < score {
         UserScore1.set(score - 1, forKey: "Stage1")
         UserScore1.synchronize()
         
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
      
      
      
      self.dismiss(animated: true)
      
      self.removeFromParent()

      
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
      setupRewardBasedVideoAd()
      print("ビデオを閉じた")

   }
   
   func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
      print("Reward based video ad will leave application.\n呼ばれないらしい。")
   }
   
   //ココの関数に特典を与える処理を入れる
   func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
      print("Reward received with currency: \(reward.type), amount \(reward.amount).")
      
      
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
