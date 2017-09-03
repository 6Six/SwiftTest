//
//  Util.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/3.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation

class Util {
    // 单例
    static let shared = Util();
    
    func greadVersion(newVersion: String, oldVersion: String) -> Bool {
        let isGreat: Bool = false
        
        print(newVersion)
        let array = newVersion.components(separatedBy: ".")
        print(array)
        
        let newVersionArray = newVersion.components(separatedBy: ".")
        let oldVersionArray = oldVersion.components(separatedBy: ".")
        
        for index in 0 ..< (newVersionArray.count > oldVersionArray.count ? newVersionArray.count : oldVersionArray.count) {
            if newVersionArray.count < index + 1 {
                return false
            }
            
            if oldVersionArray.count < index + 1 {
                return true
            }
            
            let v1 = Int(newVersionArray[index])
            let v2 = Int(oldVersionArray[index])
            
            if v1! > v2! {
                return true
            }
            else if v1! < v2! {
                return false
            }
            
        }
        
        return isGreat
    }
    
//    - (BOOL)version:(NSString *)version1 isGreaterThan:(NSString *)version2
//    {
//    NSArray *versions1 = [version1 componentsSeparatedByString:@"."];
//    NSArray *versions2 = [version2 componentsSeparatedByString:@"."];
//    
//    for (NSInteger index = 0; index < (versions1.count > versions2.count) ? versions1.count : versions2.count; index++)
//    {
//    if (versions1.count < index + 1) return NO;
//    if (versions2.count < index + 1) return YES;
//    
//    NSInteger v1 = [versions1[index] integerValue];
//    NSInteger v2 = [versions2[index] integerValue];
//    
//    if (v1 != v2)
//    {
//    return v1 > v2;
//    }
//    }
//    
//    return NO;
//    }

}
