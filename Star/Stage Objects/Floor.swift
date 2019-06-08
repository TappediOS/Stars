//
//  File.swift
//  Star
//
//  Created by jun on 2019/06/08.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation
import SceneKit

class StageFloor : SCNFloor {
   
   
   override init() {
   
      super.init()
      
      self.reflectivity = 0.5
      self.firstMaterial?.diffuse.contents = UIImage(named: "Snow1")
      self.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(512 / 30, 1024 / 30, 0)
      let floorNode = SCNNode(geometry: self)
      let floorShape = SCNPhysicsShape(geometry: self, options: nil)
      let floorBody = SCNPhysicsBody(type: .static, shape: floorShape)
      floorNode.physicsBody = floorBody
      floorNode.physicsBody?.friction = 1
      floorNode.physicsBody?.restitution = 1
//      floorNode.physicsBody?.contactTestBitMask = 0
//      floorNode.physicsBody?.collisionBitMask = Int(BoxCategory) + Intself
//      floorNode.physicsBody?.categoryBitMask = Int(FloorCategoyr)
//      
//      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
