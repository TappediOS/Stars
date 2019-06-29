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
   
   var audioPlayer1: AVAudioPlayer! = nil
   
   let SoundVolume: Float = 0.22
   let SmallSoundVolume: Float = 0.22 / 3
   
   
   init() {
      
      // サウンドファイルのパスを生成 魔王魂
      let soundFilePath = Bundle.main.path(forResource: "gameBGM", ofType: "caf")!
      let sound:URL = URL(fileURLWithPath: soundFilePath)
      // AVAudioPlayerのインスタンスを作成
      do {
         audioPlayer1 = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
         
      } catch {
         print("Katchインスタンス作成失敗")
      }
      
      
      audioPlayer1.prepareToPlay()
      audioPlayer1.numberOfLoops = -1
      
   }
   
   public func PlaySounds() {
      self.audioPlayer1.volume = 0
      self.audioPlayer1.stop()
      self.audioPlayer1.currentTime = 0
      self.audioPlayer1.volume = SoundVolume
      self.audioPlayer1.play()
   }
   
   public func BeSmallSound() {
      self.audioPlayer1.volume = SmallSoundVolume
   }
   
   public func StopSound() {
      self.audioPlayer1.stop()
   }
   
   public func RestartSound() {
      self.audioPlayer1.volume = SoundVolume
      self.audioPlayer1.play()
   }
   
}

