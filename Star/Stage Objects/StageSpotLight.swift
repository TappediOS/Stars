//
//  StageSpotLight.swift
//  Star
//
//  Created by jun on 2019/06/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SceneKit

class StageSpotLight: SCNNode {
   
   override init() {
      super.init()
      
      self.light = SCNLight()
      self.light?.type = SCNLight.LightType.spot
      self.light?.intensity = 260
      self.light?.castsShadow = true
      self.position = SCNVector3(x: 0, y: 10035, z: 0)
      self.eulerAngles.x = -90
      self.light?.spotOuterAngle = 65
      self.light?.spotInnerAngle = 48
      self.light?.shadowMapSize.width = 5000
      self.light?.shadowMapSize.height = 5000
      self.light?.zNear = 48
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
