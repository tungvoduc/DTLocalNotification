//
//  CustomLocalNotificationViewController.swift
//  DTLocalNotification_Example
//
//  Created by Admin on 14/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import DTLocalNotification

class CustomLocalNotificationViewController: DTLocalNotificationViewController {
    struct Dimension {
        static let horizontalInset: CGFloat = 10
        static let topInset: CGFloat = UIEdgeInsets.safeAreaInset.top > 0 ? UIEdgeInsets.safeAreaInset.top + 10 : 30
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    init(pokemon: Pokemon) {
        let view = SecondNotificationView.notificationView()
        view.setName(pokemon.name)
        view.setImage(pokemon.image)
        view.setDescription(pokemon.dialog)
        super.init(notificatonView: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (notificationView as! SecondNotificationView).insertShadow(color: UIColor.black, opacity: 0.15, radius: 5, offset: CGSize(width: 0, height: 1))
        (notificationView as! SecondNotificationView).shadowView.layer.cornerRadius = 10
        (notificationView as! SecondNotificationView).shadowView.layer.masksToBounds = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        notificationView.frame = CGRect(origin: CGPoint(x: Dimension.horizontalInset, y: Dimension.topInset), size: CGSize(width: view.frame.width - 2 * Dimension.horizontalInset, height: view.frame.height - Dimension.topInset))
    }
}
