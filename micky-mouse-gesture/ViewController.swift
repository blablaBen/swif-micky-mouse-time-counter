//
//  ViewController.swift
//  micky-mouse-gesture
//
//  Created by Pattarasai Markpeng on 10/14/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var gestureStartPoint: CGPoint!;
    
    private let minimumGestureLength = Float(25);
    private let maximumVarience = Float(5);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches: NSSet! = event?.allTouches as! NSSet;
        let touch = touches.anyObject() as! UITouch;
        gestureStartPoint = touch.location(in: self.view);
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches: NSSet! = event?.allTouches as! NSSet;
        let touch = touches.anyObject() as! UITouch;
        let currentPosition = touch.location(in: self.view);
        
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x));
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y));
        
        if(deltaX >= minimumGestureLength && deltaY <= maximumVarience) {
            print("swipe X")
        }
        
        if(deltaY >= minimumGestureLength && deltaX <= maximumVarience) {
            print("swipe Y")
        }
    }
    
    

}

