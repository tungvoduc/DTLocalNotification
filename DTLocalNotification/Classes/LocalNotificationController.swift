//
//  DTLocalNotificationViewController.swift
//  DTLocalNotification
//
//  Created by Admin on 27/02/2018.
//

import Foundation

/// Class DTLocalNotificationViewController
open class DTLocalNotificationViewController: UIViewController {
    
    /// Notification view
    public var notificationView: UIView
    
    public init(notificatonView view: UIView) {
        notificationView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(notificationView)
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        notificationView.frame = CGRect(origin: CGPoint.zero, size: view.bounds.size)
    }
}
