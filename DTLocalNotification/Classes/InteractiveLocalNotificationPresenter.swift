//
//  InteractiveLocalNotificationManager.swift
//  DTLocalNotification
//
//  Created by Admin on 11/03/2018.
//

import UIKit

public class DTInteractiveLocalNotificationPresenter: DTLocalNotificationPresenter {
    public var flickingSpeedToDismissThreshold: CGFloat = -400
    
    public var heightChangeLimit: CGFloat = 100
    
    public static var shared: DTInteractiveLocalNotificationPresenter {
        struct Singleton {
            static var manager: DTInteractiveLocalNotificationPresenter!
        }
        
        if Singleton.manager == nil {
            Singleton.manager = DTInteractiveLocalNotificationPresenter()
        }
        
        return Singleton.manager
    }
    
    public override func showNotification(_ notification: DTLocalNotification, completion: ((Bool) -> Void)?) {
        super.showNotification(notification) { (finished) in
            completion?(finished)
            self.addDefaultPanGestureRecognizer(to: notification)
        }
    }
    
    /// Call this method if you want to add default pan gesture into notification window
    public func addDefaultPanGestureRecognizer(to notification: DTLocalNotification) {
        // Add gesture recognizer to window, it does not work on view level
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandled(_:)))
        notification.window.isUserInteractionEnabled = true
        notification.window.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panGestureHandled(_ gestureRecognier: UIPanGestureRecognizer) {
        if let window = gestureRecognier.view as? UIWindow {
            for notification in DTLocalNotificationPresenter.activeNotifications {
                if notification.window == window {
                    if !notification.isDismissed {
                        if gestureRecognier.state == UIGestureRecognizerState.began {
                            // When user starts dragging, invalidate timer
                            notification.invalidateTimer()
                        }
                        else if gestureRecognier.state == UIGestureRecognizerState.changed {
                            let frame = getDefaultWindowFrame(from: notification)
                            
                            // Update vertical position
                            let y = gestureRecognier.translation(in: window).y
                            
                            if y > 0 {
                                let height = logConstraintValueForValue(frame.height + y, limit: frame.height)
                                
                                // Update height
                                window.frame.size.height = height
                                notification.viewController.view.frame = window.bounds
                            }
                            else {
                                // Update y
                                window.frame.origin.y = frame.origin.y + y
                                window.frame.size.height = frame.height
                            }
                        }
                        else if gestureRecognier.state == UIGestureRecognizerState.ended {
                            if gestureRecognier.velocity(in: window).y < flickingSpeedToDismissThreshold {
                                dismissNotification(notification, completion: nil)
                            }
                            else {
                                let frame = getDefaultWindowFrame(from: notification)
                                
                                // Update vertical position
                                let y: CGFloat = gestureRecognier.translation(in: window).y
                                
                                
                                if -y >= frame.height/3 {
                                    // Dismiss if dragged more than half of its height
                                    dismissNotification(notification, completion: nil)
                                }
                                else {
                                    // Go back to original frame
                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseOut, animations: {
                                        window.frame = frame
                                        notification.viewController.view.setNeedsLayout()
                                        notification.viewController.view.layoutIfNeeded()
                                    }, completion: { (_) in
                                        self.activateTimer(for: notification)
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logConstraintValueForValue(_ value : CGFloat, limit: CGFloat) -> CGFloat {
        print(value/limit)
        return limit * (1 + log10(value/limit))
    }
}
