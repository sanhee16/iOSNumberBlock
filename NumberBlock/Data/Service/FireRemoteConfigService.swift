//
//  FireRemoteConfigService.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/13.
//

import Foundation
import FirebaseRemoteConfig


class FireRemoteConfigService {
    let remoteConfig: RemoteConfig
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        self.remoteConfig.configSettings = settings
//        self.remoteConfig.setDefaults(fromPlist: "RemoteConfigValue")
    }
    
    
    private func getRemoteBoolValue(_ key: String, callback: @escaping (Bool)->()) {
        self.remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate() { (changed, error) in
                    let value = self.remoteConfig[key].boolValue
                    callback(value)
                    print("resultValue=", value)
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
                callback(false)
            }
        }
    }
    
    private func getRemoteIntValue(_ key: String, callback: @escaping (NSNumber)->()) {
        self.remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate() { (changed, error) in
                    let value = self.remoteConfig[key].numberValue
                    callback(value)
                    print("resultValue=", value)
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
                callback(false)
            }
        }
    }
}

extension FireRemoteConfigService {
    func getDBVersion(_ completion: @escaping (Int) -> ()) {
        self.getRemoteIntValue("DBVersion") { value in
            completion(Int(truncating: value))
        }
    }
}
