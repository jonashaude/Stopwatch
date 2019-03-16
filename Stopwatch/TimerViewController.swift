//
//  TimerViewController.swift
//  Stopwatch
//
//  Created by Jonas Haude on 16.03.19.
//  Copyright © 2019 Jonas Haude. All rights reserved.
//

import Cocoa

class TimerViewController: NSViewController{
    
    var timer: WatchTimer!
    
    @IBOutlet weak var picker: NSDatePicker!
    
    @IBAction func start(_ sender: StartButton) {
        //Start the Timer
        if(sender.isStart){
            sender.isStart = false
            timer.start()
            
            //Stop the Timer
        }else{
            sender.isStart = true
            timer.stop()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = WatchTimer(updateField: picker)
    }
}

class WatchTimer{
    
    private var timer: Timer!
    private var field: NSDatePicker!
    
    public init(updateField: NSDatePicker){
        field = updateField

    }
    
    /*
     Starts the StopWatch
     */
    func start(){
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
        }
    }
    
    /*
     Stops the StopWatch
     */
    func stop(){
        timer.invalidate()
        timer = nil
    }
    
    /*
     Reset the StopWatch
     */
    func reset(){
        timer = nil
    }
    
    /*
     Updates the Time Integer
     */
    @objc private func UpdateTimer(){
        print(field.dateValue)
        if(field.dateValue.compare(Date(timeIntervalSince1970: TimeInterval(0))) == ComparisonResult.orderedSame){
        }
        
        field.dateValue.addTimeInterval(TimeInterval(exactly: -1)!)
    }
}
