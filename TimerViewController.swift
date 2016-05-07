//
//  File.swift
//  Study Log
//
//  Created by Dale Baker on 17/04/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import UIKit
import CoreData


class TimerViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var counterView2: CounterView!
    
    let timerModel = TimerModel()
    var timer = NSTimer()
    
    @IBAction func startButton(sender: AnyObject) {

        if (!timerModel.timerIsRunning) {
            timerModel.timerIsRunning = true
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
            startButton.setTitle("Stop", forState: UIControlState.Normal)
        }
        else {
            timer.invalidate()
            startButton.setTitle("Resume", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func minusButton(sender: AnyObject) {
        timerReset()
    }
    
    @IBAction func addButton(sender: AnyObject) {
        timerReset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*This function updares the counter and is ran by the timer */
    func updateTime() {
        timerModel.timerSeconds += 1
        Format.display(time: timerModel.timerSeconds, label: timeLabel, prefix: "")
    }
    
    func timerReset() {
        timer.invalidate()
        timerModel.timerReset()
        startButton.setTitle("Start", forState: UIControlState.Normal)
        timeLabel.text = "00:00"
    }

   /*
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var timerSeconds = 0
    var timer = NSTimer()
    var timerRunning = 0
    var savedSeconds = 0
    var currentTimeSlot : NSManagedObject?
    var timeSlot : TimeSlot?
    
    
    /* This is for timeData created from pausing (not yet confirmed via add button) NEED TO BE SAVED */
    var interemediateTimeDataArray = [TimeData]()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var counterView2: CounterView!
    
    
    @IBAction func startButton(sender: AnyObject) {
        
        /* ONLY USED WHEN TIMER IS PAUSED
         This function stops the timer, and changes the start button text to resume */
        func stopTimer() {
            timer.invalidate()
            timerRunning = 0
            startButton.setTitle("Resume", forState: UIControlState.Normal)
        }
        
        /* ONLY USED WHEN TIMER IS PAUSED
         This function saves the current amount of seconds to userDefaults */
        func saveSavedSeconds() {
            savedSeconds += ((timeSlot!.currentSeconds?.integerValue)!)
            userDefaults.setObject(savedSeconds, forKey: "savedSecondsKey")
            userDefaults.synchronize()
        }
        
        /*This is if the timer is not currently running - it creates a timeSlot, saves its startDate to CoreData, begins the timer, sets the status of timer to running, and changes the button text */
        if timerRunning == 0 {
            self.timeSlot!.create()
            saveCurrentTime(self.timeSlot!)
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            timerRunning = 1
            startButton.setTitle("Stop", forState: UIControlState.Normal)
        }
            
            /* This is if the timer is running, it will stop the timer, add an endDate to the timeSlot, create a timeData object and add it to the intermediate timeDataArray, save the timerSeconds, then delete the currentTimeSlot*/
        else {
            stopTimer()
            self.timeSlot!.endTime()
            saveSavedSeconds()
            let timeData = NSEntityDescription.insertNewObjectForEntityForName("TimeData", inManagedObjectContext: managedContext) as? TimeData
            timeData?.createTimeDataFromTimeSlot(self.timeSlot!)
            timeData!.timeSet = tempTimeDataSet
            saveTimeDataSet("temp")
            interemediateTimeDataArray.append(timeData!)
            deleteCurrentTime(self.timeSlot!)
        }
    }
    
    @IBAction func minusButton(sender: AnyObject) {
        clearTimerTime()
    }
    
    /* It will add the endTime to the class's timeSlot, create a timeData object and create a relationship between the timeDataSet and timeData objects, it will then*/
    @IBAction func addButton(sender: AnyObject) {
        self.timeSlot!.endTime()
        if (self.timeSlot!.currentSeconds?.integerValue > 0) {
            let timeData = NSEntityDescription.insertNewObjectForEntityForName("TimeData", inManagedObjectContext: managedContext) as? TimeData
            timeData?.createTimeDataFromTimeSlot(self.timeSlot!)
            timeData!.timeSet = mainTimeDataSet
            updateTimeDataSet("main", dataSet: mainTimeDataSet!)
        }
        for item in interemediateTimeDataArray {
            item.timeSet = mainTimeDataSet
            updateTimeDataSet("main", dataSet: mainTimeDataSet!)
        }
        TimeValues.addTimerTime(timerSeconds)
        clearTimerTime()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        resetButtonBushed()
        resumeTimerValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resumeTimerValues() {
        timeSlot = restoreCurrentTime()
        var savedSeconds2: Int? = userDefaults.objectForKey("savedSecondsKey") as! Int?
        if savedSeconds2 == nil {
            savedSeconds2 = 0
        }
        savedSeconds += savedSeconds2!
        CalculateClass.display(time: timerSeconds, label: timeLabel, prefix: "")
        fillIntermediateDataSet()
        calculateCounterValue()
    }
    
    /*This function deals with resetting the current time if the data is reset in another view*/
    func resetButtonBushed() {
        if CalculateClass.resetButtonPushed == 1 {
            clearTimerTime()
            CalculateClass.resetButtonPushed = 0
        }
        else {
            if timerRunning == 0 {
                timerSeconds = savedSeconds
                if timerSeconds == 0 {
                    timeLabel.text = "00:00"
                }
                else {
                    CalculateClass.display(time: timerSeconds, label: timeLabel, prefix: "")
                }
            }
            else {
                timerSeconds += savedSeconds
                if timerSeconds == 0 {
                    timeLabel.text = "00:00"
                }
                else {
                    CalculateClass.display(time: timerSeconds, label: timeLabel, prefix: "")
                }
            }
        }
    }
    
    /*This function updares the counter and is ran by the timer */
    func updateTime() {
        timerSeconds++
        CalculateClass.display(time: timerSeconds, label: timeLabel, prefix: "")
        calculateCounterValue()
    }
    
    /*This function creates a TimeSlot NSManagedObject and saves its beginDate
     used for saving an unfinished timeSlot */
    func saveCurrentTime(time: TimeSlot) {
        
        let entity =  NSEntityDescription.entityForName("TimeSlot", inManagedObjectContext:managedContext)
        let classes = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        classes.setValue(timeSlot!.beginDate, forKey: "beginDate")
        
        do {
            try managedContext.save()
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    /*This function returns an unfinished timeSlot if it exists, and if it does exist, it starts the timer */
    func restoreCurrentTime() -> TimeSlot {
        func retrieveCurrentTime() -> TimeSlot? {
            let fetchRequest = NSFetchRequest(entityName: "TimeSlot")
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest) as? [TimeSlot]
                if let values = results{
                    if values.count > 0 {
                        let value = values[0]
                        if value.beginDate != nil {
                            timerSeconds = value.timeSinceBeginDate()
                            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
                            timerRunning = 1
                            startButton.setTitle("Stop", forState: UIControlState.Normal)
                        }
                        return value
                    }
                }
            }
            catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            return nil
        }
        let time = retrieveCurrentTime()
        if time == nil {
            timeSlot = NSEntityDescription.insertNewObjectForEntityForName("TimeSlot", inManagedObjectContext: managedContext) as? TimeSlot
        }
        else {
            timeSlot = time!
        }
        return timeSlot!
    }
    
    //This function needs looking at.
    func deleteCurrentTime(time: TimeSlot) {
        managedContext.deleteObject(time)
        let entity = NSEntityDescription.entityForName("TimeSlot", inManagedObjectContext:managedContext)
        managedContext.deleteAllObjectsForEntity(entity!)
        self.timeSlot = NSEntityDescription.insertNewObjectForEntityForName("TimeSlot", inManagedObjectContext: managedContext) as? TimeSlot
        do {
            try managedContext.save()
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func clearTimerTime() {
        timer.invalidate()
        timerRunning = 0
        startButton.setTitle("Start", forState: UIControlState.Normal)
        timeLabel.text = "00:00"
        deleteCurrentTime(self.timeSlot!)
        userDefaults.removeObjectForKey("savedSecondsKey")
        timerSeconds = 0
        calculateCounterValue()
        tempTimeDataSet!.timeData = nil
    }
    
    func calculateCounterValue() {
        var counterValue = 0
        var counterIteration = 0
        var seconds = timerSeconds
        var seconds2 = timerSeconds
        for (; seconds >= (3600 / counterView2.number) ; seconds -= (3600 / counterView2.number)){
            counterValue++
        }
        for (;counterValue >= counterView2.number; counterValue -= counterView2.number) {
        }
        for (; seconds2 >= 3600; seconds2 -= 3600) {
            counterIteration++
        }
        counterView2.counter = counterValue
        if counterIteration == 0 {
            counterView2.counterColor = colors.orange1
            counterView2.outlineColor = colors.red1
        }
        if counterIteration == 1 {
            counterView2.counterColor = colors.turquoise2
            counterView2.outlineColor = colors.green2
        }
        if counterIteration == 2 {
            counterView2.counterColor = colors.blue3
            counterView2.outlineColor = colors.purple3
        }
        if counterIteration == 3 {
            counterView2.counterColor = colors.black4
            counterView2.outlineColor = colors.white4
        }
        if (counterIteration > 3) {
            counterIteration = counterIteration % 3
        }
    }
    
    func fillIntermediateDataSet() {
        for item in (tempTimeDataSet?.timeData!)! {
            let item = item as! TimeData
            interemediateTimeDataArray.append(item)
        }
    }*/
    
}
