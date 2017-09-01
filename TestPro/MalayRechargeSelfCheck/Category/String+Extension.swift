//
//  String+Extension.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/8/31.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 字符串截取

extension String {
    
    func substringWithRange(_ aRange: Range<Int>) -> String {
        let range = Range(self.characters.index(self.startIndex, offsetBy: aRange.lowerBound)..<self.characters.index(self.startIndex, offsetBy: aRange.upperBound))
        return self.substring(with: range)
    }
    
    //截取 index 到 尾部字符串 包括index位置的字符
    func substringFromIndex(_ index: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
    }
    
    // 取 0 到 index的字符串  不包括 index的字符串
    func substringToIndex(_ index: Int) -> String {
        return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
    }
    
}

