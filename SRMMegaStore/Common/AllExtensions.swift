//
//  AllExtensions.swift
//  SRMMegaStore
//
//  Created by Sagar Musale on 22/08/16.
//  Copyright © 2016 SRM. All rights reserved.
//

/*
 *  Extensions for all elements will be here
 */

import UIKit

// MARK: UILabel
extension UILabel{
    
    // Setting Label textColor and textFont
    func setProperties(textColor: UIColor? = nil, textFont: UIFont? = nil) {
        
        if let lblColor = textColor{
            self.textColor = lblColor
        }
        
        if let lblFont = textFont{
            self.font = lblFont
        }
    }
}

// MARK: UIButton
extension UIButton{
    
    // Setting textColor, textFont and backgroundColor
    func setProperties(textColor: UIColor? = nil, textFont: UIFont? = nil, backgroundColor: UIColor? = UIColor.clearColor()) {
        
        self.backgroundColor = backgroundColor!
        
        if let lblColor = textColor{
            self.setTitleColor(lblColor, forState: .Normal)
        }
        
        if let lblFont = textFont{
            self.titleLabel?.font = lblFont
        }
    }
}

// MARK: UIView
extension UIView{
    
    // Getting view width
    func viewWidth()->CGFloat{
        return self.frame.size.width
    }
    
    // Getting view width
    func viewHeight()->CGFloat{
        return self.frame.size.height
    }
    
    // Making view rounded with corner radius, border width and borderColor
    func makeViewWithRoundedCorner(cornerRadius: CGFloat! = nil, withBorderWidth borderWidth: CGFloat! = nil, withBorderColor borderColor: CGColor! = nil) {
        // Corner Radius
        if let radius = cornerRadius{
            self.layer.cornerRadius = radius
        }
        // Border Width
        if let width = borderWidth{
            self.layer.borderWidth = width
        }
        // Border Color
        if let color = borderColor {
            self.layer.borderColor = color
        }
    }
}

// MARK: UIViewController
extension UIViewController{
    
    // Showing popover if it is iPad or showing as action sheet if it is iPhone
    func showAsAlertController(alertController: UIAlertController, withBarButton barButton: UIBarButtonItem? = nil){
        
        if isPhone() {
            // Adding cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
        } else {
            // Showing as popover if it is iPad
            alertController.modalPresentationStyle = .Popover
            if let popover = alertController.popoverPresentationController, let btn = barButton{
                popover.barButtonItem = btn
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Show confirmation alert with one alert action
    func showConfirmationAlertWithTitle(title: String, withMsg msg: String, withAlertAction action: UIAlertAction, withCompletionBlock block:(()->Void)?=nil){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(action)
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true, completion: block)
    }
}

// MARK: UIColor
extension UIColor{
    
    // Color with RGB values
    class func colorWithRGB(red: Int, green: Int, blue: Int)->UIColor{
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    // Color with Hex values
    class func colorWithHex(hex: Int)->UIColor{
        return UIColor.colorWithRGB((hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

// MARK: Open functions

// This functions checks if device is iPhone or other
func isPhone()->Bool{
    var isPhone = false
    // 1. request an UITraitCollection instance
    let deviceIdiom = UIScreen.mainScreen().traitCollection.userInterfaceIdiom
    
    // 2. check the idiom
    switch (deviceIdiom) {
    case .Pad:
        isPhone = false
        
    case .Phone:
        isPhone = true
        
    case .TV:
        isPhone = false
        
    default:
        isPhone = false
        
    }
    return isPhone
}