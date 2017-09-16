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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var versionLabel: UILabel!
    
    var dateButton: UIButton!
    
    var dataArray = Array<OrderDetail>()
    var displayDataArray = Array<OrderDetail>()
    
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

        let refreshButton = UIButton()
        refreshButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        refreshButton.setImage(UIImage(named: "refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: refreshButton)
        
        
//        self.tableView.tableHeaderView = self.tableHeaderView()
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        self.tableView.register(UINib.init(nibName: "RechargeOrderCell", bundle: nil), forCellReuseIdentifier: "RechargeOrderCell")
        
        self.loadData()
        
        self.checkUpdate()
        self.addHeaderView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        self.queryData()
    }

    // 检查是否有版本更新
    func checkUpdate() {
        let url = "https://www.ygsjsy.com/dmsh/JSPay/checkVersionUpdate.php"
        
        Alamofire.request(url).responseObject { (response: DataResponse<CheckVersionUpdateResponse>) in
            let checkUpdateResponse = response.result.value
            let newVersion: String = (checkUpdateResponse?.version!)!
            
            let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            let hasUpdate = Util.shared.greadVersion(newVersion: newVersion, oldVersion: currentVersion)

            self.versionLabel.text = "V" + currentVersion;
            
            if hasUpdate == true {
                let alertController: UIAlertController = UIAlertController(title:"更新提示", message: "\n已经有新版本上线，点击确定去更新", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
                    (alertAction)->Void in
                    let openUrlStr = "https://www.pgyer.com/8Yhb"
                    UIApplication.shared.open(URL.init(string: openUrlStr)!, options: [:], completionHandler: { (success) in
                        
                    })
                    
                })
                alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("no update")
            }
        }
    }
    
    func addHeaderView() -> Void {
//        let headerView = UIView.init(frame: CGRect(x: 0, y: 64, width: ScreenWidth(), height: 50.0))
//        headerView.backgroundColor = UIColor.white
//        let dateLabel: UILabel = UILabel.init(frame: CGRect(x: 100, y: 15, width: 150, height: 20))
//        dateLabel.font = UIFont.systemFont(ofSize: 14.0)
//        dateLabel.text = "2017.08.30" //NSDate.date
//        dateLabel.textAlignment = .center
//        headerView.addSubview(dateLabel)
        
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(segmentValueChanged(segmented:)), for: .valueChanged)
        
//        let bottomView = UIView.init(frame: CGRect(x: 0, y: 49.5, width: ScreenWidth(), height: 0.5))
//        bottomView.backgroundColor = UIColor.lightGray
//        self.view.addSubview(bottomView)
        
//        self.view.addSubview(headerView);
    }
    
    func segmentValueChanged(segmented: UISegmentedControl) -> Void {
        switch segmented.selectedSegmentIndex {
        case 0:
            self.displayDataArray = self.dataArray
            break
        case 1:
            self.displayDataArray.removeAll()
            
            for index in 0 ..< self.dataArray.count {
                let orderDetail = self.dataArray[index] 
                
                if orderDetail.recharge_status == "1" {
                    self.displayDataArray.append(orderDetail)
                }
            }
            
            break
        case 2:
            self.displayDataArray.removeAll()
            
            for index in 0 ..< self.dataArray.count {
                let orderDetail = self.dataArray[index]
                
                if orderDetail.recharge_status == "-1" {
                    self.displayDataArray.append(orderDetail)
                }
            }
            break
        default:
            break
        }
        
        if !self.displayDataArray.isEmpty {
            self.tableView.reloadData()
        }
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

        JustHUD.shared.showInView(view: self.view, withHeader: nil, andFooter: "请求数据中...")
        
        let url = "https://www.ygsjsy.com/dmsh/rechargedb/queryAllOrder.php"
        
        Alamofire.request(url).responseObject { (response: DataResponse<OrderResponse>) in
            let orderResponse = response.result.value
           
//            print(orderResponse?.result_code ?? 0)
//            print(orderResponse?.response ?? "none")
//            
//            if let orderDetail = orderResponse?.orderDetails {
//                print(orderDetail)
//            }
            
            if JustHUD.shared.isActive {
                JustHUD.shared.hide()
            }
            
            if (orderResponse?.orderDetails) != nil {
                self.dataArray = (orderResponse?.orderDetails)!
                self.dataArray = self.dataArray.reversed()
//                self.displayDataArray = self.dataArray
                
                self.segmentValueChanged(segmented: self.segmentControl)
                
                self.tableView.reloadData()
            }
        }
    }
    
    func queryRechargeResult(orderId: String, atIndex index: Int) {
        JustHUD.shared.showInView(view: self.view, withHeader: nil, andFooter: "查询中，请稍候..")

        let queryUrl = "https://www.ygsjsy.com/dmsh/JSPay/checkTransactionStatus.php?sClientTxId=" + orderId
        Alamofire.request(queryUrl).responseObject { (response: DataResponse<RechargeResultResponse>) in
            if JustHUD.shared.isActive {
                JustHUD.shared.hide()
            }
            
            if index < self.displayDataArray.count {
                let orderDetail = self.displayDataArray[index]
                
                let rechargeResultResponse = response.result.value
                orderDetail.recharge_status = rechargeResultResponse?.rechargeStatus
                self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
            }
        }
    }
    
    func queryAllUnarrivedOrdersStatus() -> Void {
        JustHUD.shared.showInView(view: self.view, withHeader: nil, andFooter: "查询中，请稍候..")
        
        let queryUrl = "https://www.ygsjsy.com/dmsh/JSPay/checkAllUnarrivedOrdersStatus.php"
        
        Alamofire.request(queryUrl).responseObject { (response: DataResponse<CheckAllUnarrivedOrderResponse>) in
            if JustHUD.shared.isActive {
                JustHUD.shared.hide()
            }
            
//            if index < self.displayDataArray.count {
//                let orderDetail = self.displayDataArray[index]
//                
//                let rechargeResultResponse = response.result.value
//                orderDetail.recharge_status = rechargeResultResponse?.rechargeStatus
//                self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
//            }
            
            self.queryData()
        }
    }
    
//    func timeStampToString(timeStamp:String) -> String {
//        var string = NSString(string: timeStamp)
//        
//        // test code
//        
//        let date = Date()
//        let dateStamp:TimeInterval = date.timeIntervalSince1970
//        
//        let dateSt:Int = Int(dateStamp)
//        print(dateSt)
//        string = String(dateSt) as NSString
//        
//        //
//        
//        
//        let timeStamp : TimeInterval = string.doubleValue
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd hh:mm:ss"
//        
//        let newDate = Date(timeIntervalSince1970: timeStamp)
//        return dateFormatter.string(from: newDate)
//    }
 
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.displayDataArray.count
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 120.0
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height:CGFloat = 0.0
        return height
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
        
        let bottomView = UIView.init(frame: CGRect(x: 0, y: 49.5, width: ScreenWidth(), height: 0.5))
        bottomView.backgroundColor = UIColor.lightGray
        headerView.addSubview(bottomView)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeOrderCell") as! RechargeOrderCell

        if indexPath.row < self.displayDataArray.count {
            cell.setContent(orderDetail: self.displayDataArray[indexPath.row])
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
     
        if indexPath.row < self.displayDataArray.count {
            let orderDetail = self.displayDataArray[indexPath.row]
            
            if self.segmentControl.selectedSegmentIndex == 2 {
                self.queryAllUnarrivedOrdersStatus()
            }
            else {
                self.queryRechargeResult(orderId: orderDetail.order_id ?? "", atIndex: indexPath.row)
            }
        }
    }
    
}

