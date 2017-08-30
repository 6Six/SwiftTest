//
//  UIImage+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func fixedOrientation() -> UIImage {
        
        if imageOrientation == UIImageOrientation.up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
            break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
            break
        case UIImageOrientation.up, UIImageOrientation.upMirrored:
            break
        }
        switch imageOrientation {
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImageOrientation.up, UIImageOrientation.down, UIImageOrientation.left, UIImageOrientation.right:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: size))
        default:
            ctx.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: size))
            break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
    
    class func imageFromColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func randomImage() -> UIImage {
        return UIImage.imageFromColor(UIColor.randomColor())
    }
    
    func imageMaxWidth(_ width: CGFloat) -> UIImage {
        return self.imageAtSize(CGSize(width: width, height: self.size.height * width / self.size.width))
    }
    
    func imageMaxHeight(_ height: CGFloat) -> UIImage {
        return self.imageAtSize(CGSize(width: self.size.width * height / self.size.height, height: height))
    }
    
    func imageAtSize(_ size: CGSize) -> UIImage {
        let imageSize = self.size
        let hfactor = imageSize.width / size.width
        let vfactor = imageSize.height / size.height
        
        let factor = min(hfactor, vfactor)
        let newWidth = imageSize.width / factor
        let newHeight = imageSize.height / factor
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        self.draw(in: CGRect(x: -(newWidth - size.width) / 2.0, y: -(newHeight - size.height) / 2.0, width: newWidth, height: newHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func grayImage() -> UIImage? {
        return imageBlend(tintColor: UIColor.lightGray, blendMode: CGBlendMode.destinationOver)
    }
    
    func imageBlend(tintColor: UIColor, blendMode: CGBlendMode) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        tintColor.setFill()
        
        let bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width + 1, height: size.height + 1))
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        if (blendMode != CGBlendMode.destinationIn) {
            self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        }
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return tintedImage
    }
    
    /**
     系统默认图片
     
     - returns: UIImage
     */
    class func appDefaultImage() -> UIImage {
        return UIImage.imageFromColor(UIColor.appColor())
    }
    
    /**
     商户默认图像
     
     - returns: UIImage
     */
    //    class func appUserDefaultImage() -> UIImage {
    //        return UIImage(named: "icon_user_default")!
    //    }
    
}
