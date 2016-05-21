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
        UIApplication.sharedApplication().windows[0].addSubview(popView!)//添加到主窗口
        var frame = popView?.frame
        frame?.origin.y = self.view.bounds.size.height - (self.popView?.frame.size.height)!
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.rootView?.layer.transform = self.firstTransform()
            }) { (bool) -> Void in
                UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                    self.rootView?.layer.transform = self.secondTransform()
                    
                    self.coverView = UIView(frame: self.view.bounds)
                    self.coverView?.backgroundColor = UIColor.blackColor()
                    self.coverView?.alpha = 0.5
                    self.rootView?.addSubview(self.coverView!)
                    let tap = UITapGestureRecognizer.init(target: self, action: "coverViewGestureClicked:")
                    self.coverView?.addGestureRecognizer(tap)
                    self.popView?.frame = frame!
                    }, completion: { (bool) -> Void in
                        
                })

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
                    self.rootView?.layer.transform = CATransform3DIdentity// 还原3D设置
                    }, completion: { (bool) -> Void in
                        self.popView?.removeFromSuperview()
                })
        }
    }
    // 矩阵变换立方体旋转效果  具体参数说明
//    {
//    CGFloat m11（x缩放）, m12（y切变）, m13（）, m14（）;
//    CGFloat m21（x切变）, m22（y缩放）, m23（）, m24（）;
//    CGFloat m31（）, m32（）, m33（）, m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。当然,z方向上得有变化才会有透视效果）;
//    CGFloat m41（x平移）, m42（y平移）, m43（z平移）, m44（）;
//    };
//    
    func firstTransform() ->CATransform3D{
        var Identity = CATransform3DIdentity//获取标准默认的仿射变换矩阵
        Identity.m34 = -1.0/900// 透视效果
        Identity = CATransform3DScale(Identity, 0.95, 0.95, 1)//x、y、z放大缩小的倍数
        Identity = CATransform3DRotate(Identity, 15.0 * (CGFloat)(M_PI)/180.0, 1, 0, 0)// 绕哪一个方向旋转、及旋转角度（弧度制）
        return Identity
    }
    func secondTransform() ->CATransform3D{
        var identity = CATransform3DIdentity
        identity.m34 = firstTransform().m34
        identity = CATransform3DTranslate(identity, 0, self.view.frame.size.height * (-0.08), 0)// 位移变化
        identity = CATransform3DScale(identity, 0.8, 0.8, 1)// 第二次缩小
        return identity
    }
    func coverViewGestureClicked(tap: UIGestureRecognizer){
        popViewClose()
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
