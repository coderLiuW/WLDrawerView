//
//  DrawerViewController.swift
//  抽屉效果
//
//  Created by administrator on 2017/3/10.
//  Copyright © 2017年 WL. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    
    let screenW = UIScreen.main.bounds.width

    var mainVC: UIViewController?
    var leftVC: UIViewController?
    var maxWidth: CGFloat = 300
    //MARK: - 单例
    static let shareDrawer = UIApplication.shared.keyWindow?.rootViewController as? DrawerViewController
    
    init(mainVC: UIViewController, leftMenuVC: UIViewController, leftWidth: CGFloat) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.mainVC = mainVC
        self.leftVC = leftMenuVC
        self.maxWidth = leftWidth
    
        view.addSubview(leftMenuVC.view)
        view.addSubview(mainVC.view)
        
        addChildViewController(leftMenuVC)
        addChildViewController(mainVC)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        leftVC?.view.transform = CGAffineTransform(translationX: -maxWidth , y: 0)
        
        for childViewController in (mainVC?.childViewControllers)! {
            
            addScreenEdgePanGestureRecognizerToView(view: childViewController.view)
            
        }
        
    }
    
    //MARK: - 侧边栏跳转功能
    func LeftViewController(didSelectController view: UIViewController) {
        
        let tabbarVC = mainVC as? UITabBarController
        let nav = tabbarVC?.selectedViewController as? UINavigationController
        view.hidesBottomBarWhenPushed = true
        nav?.pushViewController(view, animated: false)
        closeLeftMenu()
    }
    
    //MARK: - 添加屏幕边缘手势
    private func addScreenEdgePanGestureRecognizerToView(view: UIView) {
        
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgPanGesture(_:)))
        pan.edges = UIRectEdge.left
        view.addGestureRecognizer(pan)
        
    }
    
    //MARK: - 屏幕左边缘手势
    func edgPanGesture(_ pan: UIScreenEdgePanGestureRecognizer) {
        
        let offsetX = pan.translation(in: pan.view).x
        print(offsetX)
        if pan.state == UIGestureRecognizerState.changed && offsetX <= maxWidth {
            
            mainVC?.view.transform = CGAffineTransform(translationX: max(offsetX, 0), y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: -maxWidth + offsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > screenW * 0.5 {
                
                openLeftMenu()
                
            } else {
                
                closeLeftMenu()
            }
            
        }
        
    }
    
    //MARK: - 遮盖按钮手势
    func panCloseLeftMenu(_ pan: UIPanGestureRecognizer) {
        
        let offsetX = pan.translation(in: pan.view).x
        
        print(offsetX)
        if offsetX > 0 {return}
        
        if pan.state == UIGestureRecognizerState.changed && offsetX >= -maxWidth {
            
            let distace = maxWidth + offsetX
            
            mainVC?.view.transform = CGAffineTransform(translationX: distace, y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: offsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > -screenW * 0.5 {
                
                openLeftMenu()
                
            } else {
                
                closeLeftMenu()
            }
            
        }
        
    }
    
    //MARK: - 打开左侧菜单
    func openLeftMenu() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
        
            self.leftVC?.view.transform = CGAffineTransform.identity
            self.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWidth, y: 0)
            
        
        }, completion: {
        
            (finish: Bool) -> () in
            
            self.mainVC?.view.addSubview(self.coverBtn)
            
        })
        
    }
    
    //MARK: - 关闭左侧菜单
    func closeLeftMenu() {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            self.leftVC?.view.transform = CGAffineTransform(translationX: -self.maxWidth, y: 0)
            self.mainVC?.view.transform = CGAffineTransform.identity
            
            
        }, completion: {
            
            (finish: Bool) -> () in
            
            self.coverBtn.removeFromSuperview()
            
        })
        
        
    }
    
    //MARK: - 灰色背景按钮
    private lazy var coverBtn: UIButton = {
        
        let btn = UIButton(frame: (self.mainVC?.view.bounds)!)
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(closeLeftMenu), for: .touchUpInside)
        btn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCloseLeftMenu(_:))))
        
        return btn
        
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
