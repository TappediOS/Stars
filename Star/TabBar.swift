//
//  TabBar.swift
//  Star
//
//  Created by jun on 2018/08/14.
//  Copyright © 2018年 jun. All rights reserved.
//


import UIKit
import Foundation


class MyTabBarViewController: UITabBarController{
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      //レンダリングモードをAlwaysOriginalでボタンの画像を登録する。
      tabBar.items![0].image = UIImage(named: "stage1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      tabBar.items![1].image = UIImage(named: "stage2.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      tabBar.items![2].image = UIImage(named: "toprate.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      tabBar.items![3].image = UIImage(named: "stage3.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      tabBar.items![4].image = UIImage(named: "stage4.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      
      
      // 選択時のカラー（アイコン＋テキスト）
      //self.tabBar.tintColor = UIColor.cyan
      
   }
   
   
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}


