//
//  AppDelegate.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let appearance = UITabBarAppearance()
        let tabBar = UITabBar()
        
        NetworkMonitor.shared.startMonitoring()
        
        if #available(iOS 15.0, *) {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance;
            UITabBar.appearance().scrollEdgeAppearance = appearance
            
        } else if #available(iOS 14.0, *) {
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.tintColor = UIColor.brandColor(.green)
        }
        UITabBar.appearance().tintColor = UIColor.brandColor(.green)
        UITabBar.appearance().unselectedItemTintColor = UIColor.grayColor(.gray6)
        
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let _: UIUserNotificationSettings = UIUserNotificationSettings(
                types: [.alert, .sound, .badge],
                categories: nil)
            application.registerForRemoteNotifications()
        }
        
        fetchFCMToken()
        
        
       
        return true
    }
    
    func fetchFCMToken() {
        Messaging.messaging().delegate = self
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                UserDefaults.standard.FCMToken = token
                print("저장: FCM registration token: \(token)")
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    
}

final class AppAppearance {
    static func setupAppearance() {
        UIView.appearance().backgroundColor = .white
        
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registeration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? "" ]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}
