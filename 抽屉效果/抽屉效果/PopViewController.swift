//
//  PopViewController.swift
//  抽屉效果
//
//  Created by administrator on 2017/3/13.
//  Copyright © 2017年 WL. All rights reserved.
//

import UIKit

class PopViewController: UITableViewController {

    var dataArray = ["创建群聊","加好友／群", "扫一扫","面对面快传","付款","拍摄", "面对面红包"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        preferredContentSize = CGSize(width: 150, height: 245)
        tableView.rowHeight = 35
    }
    
    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
