//
//  ExampleViews.swift
//  DTLocalNotification_Example
//
//  Created by Admin on 28/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

/// Base view
class BaseView: UIView {
    
    var shadowView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        insertSubview(shadowView, at: 0)
        shadowView.frame = bounds
    }
    
    func insertShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}

/// Example view 1
class SimpleNotificationView: BaseView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static var defaultHeight: CGFloat { return 130 }
    
    class func notificationView() -> SimpleNotificationView {
        let nib = UINib(nibName: "SimpleNotificationView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! SimpleNotificationView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func setName(_ name: String?) {
        nameLabel.text = name
    }
    
    func setDescription(_ description: String?) {
        descriptionLabel.text = description
    }
}

//Example view 2
class SecondNotificationView: BaseView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static var defaultHeight: CGFloat { return 170 }
    
    class func notificationView() -> SecondNotificationView {
        let nib = UINib(nibName: "SecondNotificationView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! SecondNotificationView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func setName(_ name: String?) {
        nameLabel.text = name
    }
    
    func setDescription(_ description: String?) {
        descriptionLabel.text = description
    }
}
