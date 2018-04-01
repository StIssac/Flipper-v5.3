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
    
    let eventStore = EKEventStore()
    func add(){
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) {(granted, error) in
            
            do {
                if((error) != nil)
                {
                    //添加错误
                }
                else if(!granted)
                {
                    //无访问日历权限
                }
                else
                {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = self.title
                    event.location = self.note
                    //起止时间
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let startTime = NSDate()
                    let endTime = NSDate()
                    print("startTime:\(String(describing: startTime))")
                    event.isAllDay = true
                    event.startDate = startTime as Date!
                    event.endDate = endTime as Date!
                    //在事件前多少秒开始事件提醒
                    //                    let alarm = EKAlarm()
                    //                    alarm.relativeOffset = -60.0
                    //                    event.addAlarm(alarm)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    let result:()? = try eventStore.save(event, span: EKSpan.thisEvent)
                    print("result:\(String(describing: result))")
                    
                }
            }
            catch {
                print("error")
            }
        }
        
    }
    
    
    
    init(title:String, note:String){
        self.note = note
        self.title = title
    }
}

