//
//  UILabel+Extension.swift
//  Fus
//
//  Created by cdw on 2016/12/22.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit

extension UILabel {
    
    /// 需要最少有文字信息 文字间距
    func addCharacterSpacing(_ cs: CGFloat) -> UILabel {
        let mAttribute = self.guardAttributeString
        let le = mAttribute.string.length
        mAttribute.addAttributes([NSKernAttributeName : NSNumber(value: Float(cs) as Float)],
                                 range: NSMakeRange(0, le))
        self.attributedText = mAttribute
        return self
    }
    
    /**
     添加行高
     
     - parameter cs: 行高
     
     - returns: UILable
     */
    func addLineHeight(_ cs: CGFloat) -> UILabel {
        let mAttribute = self.guardAttributeString
        let le = mAttribute.string.length
        
        let paragraphStyle:NSMutableParagraphStyle=NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = cs//行高值
        paragraphStyle.alignment = self.textAlignment
        
        mAttribute.addAttributes([NSParagraphStyleAttributeName : paragraphStyle],
                                 range: NSMakeRange(0, le))
        self.attributedText = mAttribute
        return self
    }
    
    /**
     添加图片
     */
    func addImageAtIndex(_ idt: Int, image: UIImage, imageFrame: CGRect = CGRect(x: 0, y: 0, width: 13, height: 13)) -> UILabel {
        let mAttribute = self.guardAttributeString
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = imageFrame
        let attachmentString = NSAttributedString(attachment: attachment)
        mAttribute.insert(attachmentString, at: idt)
        self.attributedText = mAttribute
        return self
    }
    
    var guardAttributeString: NSMutableAttributedString {
        var mAttribute: NSMutableAttributedString? = nil
        if let at = self.attributedText {
            return at.mutableCopy() as! NSMutableAttributedString
        }
        else {
            mAttribute = NSMutableAttributedString(string: self.text!)
        }
        return mAttribute!
    }
}
