//
//  GameSound.swift
//  Star
//
//  Created by jun on 2019/06/12.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import AVFoundation
import FirebaseRemoteConfig

class BGM {
   
   var gameBGM: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.165
   let SmallSoundVolume: Float = 0.165 / 3
   
   var remoteConfig: RemoteConfig!
   
   let playBGMKey = "play_bgm_key"
   
   init() {
      initRemoteConfig()
      fetchConfigFromFirebase()
   }
   
   private func initRemoteConfig() {
      self.remoteConfig = RemoteConfig.remoteConfig()
      let remoconSetting = RemoteConfigSettings()
      #if DEBUG
      remoconSetting.minimumFetchInterval = 0
      #else
      remoconSetting.minimumFetchInterval = 3600
      #endif
      self.remoteConfig.configSettings = remoconSetting
      self.remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
   }
   
   private func fetchConfigFromFirebase() {
      let expirationDuration: TimeInterval
      #if DEBUG
      expirationDuration = 0
      #else
      expirationDuration = 3600
      #endif
      self.remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) -> Void in
         if status != .success {
            print("Config Not Fetched!!")
            print("Error: \(error?.localizedDescription ?? "No error availble.")")
            return
         }
         print("Config Fetch Success!!")
         print("\(String(describing: self.remoteConfig[self.playBGMKey].stringValue))")
         self.remoteConfig.activate(completionHandler: { (error) in
            if let error = error {
               print("config active error.")
               print("Error: \(error.localizedDescription)")
            }
         })
         self.setUpBGM()
      }
      
   }
   
   func setUpBGM() {
      let playBGMStr: String = self.remoteConfig[self.playBGMKey].stringValue ?? "darkSpace"
      
      let soundFilePath = Bundle.main.path(forResource: playBGMStr, ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         gameBGM = try AVAudioPlayer(contentsOf: sound, fileTypeHint: nil)
         
      } catch {
         print("Katchインスタンス作成失敗")
         return
      }
      
      gameBGM.prepareToPlay()
      gameBGM.numberOfLoops = -1
      gameBGM.play()

   }
   
   public func PlaySounds() {
      if gameBGM == nil { return }
      if gameBGM.isPlaying { return }
      
      self.gameBGM.volume = 0
      self.gameBGM.stop()
      self.gameBGM.currentTime = 0
      self.gameBGM.volume = SoundVolume
      self.gameBGM.play()
   }
   
   public func BeSmallSound() {
      if gameBGM == nil { return }
      self.gameBGM.volume = SmallSoundVolume
   }
   
   public func StopSound() {
      if gameBGM == nil { return }
      self.gameBGM.stop()
   }
   
   public func RestartSound() {
      if gameBGM == nil { return }
      self.gameBGM.volume = SoundVolume
      self.gameBGM.play()
   }
   
}

