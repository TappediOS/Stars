//
//  Camera.swift
//  Star
//
//  Created by jun on 2019/06/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SceneKit


class StageCamera : SCNNode {
   
   override init() {
      super.init()
      
      self.camera = SCNCamera()
      self.position = SCNVector3(x: 0, y: 10035 , z: -3.5)
      self.eulerAngles.x = -90
      self.castsShadow = false
      
      
      self.camera?.wantsHDR = true
     
      self.camera?.motionBlurIntensity = 0.45
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
}
