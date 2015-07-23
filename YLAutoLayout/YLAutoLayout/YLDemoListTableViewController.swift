//
//  YLDemoListTableViewController.swift
//  YLAutoLayout
//
//  Created by lenovo on 15/7/21.
//  Copyright © 2015年 zylll520. All rights reserved.
//

import UIKit

class YLDemoListTableViewController: UITableViewController {

    enum myEnum {
        
        case haha /// 测试
        case hehe
    }
    
    
    
    private lazy var demoList: [[String: String]] = {
        return [["title": "Alignment", "class": "YLDemo1ViewController"]]
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "hello, world"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = demoList[indexPath.row]["title"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(YLDemo1ViewController(), animated: true)
    }

}
