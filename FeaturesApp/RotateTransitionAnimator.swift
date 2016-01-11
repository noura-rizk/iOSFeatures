//
//  RotateTransitionAnimator.swift
//  NavTransition
//
//  Created by Noura Rizk on 1/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RotateTransitionAnimator: NSObject  ,UIViewControllerAnimatedTransitioning , UIViewControllerTransitioningDelegate {
    var isPresenting = false
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self;
        
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self;
    }
    
    
    let duration = 0.5
    func transitionDuration(transitionContext:
        UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        // Set up the transform we'll use in the animation
        guard let container = transitionContext.containerView() else {
        return
        }
        
        let rotateOut = CGAffineTransformMakeRotation(-90 * CGFloat(M_PI) / 180)
        // Change the anchor point and position
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        // Change the initial position of the toView
        toView.transform = rotateOut
        // Add both views to the container view
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // Add both views to the container view
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [],
            animations: {
            if self.isPresenting {
            fromView.transform = rotateOut
            fromView.alpha = 0
            toView.transform = CGAffineTransformIdentity
            toView.alpha = 1.0
        } else {
            fromView.alpha = 0
            fromView.transform = rotateOut
            toView.alpha = 1.0
            toView.transform = CGAffineTransformIdentity
            }
            }, completion: { finished in
            transitionContext.completeTransition(true)
            })
    }
}
