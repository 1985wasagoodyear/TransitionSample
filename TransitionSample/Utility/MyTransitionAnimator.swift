//
//  MyTransitionAnimator.swift
//  Created 3/4/20
//  Using Swift 5.0
// 
//  Copyright © 2020 Yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//


import UIKit
/*
class MyTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationTime: TimeInterval
    let view: UIView        // view to move, from current VC
    let endRect: CGRect     // final destination of view, in second VC
    
    init(view: UIView, destinationRect endRect: CGRect) {
        animationTime = 0.25
        self.view = view
        self.endRect = endRect
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let currVC = transitionContext.view(forKey: .from),
            let nextVC = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(true)
                return
        }
        
        // move the current view to the top
        view.superview?.bringSubviewToFront(view)
        
        container.addSubview(nextVC)
        currVC.alpha = 1.0
        nextVC.alpha = 0.0
        let start = view.frame
        
        UIView.animateKeyframes(withDuration: animationTime,
                                delay: .zero,
                                options: .calculationModeCubic,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.50) {
                                     //   currVC.alpha = 0.0
                                    }
                                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0) {
                                        self.view.frame = self.endRect
                                       //
                                    }
        }) { (finished) in
            if finished {
                
                transitionContext.completeTransition(true)
                self.view.frame = start
                nextVC.alpha = 1.0
            }
        }
    }
}
*/

class MyTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationTime: TimeInterval
    let view: UIView        // view to move, from current VC
    let endRect: CGRect     // final destination of view, in second VC
    
    init(view: UIView, destinationRect endRect: CGRect) {
        animationTime = 0.25
        self.view = view
        self.endRect = endRect
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let currVC = transitionContext.view(forKey: .from),
            let nextVC = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(true)
                return
        }
        
        // move the current view to the top
        view.superview?.bringSubviewToFront(view)
        
        let animation: () -> Void
        let completion: (Bool) -> Void
        
        container.addSubview(nextVC)
        currVC.alpha = 1.0
        nextVC.alpha = 0.0
        let start = view.frame
        animation = {
            self.view.frame = self.endRect
        }
        completion = { finished in
            if finished {
                nextVC.alpha = 1.0
                transitionContext.completeTransition(true)
                self.view.frame = start
            }
        }
        
        UIView.animate(withDuration: animationTime,
                       animations: animation,
                       completion: completion)
    }
}


