//
//  UIDevice.swift
//  JSTest
//
//  Created by Li Shi Wei on 10/10/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit

extension UIDevice {

    public class func identifierByKeychain() -> String{
        
        //objc_sync_enter(NotificationCenter.default)
        
        let service = "CreateDeviceIndentifierByKeychain"
        let account = "VirtualDeviceIndentifier"
        
        var recommendDeviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
        recommendDeviceIdentifier = recommendDeviceIdentifier?.trimmingCharacters(in: .whitespaces)
        let queryDic : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrSynchronizable : kCFBooleanFalse,
            kSecAttrAccount: account,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        var keychainPassword : AnyObject?
        let queryResult = SecItemCopyMatching(queryDic, &keychainPassword)
        
        if queryResult == errSecSuccess{
            let pwd = String(data: keychainPassword as! Data, encoding: String.Encoding.utf8)
            if pwd != nil {
                return pwd!
            }
            else{
                
                let deleteDic : NSDictionary = [
                    kSecClass : kSecClassGenericPassword,
                    kSecAttrService : service,
                    kSecAttrSynchronizable : kCFBooleanFalse,
                    kSecAttrAccount: account
                ]
                
                let status = SecItemDelete(deleteDic)
                if status != errSecSuccess{
                    return recommendDeviceIdentifier!
                }
            }
        }
        
        if recommendDeviceIdentifier != nil{
            
            let addDic : [String: Any] = [
                String(kSecClass) : kSecClassGenericPassword,
                String(kSecAttrService) : service,
                String(kSecAttrAccount) : account,
                String(kSecAttrSynchronizable) : (kCFBooleanFalse as CFTypeRef),
                String(kSecAttrAccessible) : (kSecAttrAccessibleAlwaysThisDeviceOnly as CFTypeRef),
                String(kSecValueData) : recommendDeviceIdentifier!.data(using: String.Encoding.utf8)!,
                ]
            
            let addResult = SecItemAdd(addDic as CFDictionary, nil)
            
            if addResult != errSecSuccess{
                print("create keychain failed.")
            }
        }
        
        return recommendDeviceIdentifier!
        
        //objc_sync_exit(NotificationCenter.default)
        
    }
    
}
