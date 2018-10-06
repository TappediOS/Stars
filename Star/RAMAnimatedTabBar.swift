//
//  RAMAnimatedTabBar.swift
//  Star
//
//  Created by jun on 2018/08/14.
//  Copyright © 2018年 jun. All rights reserved.
//


import UIKit
import Foundation


class RAMAnimatedTabBarController: UIViewController{
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 233/255, blue: 51/255, alpha: 1.0) // yellow
      
      // 背景色
      UITabBar.appearance().barTintColor = UIColor(red: 66/255, green: 74/255, blue: 93/255, alpha: 1.0)
      
   }
   
   @objc func Return(){
      
      let nextvc = MainViewController()
      self.present(nextvc, animated: false, completion: nil)
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}

