//
//  TabBar.swift
//  Star
//
//  Created by jun on 2018/08/14.
//  Copyright © 2018年 jun. All rights reserved.
//


import UIKit
import Foundation
import ChameleonFramework

class MyTabBarViewController: UITabBarController{


    override func viewDidLoad() {
        super.viewDidLoad()


        //レンダリングモードをAlwaysOriginalでボタンの画像を登録する。
        tabBar.items![0].image = get1Image()
        tabBar.items![1].image = get2Image()
        tabBar.items![2].image = getStarImage()
        tabBar.items![3].image = get3Image()
        tabBar.items![4].image = get4Image()


        tabBar.items![0].selectedImage = get1FillImage()
        tabBar.items![1].selectedImage = get2FillImage()
        tabBar.items![2].selectedImage = getStarFillImage()
        tabBar.items![3].selectedImage = get3FillImage()
        tabBar.items![4].selectedImage = get4FillImage()



        tabBar.tintColor = .systemRed
        //self.tabBar.tintColor = UIColor.cyan

    }


    private func get1Image() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "1.circle")!
        }else{
            return UIImage(named: "stage1.png")!
        }
    }

    private func get1FillImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "1.circle.fill")!
        }else{
            return UIImage(named: "stage1.png")!
        }
    }

    private func get2Image() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "2.circle")!
        }else{
            return UIImage(named: "stage2.png")!
        }
    }

    private func get2FillImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "2.circle.fill")!
        }else{
            return UIImage(named: "stage2.png")!
        }
    }

    private func getStarImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "star")!
        }else{
            return UIImage(named: "toprate.png")!
        }
    }

    private func getStarFillImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "star.fill")!
        }else{
            return UIImage(named: "toprate.png")!
        }
    }

    private func get3Image() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "3.circle")!
        }else{
            return UIImage(named: "stage3.png")!
        }
    }

    private func get3FillImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "3.circle.fill")!
        }else{
            return UIImage(named: "stage3.png")!
        }
    }

    private func get4Image() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "4.circle")!
        }else{
            return UIImage(named: "stage4.png")!
        }
    }

    private func get4FillImage() -> UIImage {
        if #available(iOS 13, *) {
            return UIImage(systemName: "4.circle.fill")!
        }else{
            return UIImage(named: "stage4.png")!
        }
    }






    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


