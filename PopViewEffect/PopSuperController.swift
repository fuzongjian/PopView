//
//  PopSuperController.swift
//  PopViewEffect
//
//  Created by 陈舒澳 on 16/5/20.
//  Copyright © 2016年 speeda. All rights reserved.
//

import UIKit
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
class PopSuperController: UIViewController {
    var popView: UIView?
    var mainVc: UIViewController?
    var rootView: UIView?
    var coverView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func createPopAndRoot(root: UIViewController,pop: UIView){
        mainVc = root
        popView = pop
        
        self.view.backgroundColor = UIColor.blackColor()// 最底下一层
        mainVc?.view.frame = self.view.bounds
        mainVc?.view.backgroundColor = UIColor.grayColor()
        rootView = mainVc?.view
        self.addChildViewController(mainVc!)
        self.view.addSubview(rootView!)
    }
    func popViewOpen(){
        UIApplication.sharedApplication().windows[0].addSubview(popView!)
        var frame = popView?.frame
        frame?.origin.y = self.view.bounds.size.height - (self.popView?.frame.size.height)!
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.rootView?.layer.transform = self.firstTransform()
            }) { (bool) -> Void in
                self.rootView?.layer.transform = self.secondTransform()
                
                self.coverView = UIView(frame: self.view.bounds)
                self.coverView?.backgroundColor = UIColor.blackColor()
                self.coverView?.alpha = 0.5
                self.rootView?.addSubview(self.coverView!)
                
                self.popView?.frame = frame!
        }
        
        
    }
    func popViewClose(){
        var frame = popView?.frame
        frame?.origin.y += (popView?.frame.size.height)!
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.coverView?.alpha = 0.0
            self.popView?.frame = frame!
            self.rootView?.layer.transform = self.firstTransform()
            }) { (bool) -> Void in
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                    self.rootView?.layer.transform = CATransform3DIdentity
                    }, completion: { (bool) -> Void in
                        self.popView?.removeFromSuperview()
                })
        }
    }
    func firstTransform() ->CATransform3D{
        var Identity = CATransform3DIdentity
        Identity.m34 = -1.0/900
        Identity = CATransform3DScale(Identity, 0.95, 0.95, 1)//带点缩小效果
        Identity = CATransform3DRotate(Identity, 15.0 * (CGFloat)(M_PI)/180.0, 1, 0, 0)// 绕X轴旋转
        return Identity
    }
    func secondTransform() ->CATransform3D{
        var identity = CATransform3DIdentity
        identity.m34 = firstTransform().m34
        identity = CATransform3DTranslate(identity, 0, self.view.frame.size.height * (-0.08), 0)// 上移
        identity = CATransform3DScale(identity, 0.8, 0.8, 1)// 第二次缩小
        return identity
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
