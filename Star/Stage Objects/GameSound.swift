//
//  GameSound.swift
//  Star
//
//  Created by jun on 2019/06/12.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import AVFoundation

class BGM {
   
   var gameBGM: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.165
   let SmallSoundVolume: Float = 0.165 / 3
   
   
   init() {
      
      // サウンドファイルのパスを生成
      let soundFilePath = Bundle.main.path(forResource: "StarBGM", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         gameBGM = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
         
      } catch {
         print("Katchインスタンス作成失敗")
      }
      
      
      gameBGM.prepareToPlay()
      gameBGM.numberOfLoops = -1
      
   }
   
   public func PlaySounds() {
      self.gameBGM.volume = 0
      self.gameBGM.stop()
      self.gameBGM.currentTime = 0
      self.gameBGM.volume = SoundVolume
      self.gameBGM.play()
   }
   
   public func BeSmallSound() {
      self.gameBGM.volume = SmallSoundVolume
   }
   
   public func StopSound() {
      self.gameBGM.stop()
   }
   
   public func RestartSound() {
      self.gameBGM.volume = SoundVolume
      self.gameBGM.play()
   }
   
}

