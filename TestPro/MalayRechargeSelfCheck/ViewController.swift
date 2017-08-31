//
//  ViewController.swift
//  MalayRechargeSelfCheck
//
//  Created by GarryZhang on 2017/8/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireSwiftyJSON
import AlamofireObjectMapper

//static NSString *const QUERY_ALL_ORDERS = ""

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dateButton: UIButton!
    
    var dataArray = Array<OrderDetail>()
    
//    var dataArray = [
//    ["telImage": "celcom_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "celcom", "price": "50.0"],
//    ["telImage": "digi_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "digi", "price": "50.0"],
//    ["telImage": "maxis_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "maxis", "price": "50.0"],
//    ["telImage": "tron_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "tron", "price": "50.0"],
//    ["telImage": "tunetalk_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "tunetalk", "price": "50.0"],
//    ["telImage": "umobile_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "umobile", "price": "50.0"],
//    ["telImage": "xox_icon", "phone": "18473827238", "time": "2017-08-29 12:32:01", "celName": "xox", "price": "50.0"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "话费充值查询"

//        self.tableView.tableHeaderView = self.tableHeaderView()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        self.tableView.register(UINib.init(nibName: "RechargeOrderCell", bundle: nil), forCellReuseIdentifier: "RechargeOrderCell")
        
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        self.queryData()
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
    
    func datePickerButtonClick() {
        
        let alertController: UIAlertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x:0, y:0, width:ScreenWidth() - 20, height:230))
        datePicker.backgroundColor = UIColor.white
        
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date.init()
        
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)->Void in
            self.dateChanged(datePicker: datePicker)

            self.queryData()
        })
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        
        alertController.view.addSubview(datePicker)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func dateChanged(datePicker : UIDatePicker) {
        //更新提醒时间文本框
        let formatter = DateFormatter()

        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: datePicker.date))
        
        dateButton.setTitle(formatter.string(from: datePicker.date), for: .normal)
    }
    
    func queryData() {
//        Alamofire.request("www.baidu.com").responseJSON {
//            response in
//            if let value = response.result.value {
//                print("Alamofire = \(value)")
//            }
//        }
        
        let url = "https://www.ygsjsy.com/dmsh/rechargedb/queryAllOrder.php"
        
        Alamofire.request(url).responseObject { (response: DataResponse<OrderResponse>) in
            let orderResponse = response.result.value
            print(orderResponse?.result_code ?? 0)
            print(orderResponse?.response ?? "none")
            
            if let orderDetail = orderResponse?.orderDetails {
                print(orderDetail)
            }
            
            self.dataArray = (orderResponse?.orderDetails)!
            self.tableView.reloadData()
        }
    }
    
    func queryOrder(date: NSDate) {
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth(), height: 50.0))
        headerView.backgroundColor = UIColor.white
        
        if dateButton == nil {
            dateButton = UIButton.init(frame: CGRect(x: 100, y: 15, width: 200, height: 20))
            dateButton.center = CGPoint(x: ScreenWidth() / 2, y: 25.0)
            dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            dateButton.setTitle("2017.08.30", for: .normal)
            dateButton.setTitleColor(UIColor.black, for: .normal)
            dateButton.addTarget(self, action: #selector(datePickerButtonClick), for: .touchUpInside)
        }
        
        if dateButton.superview == nil {
            headerView.addSubview(dateButton)
        }
        
//        let dateLabel: UILabel = UILabel.init(frame: CGRect(x: 100, y: 15, width: 150, height: 20))
//        dateLabel.font = UIFont.systemFont(ofSize: 14.0)
//        dateLabel.text = "2017.08.30" //NSDate.date
//        dateLabel.textAlignment = .center
//        headerView.addSubview(dateLabel)
        
        let bottomView = UIView.init(frame: CGRect(x: 0, y: 49.5, width: ScreenWidth(), height: 0.5))
        bottomView.backgroundColor = UIColor.lightGray
        headerView.addSubview(bottomView)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeOrderCell") as! RechargeOrderCell

        //        cell.textLabel?.text = self.dataArray[indexPath.row]
        //        cell.telImageView?.image = UIImage.init(named: self.dataArray[indexPath.row])
        
        if indexPath.row < self.dataArray.count {
            cell.setContent(orderDetail: self.dataArray[indexPath.row])
        }
        
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

