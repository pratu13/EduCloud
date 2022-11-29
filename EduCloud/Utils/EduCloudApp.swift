//
//  EduCloudApp.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 19/09/20.
//

import SwiftUI
import Firebase

@main
struct EduCloudApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
                .statusBar(hidden: true)
                .environmentObject(User())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let database = Firestore.firestore()
        return true
    }
    
}

