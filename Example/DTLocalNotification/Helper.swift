//
//  Helper.swift
//  DTLocalNotification_Example
//
//  Created by Admin on 28/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static var safeAreaInset: UIEdgeInsets {
        guard let rootView = UIApplication.shared.keyWindow, #available(iOS 11.0, *) else { return UIEdgeInsets.zero }
        
        return rootView.safeAreaInsets
    }
}
