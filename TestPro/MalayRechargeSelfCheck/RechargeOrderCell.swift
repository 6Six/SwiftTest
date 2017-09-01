//
//  RechargeOrderCell.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/8/29.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import UIKit

class RechargeOrderCell: UITableViewCell {
    
//    @IBOutlet weak var userImageView: DesignableImageView!
    
    @IBOutlet weak var telImageView: UIImageView!
    @IBOutlet weak var phoneLable: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var celNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    
//    @IBOutlet weak var searchButton: UIButton!
    
    
    
    // xib init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resultLabel.adjustsFontSizeToFitWidth = true
        
//        searchButton.layer.cornerRadius = 5.0
//        searchButton.layer.borderWidth = 0.5
//        searchButton.layer.borderColor = UIColor.lightGray.cgColor //UIColor.hexColor("bdbdbd").cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setContent(orderDetail: OrderDetail) {
        telImageView.image = UIImage.init(named: orderDetail.telcom_image_name!)
        phoneLable.text = orderDetail.phone_num
        timeLabel.text = self.timeStampToString(timeStamp: orderDetail.recharge_time!)
        celNameLabel.text = orderDetail.telcom_name
        priceLabel.text = "$" + orderDetail.recharge_money!
        orderIdLabel.text = orderDetail.order_id
        
        // green: 45FF80
        // red:   FF0000
        
        let color: UIColor!
        let resultStr: String!
        
        if orderDetail.recharge_status == "1"  {
            // 已到账            
            color = UIColor.hexColor("45FF80")
            resultStr = "已到账"
        }
        else if orderDetail.recharge_status == "-1"{
            color = UIColor.hexColor("FF0000")
            resultStr = "未到账"
        }
        else {
            color = UIColor.hexColor("ff0000")
            resultStr = "未知错误"
        }
        
        resultLabel.textColor = color
        resultLabel.text = resultStr
    }
    
    func timeStampToString(timeStamp:String) -> String {
        let string = NSString(string: timeStamp)
        
        let timeStamp : TimeInterval = string.doubleValue
        let dateFormatter = DateFormatter()

//        dateFormatter.timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        dateFormatter.dateFormat = "yyyy.MM.dd hh:mm:ss"
        
        let newDate = Date(timeIntervalSince1970: timeStamp)
        return dateFormatter.string(from: newDate)
    }
    
}
