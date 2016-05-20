//
//  ViewController.swift
//  PopViewEffect
//
//  Created by 陈舒澳 on 16/5/20.
//  Copyright © 2016年 speeda. All rights reserved.
//

import UIKit

class ViewController: PopSuperController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    func initView(){
        let popView = UIView(frame: CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT/2))
        popView.backgroundColor = UIColor.grayColor()
        
        let closeButton = UIButton(type: .System)
        closeButton.frame = CGRectMake(0, 20, 100, 50)
        var newCenter = closeButton.center
        newCenter.x = popView.center.x
        closeButton.center = newCenter
        closeButton.setTitle("关闭", forState: .Normal)
        popView.addSubview(closeButton)
        closeButton.addTarget(self, action: "closeButtonClicked:", forControlEvents: .TouchUpInside)
        
        
        let mainController = UIViewController()
        mainController.view.backgroundColor = UIColor.whiteColor()
        let mainNav = UINavigationController(rootViewController: mainController)
        
        
        let startButton = UIButton(type: .System)
        startButton.frame = CGRectMake(100, 100, 100, 50)
        var center = startButton.center
        center.x = mainController.view.center.x
        startButton.center = center
        startButton.backgroundColor = UIColor.redColor()
        startButton.setTitle("打开", forState: .Normal)
        startButton.addTarget(self, action: "startButtonClicked:", forControlEvents: .TouchUpInside)
        mainController.view.addSubview(startButton)
        
        createPopAndRoot(mainNav, pop: popView)
        
    }
    func closeButtonClicked(sender: UIButton){
        popViewClose()
        print("closeButtonClicked")
    }
    func startButtonClicked(sender: UIButton){
        popViewOpen()
        print("startButtonClicked")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

