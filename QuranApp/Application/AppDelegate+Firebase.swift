

import Foundation
import Firebase
import UserNotifications
import UIKit
import AVFoundation


extension AppDelegate
{
    
    func configFireBase(application: UIApplication){
        //////////////////////////firebase////////////////
        
        FirebaseApp.configure()
        
        
    
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        
        
        
        
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]4
        //     Messaging.messaging().shouldEstablishDirectChannel = true

        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            //     Messaging.messaging().useMessagingDelegateForDirectChannel = true
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { isError, Error in
                print(Error?.localizedDescription)
            }

        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        
        
        
        application.registerForRemoteNotifications()
        
        
        //   Messaging.messaging().shouldEstablishDirectChannel = true
        // [END register_for_notifications]
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
    }
}
//AppDelegate + Firebase Delegate
extension AppDelegate{
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        //  Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        print(userInfo)
        
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        // This notification is not auth related, developer should handle it.
        
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        
        Messaging.messaging().apnsToken = deviceToken
        
        Auth.auth().setAPNSToken(deviceToken,type: AuthAPNSTokenType.unknown)
        
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
//        let status = userInfo["type"]
//        let redirect_id = userInfo["redirect_id"]
//        let type = userInfo["type"]
//        print(status)
//        print(redirect_id)
//        print(type)
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
//        let total_count = Int((userInfo["total_unread"] as? String) ?? "")
//        print(total_count)
//
//        let aps = userInfo[AnyHashable("aps")] as? NSDictionary
//        var badge = aps?["badge"]  as? Int
//        if (badge == nil) { badge = total_count}
//        UIApplication.shared.applicationIconBadgeNumber = badge ?? 0
//        NotifyModel.shared?.setCount(value: badge?.description)
//        UserDefaults.standard.set(badge, forKey: "NotificationCount")
        // Change this to your preferred presentation option
        if #available(iOS 14.0, *) {
            completionHandler([.alert,.badge,.sound,.banner])
        } else {
            // Fallback on earlier versions
            completionHandler([.alert,.badge,.sound])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
//        let aps = userInfo[AnyHashable("aps")] as? NSDictionary
//        let data = aps?["alert"]  as? NSDictionary
//        let title = data?["title"]  as? String
//        let status = userInfo["type"] as? String
//        let redirect_id = userInfo["redirect_id"] as? String
//        let notify_id = userInfo["not_id"] as? String
//        let message = data?["body"]  as? String
//        NotificationHelper.notificationSeen(id: notify_id?.description ?? "0"){}
//        let redirectVC = NotificationHelper.notifcationVC(status: status?.description ?? "", redirect_id: redirect_id?.description ?? "",message: message ?? "",title: title ?? "")
//        if redirectVC != nil{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                if var topController = UIApplication.shared.keyWindow?.rootViewController {
//                    while let presentedViewController = topController.presentedViewController {
//                        topController = presentedViewController
//                    }
//                    topController.present(redirectVC!, animated: true, completion:nil)
//                }else{
//                }
//            }
//        }
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
//        AppFactory.fcmToken = fcmToken
        print(fcmToken)
        Messaging.messaging().subscribe(toTopic: "all") { error in
          print("Subscribed to all topic")
        }

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    
    
    // [END ios_10_data_message]
}
