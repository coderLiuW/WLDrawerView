//
//  MessageViewController.swift
//  抽屉效果
//
//  Created by administrator on 2017/3/10.
//  Copyright © 2017年 WL. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - 打开左边菜单
    @IBAction func buttonClick(_ sender: UIBarButtonItem) {
        
        DrawerViewController.shareDrawer?.openLeftMenu()
    }
    //MARK: - 更多功能
    @IBAction func showAlert(_ sender: UIBarButtonItem) {
        
        let popVC = PopViewController()
        popVC.modalPresentationStyle = UIModalPresentationStyle.popover
        popVC.popoverPresentationController?.barButtonItem = sender
        popVC.popoverPresentationController?.delegate = self
        popVC.popoverPresentationController?.backgroundColor = UIColor.white
        present(popVC, animated: true, completion: nil)
        
    }

}

extension MessageViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
}
