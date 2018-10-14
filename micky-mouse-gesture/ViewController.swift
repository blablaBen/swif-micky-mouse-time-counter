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
    private let minimumGestureLength = Float(40);
    private let maximumVarience = Float(5);
    
    @IBOutlet weak var timeCounter: UILabel!;
    var timeMinCount = 1;
    var timeSecCount = 0;
    var timer = Timer();
    var isCounting = false;
    
    
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
            if(Float(gestureStartPoint.x - currentPosition.x) <= 0.0) {
                timeSecCount = timeSecCount + 10;
            } else {
                timeSecCount = timeSecCount - 10;
            }
            if(timeSecCount >= 60) {
                timeMinCount = timeMinCount + 1;
                timeSecCount = 0;
            }
            
            if(timeSecCount < 0) {
                timeMinCount = timeMinCount-1 <= 0 ? 0 : timeMinCount-1;
                timeSecCount = 0;
            }
            
            timeCounter.text = "\(String(format: "%02d", timeMinCount)):\(String(format: "%02d", timeSecCount))";
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches: NSSet! = event?.allTouches as! NSSet;
        let touch = touches.anyObject() as! UITouch;
        let currentPosition = touch.location(in: self.view);
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x));
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y));
        
        if(deltaX <= minimumGestureLength && deltaY <= minimumGestureLength) {
            runTimer();
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeSecCount = timeSecCount - 1;
        calculateAndUpdateTimerLabel();
    }
    
    func calculateAndUpdateTimerLabel() {
        if(timeSecCount < 0) {
            timeMinCount = timeMinCount-1 <= 0 ? 0 : timeMinCount-1;
            timeSecCount = 59;
        }
        
        timeCounter.text = "\(String(format: "%02d", timeMinCount)):\(String(format: "%02d", timeSecCount))";
    }
    
    

}

