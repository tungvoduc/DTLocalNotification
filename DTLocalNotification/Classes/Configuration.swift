//
//  Configuration.swift
//  DTLocalNotification
//
//  Created by Admin on 27/02/2018.
//

import Foundation

public protocol DTNotificationViewStyle {
    /// Define height of notification view
    /// If not greater than 0, topInset and bottomInset will be used to determine
    /// notification view height.
    /// Override bottomInset if both topInset and bottomInset values are greater than 0
    var height: CGFloat { get set }
    
    /// Define width of notification view
    /// If not greater than 0, rightInset and leftInset will be used to determine
    /// notification view width.
    /// Override rightInset if both leftInset and rightInset values are greater than 0
    var width: CGFloat { get set }
    
    /// Define inset of notification view to device top edge.
    var topInset: CGFloat { get set }
    
    /// Define inset of notification view to device bottom edge.
    /// Will be override if topInset and height are greater than 0.
    var bottomInset: CGFloat { get set }
    
    /// Define inset of notification view to device right edge.
    var rightInset: CGFloat { get set }
    
    /// Define inset of notification view to device left edge.
    /// Will be override if rightInset and width are greater than 0.
    var leftInset: CGFloat { get set }
}

struct DTDefaultNotificationViewStyle: DTNotificationViewStyle {
    var height: CGFloat
    var width: CGFloat
    var topInset: CGFloat
    var bottomInset: CGFloat
    var rightInset: CGFloat
    var leftInset: CGFloat
    
    // Initializer
    // Should create your own default values
    init(height: CGFloat = -1, width: CGFloat = -1, topInset: CGFloat = -1, bottomInset: CGFloat = -1, rightInset: CGFloat = -1, leftInset: CGFloat = -1) {
        self.height = height
        self.width = height
        self.topInset = height
        self.bottomInset = height
        self.rightInset = height
        self.leftInset = height
    }
}
