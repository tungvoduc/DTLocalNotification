//
//  LocalNotificationManager.swift
//  DTLocalNotification
//
//  Created by Admin on 28/02/2018.
//

import Foundation

public class DTLocalNotificationPresenter: NSObject {
    // List of all visible notifications
    // This array helps to capture notification instance.
    // Remove notification object out of array will release notification, should only do that after notification is dismissed.
    public static var activeNotifications: [DTLocalNotification] = [DTLocalNotification]()
    
    /// Show notification
    /// When subclassing DTLocalNotificationPresenter and override this method, make sure that DTLocalNotificationPresenter.activeNotifications.append(notification) will always be called or implement your own method to keep strong reference of notification object. Otherwise notification will not be displayed.
    open func showNotification(_ notification: DTLocalNotification, completion: ((Bool) -> Void)?) {
        // Keep strong reference to notification.
        DTLocalNotificationPresenter.activeNotifications.append(notification)
        
        // Original y value is above y-axis (Not visible)
        if !notification.isShown {
            notification.window.isHidden = false
            
            let finalFrame = getDefaultWindowFrame(from: notification)
            notification.window.frame = initialWindowFrame(for: finalFrame)
            notification.window.addSubview(notification.viewController.view)
            notification.viewController.view.frame = CGRect(origin: CGPoint.zero, size: finalFrame.size)
            
            UIView.animate(withDuration: 0.3, animations: {
                notification.window.frame = finalFrame
            }, completion: { (finished: Bool) in
                // Completion handler
                notification.isShown = true
                self.activateTimer(for: notification)
                completion?(finished)
            })
        }
    }
    
    /// Dismiss notification
    /// When subclassing DTLocalNotificationPresenter and override this method, make sure that strong reference of notification object will be removed. Otherwise notification will not be released.
    @objc open func dismissNotification(_ notification: DTLocalNotification, completion: ((Bool) -> Void)?) {
        // Make sure that the view is not being dismissed, dismiss called twice will crash the app
        if !notification.isDismissed {
            notification.isDismissed = true
            let currentFrame = notification.window.frame
            let finalFrame = initialWindowFrame(for: currentFrame)
            
            UIView.animate(withDuration: 0.2, animations: {
                notification.window.frame = finalFrame
            }, completion: {[weak notification] (finished: Bool) in
                
                if let notification = notification {
                    // Completion handler
                    notification.window.windowLevel = UIWindow.Level.normal
                    notification.window.isHidden = true
                    notification.window.rootViewController = nil
                    notification.window = nil // Make this line of code to make sure that object will be released
                    
                    if let window = UIApplication.shared.windows.filter({ $0 != notification.window }).first {
                        window.rootViewController?.setNeedsStatusBarAppearanceUpdate()
                    }
                    
                    completion?(finished)
                    
                    if let index = DTLocalNotificationPresenter.activeNotifications.firstIndex(of: notification) {
                        // Release strong reference of notification
                        DTLocalNotificationPresenter.activeNotifications.remove(at: index)
                    }
                }
            })
        }
    }
    
    // Handle timer call to dismiss
    @objc func dismissNotification(_ timer: Timer) {
        if let notification = timer.userInfo as? DTLocalNotification {
            dismissNotification(notification, completion: nil)
        }
    }
    
    // Activate timer for auto dismiss
    func activateTimer(for notification: DTLocalNotification) {
        notification.activateTimer(target: self, selector: #selector(dismissNotification(_:)), userInfo: notification, repeats: false)
    }
    
    /// This method calculate final window frame appear on device screen after animation
    /// Override this method if you want custom frame calculation.
    open func getDefaultWindowFrame(from notification: DTLocalNotification) -> CGRect {
        let style = notification.style
        
        // If height is less than zero, and topInset and bottomInset are less than zero then window height is undefined
        if style.topInset < 0 && style.bottomInset < 0 {
            return CGRect.zero
        }
        else if (style.topInset < 0 || style.bottomInset < 0) && style.height <= 0 {
            return CGRect.zero
        }
        
        // If height is less than zero, and topInset and bottomInset are less than zero then window height is undefined
        if style.leftInset < 0 && style.rightInset < 0 {
            return CGRect.zero
        }
        else if (style.leftInset < 0 || style.rightInset < 0) && style.width <= 0 {
            return CGRect.zero
        }
        
        // Calculate frame
        var frame = CGRect.zero
        let screenSize = UIScreen.main.bounds.size
        
        // Calculate height & y
        if style.height > 0 {
            frame.size.height = style.height
            
            if style.topInset >= 0 {
                frame.origin.y = style.topInset
            }
            else {
                frame.origin.y = screenSize.height - style.bottomInset
            }
        }
        else {
            frame.size.height = abs(screenSize.height - style.bottomInset - style.topInset)
            frame.origin.y = style.topInset
        }
        
        // Calculate width & x
        if style.width > 0 {
            frame.size.width = style.width
            
            if style.leftInset >= 0 {
                frame.origin.x = style.leftInset
            }
            else {
                frame.origin.x = screenSize.width - style.rightInset
            }
        }
        else {
            frame.size.width = abs(screenSize.width - style.rightInset - style.leftInset)
            frame.origin.x = style.leftInset
        }
        
        return frame
    }
    
    
    /// Initial window frame before animation based on final window frame
    /// Default value is right above screen top edge
    open func initialWindowFrame(for finalWindowFrame: CGRect) -> CGRect {
        var frame = finalWindowFrame
        frame.origin.y = -finalWindowFrame.height // Right above screen top edge
        return frame
    }
}
