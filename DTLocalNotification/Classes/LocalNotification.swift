//
//  DTLocalNotification.swift
//  DTLocalNotification
//
//  Created by Admin on 27/02/2018.
//

import Foundation

//MARK: DTLocalNotification
public class DTLocalNotification: NSObject {
    
    /// Notification view style
    public var style: DTNotificationViewStyle = DTDefaultNotificationViewStyle()
    
    /// View controller
    public internal(set) var viewController: DTLocalNotificationViewController
    
    /// Waiting time before dismissing
    /// If less than 0, will not be auto-dismissed
    public var showingTime: TimeInterval = 3
    
    /// Window
    var window: UIWindow! = {
        let window = UIWindow()
        return window
    }()
    
    /// Indicates whether or not notification has been dismissed ()
    public internal(set) var isDismissed = false
    
    // First time layout subview
    public internal(set) var isShown = false
    
    // Timer to auto dismiss view
    var dismissingTimer: Timer?
    
    
    // Initilizer
    public init(view: UIView) {
        viewController = DTLocalNotificationViewController(notificatonView: view)
        super.init()
        commonInit()
    }
    
    public init(viewController controller: DTLocalNotificationViewController) {
        viewController = controller
        super.init()
        commonInit()
    }
    
    func commonInit() {
        window.rootViewController = viewController
        window.windowLevel = UIWindow.Level.statusBar
        window.backgroundColor = UIColor.clear
    }
    
    deinit {
        print("DTLocalNotification deinit\n")
    }
    
    
    // Timer
    func activateTimer(target: Any, selector: Selector, userInfo: Any?, repeats: Bool) {
        dismissingTimer?.invalidate()
        
        if showingTime > 0 {
            // Not allow auto dismiss if showing time is less than or equal to 0
            dismissingTimer = Timer.scheduledTimer(timeInterval: showingTime, target: target, selector: selector, userInfo: userInfo, repeats: repeats)
        }
    }
    
    func invalidateTimer() {
        dismissingTimer?.invalidate()
    }
}
