//
//  UIViewExtensions.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 4/6/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(_ duration: TimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        //self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}
