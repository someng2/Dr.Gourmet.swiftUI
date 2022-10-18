//
//  AppDelegate.swift
//  Dr.Gourmet.swiftUI
//
//  Created by 백소망 on 2022/10/13.
//

import Foundation
import UIKit
import RealmSwift

let realm = try! Realm()

class MyAppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
//        let config = Realm.Configuration(
//             schemaVersion: 1,
//                migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//        })
//        Realm.Configuration.defaultConfiguration = config
//        let realm = try! Realm()
        
        return true
    }
}
