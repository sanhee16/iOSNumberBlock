//
//  NumberBlock++Bundle.swift
//  NumberBlock
//
//  Created by sandy on 2023/01/04.
//

import Foundation

// Use Plist for get API_KEY
// https://nareunhagae.tistory.com/44s
extension Bundle {
    var fireStorageUrl: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "AppInfo", ofType: "plist") else {
                fatalError("Couldn't find file 'AppInfo.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "FireStorageUrl") as? String else {
                fatalError("Couldn't find key 'FireStorageUrl' in 'AppInfo.plist'.")
            }
            return value
        }
    }
}

