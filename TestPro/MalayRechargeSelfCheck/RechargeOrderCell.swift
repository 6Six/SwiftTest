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
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    // xib init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        searchButton.layer.cornerRadius = 5.0
        searchButton.layer.borderWidth = 0.5
        searchButton.layer.borderColor = UIColor.lightGray.cgColor //UIColor.hexColor("bdbdbd").cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setContent(dic: Dictionary<String, String>) {
        telImageView.image = UIImage.init(named: dic["telImage"]!)
        phoneLable.text = dic["phone"]
        timeLabel.text = dic["time"]
        celNameLabel.text = dic["celName"]
        priceLabel.text = dic["price"]
    }
    
}
