//
//  ViewController.swift
//  DynamicsTeste
//
//  Created by Heitor Ishihara on 16/05/17.
//  Copyright © 2017 Heitor Ishihara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var firstContact = false
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.gray
        view.addSubview(square)
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        gravity.magnitude = 0.1
        
        animator.addBehavior(gravity)
        
        
        collision = UICollisionBehavior(items: [square])
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)
        
        
        //Delegates
        collision.collisionDelegate = self
        
        //        collision.action = {
        //            print("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint(square.center))")
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(String(describing: identifier))")
        
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = UIColor.gray
        }
        
//        if (!firstContact) {
//            firstContact = true
//            
//            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
//            square.backgroundColor = UIColor.gray
//            view.addSubview(square)
//            
//            collision.addItem(square)
//            gravity.addItem(square)
//            
//            let attach = UIAttachmentBehavior(item: collidingView, attachedTo:square)
//            animator.addBehavior(attach)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.first
        snap = UISnapBehavior(item: square, snapTo: (touch?.location(in: view))!)
        animator.addBehavior(snap)
    }
    
}

