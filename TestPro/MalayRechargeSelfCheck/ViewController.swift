//
//  ViewController.swift
//  MalayRechargeSelfCheck
//
//  Created by GarryZhang on 2017/8/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    let dataArray = ["celcom_icon", "digi_icon", "maxis_icon", "tron_icon", "tunetalk_icon", "umobile_icon", "xox_icon"]
    
    let dataArray = [
    ["telImage": "celcom_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "celcom", "price": "50.0"],
    ["telImage": "digi_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "digi", "price": "50.0"],
    ["telImage": "maxis_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "maxis", "price": "50.0"],
    ["telImage": "tron_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "tron", "price": "50.0"],
    ["telImage": "tunetalk_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "tunetalk", "price": "50.0"],
    ["telImage": "umobile_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "umobile", "price": "50.0"],
    ["telImage": "xox_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "xox", "price": "50.0"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "话费充值查询"

        self.tableView.tableHeaderView = self.tableHeaderView()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        self.tableView.register(UINib.init(nibName: "RechargeOrderCell", bundle: nil), forCellReuseIdentifier: "RechargeOrderCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        
    }

    
    func tableHeaderView() -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth(), height: 50.0))
        
        let dateLabel: UILabel = UILabel.init(frame: CGRect(x: 100, y: 15, width: 150, height: 20))
        dateLabel.font = UIFont.systemFont(ofSize: 14.0)
        dateLabel.text = "2017.08.30" //NSDate.date
        dateLabel.textAlignment = .center
        headerView.addSubview(dateLabel)
        
        let bottomView = UIView.init(frame: CGRect(x: 0, y: 49.5, width: ScreenWidth(), height: 0.5))
        bottomView.backgroundColor = UIColor.lightGray
        headerView.addSubview(bottomView)
        
        return headerView
    }
    
    func ScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func ScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.dataArray.count
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 120.0
        
        return height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeOrderCell") as! RechargeOrderCell
//        cell.textLabel?.text = self.dataArray[indexPath.row]
        
//        cell.telImageView?.image = UIImage.init(named: self.dataArray[indexPath.row])
        
        cell.setContent(dic: self.dataArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.accessoryType = .none
//        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
    }
    
}

