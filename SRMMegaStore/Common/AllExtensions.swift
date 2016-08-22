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