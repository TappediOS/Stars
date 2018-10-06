//
//  GameOverViewController.swift
//  Star
//
//  Created by jun on 2018/08/11.
//  Copyright © 2018年 jun. All rights reserved.
//



import UIKit
import Foundation


class GameOverViewController: UIViewController{
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = UIColor.white
      
      let ReturnButton = UIButton()
      ReturnButton.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
      ReturnButton.backgroundColor = UIColor.blue
      ReturnButton.addTarget(self, action: #selector(GameOverViewController.Return), for: .touchUpInside)
      view.addSubview(ReturnButton)
     
      
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

