//
//  addEvent.swift
//  test4
//
//  Created by 尹笑康 on 2018/3/24.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import Foundation
import EventKit

class addEvent{
    
    private var note : String
    private var title : String
    private var learnStartedTime : Date
    
    let eventStore = EKEventStore()
    
    func add(){
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) {(granted, error) in
            
            do {
                if((error) != nil)
                {
                }
                else if(!granted)
                {
                }
                else
                {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = self.title
                    event.location = "Word Today:\n"+self.note
                    let endTime = NSDate()
                    event.isAllDay = false
                    event.startDate = self.learnStartedTime  as Date?
                    event.endDate = endTime as Date?
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    self.addReview()
                    let result:()? = try eventStore.save(event, span: EKSpan.thisEvent)
                    print("result:\(String(describing: result))")
                    
                    
                    
                }
            }
            catch {
                print("error")
            }
        }
        
    }
    
    private func addReview(){
        let event = EKEvent(eventStore: eventStore)
        event.title = "Flipper: Review Time!"
        event.location = "Let's review!\n"+self.note
        let alarm = EKAlarm()
        alarm.relativeOffset = -60
        event.addAlarm(alarm)
        event.isAllDay = false
        let startTime = self.learnStartedTime.addingTimeInterval(3600*24)
        let endTime = startTime.addingTimeInterval(60)
        event.startDate = startTime  as Date?
        event.endDate = endTime as Date?
        event.calendar = eventStore.defaultCalendarForNewEvents
        do{
            let result:()? = try eventStore.save(event, span: EKSpan.thisEvent)
            print("result:\(String(describing: result))")
        } catch let error as NSError{
            Swift.print(error)
        }
        
    }
    
    
    init(title:String, note:String, learnStartTime:Date ){
        self.note = note
        self.title = title
        self.learnStartedTime = learnStartTime
    }
}

