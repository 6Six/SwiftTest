//
//  String+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit
//import SwiftyRSA
import Security


enum CSDateFormate: String {
    
    /// yyyy-MM-dd
    case Day
    
    /// HH:mm
    case OnlyTime
    
    /// yyyy-MM-dd HH:mm
    case Time // default
    
    /// yyyy-MM-dd HH:mm:ss.SSSZ
    case GTM
    
    /// yyyy-MM-dd HH:mm:ss
    case GTM1
    
    /// MM-dd
    case MonthDay
    
    /// yyyyMMddHHmmss
    case Second
    
    case Second1
    
    /// yyyyMMdd
    case Day1
    
    /// yyyyMM
    case Month
    
    //yyyy.MM.dd
    case DayPoint
    
    case MonthDay1
    // yyyy/MM/dd HH:mm:ss
    case sencondLine
    var formate: String {
        switch self {
        case .Day:
            return "yyyy-MM-dd"
        case .OnlyTime:
            return "HH:mm"
        case .GTM:
            return "yyyy-MM-dd HH:mm:ss.SSSZ"
        case .GTM1:
            return "yyyy-MM-dd HH:mm:ss"
        case .MonthDay:
            return "MM-dd"
        case .Second:
            return "yyyyMMddHHmmss"
        case .Second1:
            return "MM-dd HH:mm"
        case .Day1:
            return "yyyyMMdd"
        case .DayPoint:
            return "yyyy.MM.dd"
        case .MonthDay1:
            return "MM月dd日"
        case .Month:
            return "yyyyMM"
        case .sencondLine:
            return "yyyy/MM/dd HH:mm:ss"
        default:
            return "yyyy-MM-dd HH:mm"
        }
    }
}

// MARK: - 时间 -> String
extension String {
    internal func stringFromTimestapString(_ formate: CSDateFormate) -> String {
        APP.dateFormatter.dateFormat = formate.formate
        let rslt = APP.dateFormatter.string(from: Date.dateFromTimestap(self))
        return rslt
    }
    
    func stringFromTimeString(_ srcFormate: CSDateFormate, toFormate: CSDateFormate) -> String {
        APP.dateFormatter.dateFormat = srcFormate.formate
        let date = APP.dateFormatter.date(from: self)
        
        guard let _ = date else { return "" }
        APP.dateFormatter.dateFormat = toFormate.formate
        let rslt = APP.dateFormatter.string(from: date!)
        return rslt
    }
    
    func date(_ srcFormate: CSDateFormate) -> Date {
        APP.dateFormatter.dateFormat = srcFormate.formate
        let date = APP.dateFormatter.date(from: self)
        guard let rslt = date else {
            print("error:error:error:error:error:error:error:error:error:error:error:")
            return Date()
        }
        return rslt
    }
}


// 汉字转拼音
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        
        return string.replacingOccurrences(of: " ", with: "")
    }
}


extension String {
    
    var isBlank: Bool {
        return self.trim().isEmpty
    }
    
    static func isEmpty(_ str: String?) -> Bool {
        if let s = str {
            return s.isEmpty
        }
        return true
    }
    
    // string length
    var length: Int {
        return self.characters.count
    }
    
    func phoneNumberFormatter() -> String {
        var temp = self
        if temp.length >= 4 {
            temp.insert(" ", at: self.characters.index(self.startIndex, offsetBy: 3))
        }
        if temp.length >= 9 {
            temp.insert(" ", at: self.characters.index(self.startIndex, offsetBy: 8))
        }
        return temp
    }
    
    // 185****9090格式
    func phoneStarFormatter() -> String {
        var temp = self

        if temp.length == 11 {
            var newStr = ""
            for (i,char) in temp.characters.enumerated() {
                if i == 3 || i == 4 || i == 5 || i == 6 {
                    newStr = newStr + "*"
                    continue
                }
                newStr = newStr + String(char)
            }
            return newStr
        }
        
        return temp
    }
    
    // 1854****9090 格式订单号
    func starFormatter() -> String {
        var temp = self
        
        var newStr = ""
        
        let leng = self.length
        var index = 0
        
        for (i,char) in temp.characters.enumerated() {
            if i < 4 || i > leng - 5 {
                newStr = newStr + String(char)
            } else if index < 4 {
                newStr = newStr + "*"
                index += 1
            }
        }
        return newStr
    }
    
    // 6216 **** **** 577格式银行卡
    func bankCardStarFormatter() -> String {
        var temp = self

        if temp.length >= 13 {
            temp.insert(" ", at: self.characters.index(self.startIndex, offsetBy: 4))
            temp.insert(" ", at: self.characters.index(self.startIndex, offsetBy: 9))
            temp.insert(" ", at: self.characters.index(self.startIndex, offsetBy: 14))

            var newStr = ""

            for (i,char) in temp.characters.enumerated() {
                if (i > 4 && i < 9) || (i > 9 && i < 14) {
                    newStr = newStr + "*"
                } else {
                    newStr = newStr + String(char)
                }
            }
            
            return newStr
        }
       
        return temp
    }
    
    // 姓名 *大为 格式
    func nameStarFormatter() -> String {
        var temp = self

        if temp.length >= 2 {
            var newStr = ""
            for (i,char) in temp.characters.enumerated() {
                if i == 0 {
                    newStr = newStr + "*"
                } else {
                    newStr = newStr + String(char)
                }
            }
            return newStr
        }
        return temp
    }
    
    static func cacheFolder() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    // string to dictionary
    var jsonDictionary: [String: AnyObject] {
        let obj = self
        let data = obj.data(using: String.Encoding.utf8)
        var rslt: [String: AnyObject]?
        if let data = data {
            do {
                rslt = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
            }
            catch let JSONError as NSError {
                print(JSONError)
            }
        }
        return rslt ?? [String: AnyObject]()
    }
    
    
    // 获得文字的宽度
    func widthOfFont(_ font: UIFont , maxHeight: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight),
                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                 attributes: [NSFontAttributeName: font],
                                 context: nil).size.width
    }
    
    func heightOfFont(_ font: UIFont , maxWith: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: maxWith, height: CGFloat.greatestFiniteMagnitude),
                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                 attributes: [NSFontAttributeName: font],
                                 context: nil).size.height
    }
    
}

extension String {
    //验证身份证
    func validateIDCardNumber() -> Bool {
        if self.characters.count != 18 {
            return false
        }
        let codeArray = ["7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2"]
        let checkCodeDic = NSDictionary(objects: ["1","0","X","9","8","7","6","5","4","3","2"],
                                        forKeys: ["0" as NSCopying,"1" as NSCopying,"2" as NSCopying,"3" as NSCopying,
                                                  "4" as NSCopying,"5" as NSCopying,"6" as NSCopying,"7" as NSCopying,
                                                  "8" as NSCopying,"9" as NSCopying,"10" as NSCopying])
        let scan = Scanner(string: self.substring(to: self.characters.index(self.startIndex, offsetBy: 17)))
        
        var val:Int32 = 0
        let isNum = scan.scanInt32(&val) && scan.isAtEnd
        if !isNum {
            return false
        }
        var sumValue = 0
        for i in 0  ..< 17  {
            sumValue += Int(self.substring(with: Range(self.characters.index(self.startIndex, offsetBy: i) ..< self.characters.index(self.startIndex, offsetBy: i+1))))! * Int(codeArray[i])!
        }
        let obj = checkCodeDic.object(forKey: "\(sumValue%11)")
        if let obj = obj, String(describing: obj) == self.substringFromIndex(17).uppercased() {
            return true
        }
        return false
    }
}


extension String {
    // 创建二维码图片
    func qrCodeImage(_ qrImageName: UIImage? = nil) -> UIImage? {
        let stringData = self.data(using: String.Encoding.utf8,
                                   allowLossyConversion: false)
        // 创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter.outputImage
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二维码image
        let codeImage = UIImage(ciImage: colorFilter.outputImage!
            .applying(CGAffineTransform(scaleX: 5, y: 5)))
        // 通常,二维码都是定制的,中间都会放想要表达意思的图片
        if let iconImage = qrImageName {
            let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
            UIGraphicsBeginImageContext(rect.size)
            
            codeImage.draw(in: rect)
            let avatarSize = CGSize(width: rect.size.width * 0.25, height: rect.size.height * 0.25)
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            return resultImage
        }
        return codeImage
    }
}



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



extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}

extension NSNumber {
    func cny() -> String {
        return String(format: "%.2f", self.doubleValue / 100.0)
    }
}

extension String {
    /// 元 -> 分
    func penny() -> String {
        if let py = Double(self) {
            let rslt = String(format: "%.0f",(py * 100))
            return rslt
        }
        return "0"
    }
    func cny() -> String {
        return String(format: "%.2f", (Double(self) ?? 0) / 100.0)
    }
}



extension String {
    
    var twoDot: String {
        guard let m = Double(self) else {
            return self
        }
        return String(format: "%.2f", m)
    }
    /// 图片地址
    var resourceString: String {
        return self
    }
    var thumbResourceString: String {
        return resourceString
    }
    
    func payPasswordFormat() -> String {
        let temp = self
        return temp.replacingOccurrences(of: " ", with: "+")
    }
    
    var moneyFormatString: String {
        let money = Double(self)
        guard let mon = money else {
            return "0.00"
        }
        if mon <= 0.001 {
            return "0.00"
        }
        return mon.moneyFormatString()
    }
    
    var normalMoneyString: String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    
    func fileName() -> String {
        let comp = self.components(separatedBy: "/")
        if comp.count > 0 {
            let last = comp.last!
            if last.contains(".") {
                return last
            }
        }
        assert(false)
        return ""
    }
    
}

extension String {
    
    func isIncludeSpaces() ->Bool {
        let str = self as NSString
        for i in 0 ..< str.length {
            let s = str.substring(with: NSMakeRange(i, 1))
            if s == " " {
                return true
            }
        }
        
        return false
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func replaceAll(_ target: String, withString replacement: String) -> String {
        return self.replacingOccurrences(of: target, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
}


extension NSObject {
    static func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}


extension Double {
    func moneyFormatString() -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .decimal
        let formatString = numberFormatter.string(from: NSNumber(value: self))!
     
        return formatString
    }
}


extension String {
    /// 数字
    var isDigitalString: Bool {
        if self.length <= 0 {
            return false
        }
        let inputString = self.trimmingCharacters(in: CharacterSet.decimalDigits)
        if inputString.length <= 0 {
            return true
        }
        return false
    }
    /// 纯字符
    var isPurgeLetterString: Bool {
        if self.length <= 0 {
            return false
        }
        let inputString: String = self.trimmingCharacters(in: CharacterSet.letters)
        if inputString.length <= 0 {
            return true
        }
        return false
    }
    
    var isPurgeNoLetterString: Bool {
        if self.length <= 0 {
            return false
        }
        let inputString: String = self.trimmingCharacters(in: CharacterSet.symbols)
        if inputString.length <= 0 {
            return true
        }
        return false
    }
}


extension String {
    func rsa() -> String {
        return self
//        let str = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDd0oFLwQwMp2OnBBRWfFiLcclyzPnTMvkKMgFugKKe9znzYJz2K2NqB3vfZ5aMII4iKWut44oSfFBT7bkNORI5c46nxH6cX6zvavXhNqSIUWAhYfGQd33ksbHr/cP83rZ4S931J4O1GWzhjy5PSCiqU8AkjcQj9otSS2aoOKlUFQIDAQAB"
//        let rslt = try? SwiftyRSA.encryptString(self, publicKeyPEM: str)
//        
//        return rslt ?? ""
    }
    
    func threeDesWorkEncrypt() -> String? {
        return threeDESEncryptOrDecrypt(CCOperation(kCCDecrypt), key: "fefb8eedabd821fbeeea6c35c38c1966", iv: "01234567")
    }
    
    func threeDesEncrypt() -> String? {
        return threeDESEncryptOrDecrypt(CCOperation(kCCEncrypt), key: "fefb8eedabd821fbeeea6c35c38c1966", iv: "01234567")
    }
    
    /**
     3DES的加密过程 和 解密过程
     
     - parameter op : CCOperation： 加密还是解密
     CCOperation（kCCEncrypt）加密
     CCOperation（kCCDecrypt) 解密
     
     - parameter key: 专有的key,一个钥匙一般
     - parameter iv : 可选的初始化向量，可以为nil
     - returns      : 返回加密或解密的参数
     */
    func threeDESEncryptOrDecrypt(_ op: CCOperation,key: String,iv: String) -> String? {
        
        // Key
        let keyData: Data = (key as NSString).data(using: String.Encoding.utf8.rawValue) as Data!
        let keyBytes         = UnsafeMutableRawPointer(mutating: (keyData as NSData).bytes.bindMemory(to: Void.self, capacity: keyData.count))
        
        // 加密或解密的内容
        var data: Data = Data()
        if op == CCOperation(kCCEncrypt) {
            data  = (self as NSString).data(using: String.Encoding.utf8.rawValue) as Data!
        }
        else {
            data =  Data(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        }
        
        let dataLength    = size_t(data.count)
        let dataBytes     = UnsafeMutableRawPointer(mutating: (data as NSData).bytes.bindMemory(to: Void.self, capacity: data.count))
        
        // 返回数据
        let cryptData    = NSMutableData(length: (data.count + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1))
        let cryptPointer = cryptData!.mutableBytes
        
        let cryptLength  = size_t(cryptData!.length)
        
        //  可选 的初始化向量
        let viData :Data = (iv as NSString).data(using: String.Encoding.utf8.rawValue) as Data!
        let viDataBytes    = UnsafeMutableRawPointer(mutating: (viData as NSData).bytes.bindMemory(to: Void.self, capacity: viData.count))
        
        // 特定的几个参数
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(op)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
        
        var numBytesCrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation, // 加密还是解密
            algoritm, // 算法类型
            options,  // 密码块的设置选项
            keyBytes, // 秘钥的字节
            keyLength, // 秘钥的长度
            viDataBytes, // 可选初始化向量的字节
            dataBytes, // 加解密内容的字节
            dataLength, // 加解密内容的长度
            cryptPointer, // output data buffer
            cryptLength,  // output data length available
            &numBytesCrypted) // real output data length
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            
            cryptData!.length = Int(numBytesCrypted)
            if op == CCOperation(kCCEncrypt)  {
                let base64cryptString = cryptData!.base64EncodedString(options: .lineLength64Characters)
                return base64cryptString
            }
            else {
                let base64cryptString = String(data: cryptData! as Data, encoding: String.Encoding.utf8)
                return base64cryptString
            }
        }
        else {
            print("Error: \(cryptStatus)")
        }
        return nil
    }
    
    
    fileprivate func stringFromResult(_ result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}
