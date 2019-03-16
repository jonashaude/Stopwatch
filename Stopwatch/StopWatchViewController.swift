//
//  StopWatchViewController.swift
//  Stopwatch
//
//  Created by Jonas Haude on 16.03.19.
//  Copyright © 2019 Jonas Haude. All rights reserved.
//

import Cocoa


class StopWatchViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    var dataForTable: [String] = []
    
    @IBOutlet weak var time: NSTextField!
    @IBOutlet weak var round: RoundButton!
    @IBOutlet weak var table: NSTableView!
    
    
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
            dataForTable.append(stopWatch.timeString)
            table.reloadData()
            
        //Reset the Watch
        }else{
            stopWatch.reset()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        stopWatch = StopWatch(updateLabel: time)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataForTable.count
    }
    
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let cell = NSCell(textCell: dataForTable[row])
        print(cell.title)
        cell.isEnabled = true
        cell.isHighlighted = true
        return cell
        
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
    var timeString: String!
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
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
        }
        
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
        
        timeString = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: time)!))
        timeLabel.stringValue = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: time)!))
    }
    
}
