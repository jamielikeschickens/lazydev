//
//  AppDelegate.swift
//  LazyDev
//
//  Created by Jamie Maddocks on 28/07/2015.
//  Copyright (c) 2015 Jamie Maddocks. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let createParticipantEndpoint = "http://api.rusic.com/participants"
    private let bucketShowEndpoint = "http://api.rusic.com/buckets/" + Credentials().bucketID


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let params = ["participant[provider]": "twitter", "participant[nickname]": "lazydev",
            "participant[uid]": NSUUID().UUIDString]
        let headers = ["X-API-Key": Credentials().apiKey, "Accept": "application/vnd.rusic.v1+json"]
        Alamofire.request(.POST, createParticipantEndpoint, parameters: params, encoding: ParameterEncoding.URL, headers: headers).responseJSON { _, _, json, _ in
                let d = NSUserDefaults.standardUserDefaults()
            d.setObject(json!["token"], forKey: "token")
            NSNotificationCenter.defaultCenter().postNotificationName("participantTokenRecieved", object: nil)
        }
        
        Alamofire.request(.GET, bucketShowEndpoint, parameters: nil, encoding: .URL, headers: headers).responseJSON {(_, _, json, _) in
            let d = NSUserDefaults.standardUserDefaults()
            d.setObject(json!["title"], forKey: "space_title")
            NSNotificationCenter.defaultCenter().postNotificationName("spaceTitleRecieved", object: nil)
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

