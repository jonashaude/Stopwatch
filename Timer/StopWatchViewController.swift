//
//  StopWatchViewController.swift
//  Timer
//
//  Created by Jonas Haude on 16.03.19.
//  Copyright © 2019 Jonas Haude. All rights reserved.
//

import Cocoa

class StopWatchViewController: NSViewController {

    
    
    @IBOutlet weak var time: NSTextField!
    @IBOutlet weak var round: RoundButton!
    
    var stopWatch: StopWatch!
    /*
        Start and Stop the Watch with one Button
    */
    @IBAction func start(_ sender: StartButton) {
        //Start the Watch
        if(sender.isStart){
            sender.isStart = false
            round.isRound = true
            stopWatch.start()
            
        //Stop the Watch
        }else{
            sender.isStart = true
            round.isRound = false
            stopWatch.stop()
        }

    }
    
    /*
        Rounds and Reset the Watch with one Button
    */
    @IBAction func round(_ sender: RoundButton) {
        //Add Round
        if(sender.isRound){
            
        //Reset the Watch
        }else{
            stopWatch.reset()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stopWatch = StopWatch(updateLabel: time)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

class StartButton: NSButton{
    struct Holder {
        static var _isStart: Bool = true
    }
    
    var isStart: Bool {
        get {
            return Holder._isStart
        }
        set(newValue) {
            Holder._isStart = newValue
            
            if(newValue){
                self.title = "Start"
            }else{
                self.title = "Stop"
            }
        }
    }
}

class RoundButton: NSButton{
    struct Holder {
        static var _isRound: Bool = true
    }
    
    var isRound: Bool {
        get {
            return Holder._isRound
        }
        set(newValue) {
            Holder._isRound = newValue
            
            if(newValue){
                self.title = "Round"
            }else{
                self.title = "Reset"
            }
        }
    }
}


class StopWatch{
    var isRunning: Bool
    var time: Double
    private var timer: Timer!
    private var timeLabel: NSTextField
    
    public init(updateLabel: NSTextField){
        isRunning = false
        time = 0
        timeLabel = updateLabel
    }
    
    /*
        Starts the StopWatch
    */
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isRunning = true
    }
    
    /*
        Stops the StopWatch
     */
    func stop(){
        isRunning = false
        timer.invalidate()
        timer = nil
    }
    
    /*
        Reset the StopWatch
     */
    func reset(){
        isRunning = false
        time = 0
        timeLabel.stringValue = "00:00,00"
        timer = nil
    }
    
    /*
        Updates the Time Integer
     */
    @objc private func UpdateTimer(){
        time += 0.01
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss,SS"
        
        timeLabel.stringValue = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: time)!))
    }
    
}
