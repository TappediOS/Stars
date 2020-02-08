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
      self.light?.intensity = 265
      self.light?.castsShadow = true
      self.position = SCNVector3(x: 0, y: 10035, z: 0)
      self.eulerAngles.x = -90
      self.light?.spotOuterAngle = 66
      self.light?.spotInnerAngle = 49
      self.light?.shadowMapSize.width = 5100
      self.light?.shadowMapSize.height = 5100
      self.light?.zNear = 51
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
