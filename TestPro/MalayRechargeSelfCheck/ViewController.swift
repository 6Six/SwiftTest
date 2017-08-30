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
    
    let dataArray = ["celcom_icon", "digi_icon", "maxis_icon", "tron_icon", "tunetalk_icon", "umobile_icon", "xox_icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "话费充值查询"
        
        self.tableView.register(UINib.init(nibName: "RechargeOrderCell", bundle: nil), forCellReuseIdentifier: "RechargeOrderCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        
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
        
        cell.telImageView?.image = UIImage.init(named: self.dataArray[indexPath.row])
        
//        let inputTF = UITextField()
//        inputTF.textAlignment = .right
//        inputTF.textColor = UIColor.hexColor("3d3d3d")
//        inputTF.font = UIFont.systemFont(ofSize: 13.0)
//        inputTF.returnKeyType = .done
//        inputTF.delegate = self
//        
//        let selectButton = UIButton()
//        selectButton.setTitle("未选择", for: .normal)
//        selectButton.setTitleColor(UIColor.hexColor("bdbdbd"), for: UIControlState.normal)
//        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
//        selectButton.contentHorizontalAlignment = .right
        
        let dateFormatter = DateFormatter.init()
        
        
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

