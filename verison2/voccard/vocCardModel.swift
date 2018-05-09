//
//  vocCardModel.swift
//  test4
//
//  Created by 尹笑康 on 2018/3/24.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import Foundation

struct vocCardModel{
    private var pointer = -1
    private var category : String
    private var wordList : [String]
    private var level : String
    private var startTime: Date
    private var wordListToString = ""
    
    
    public mutating func  ReturnWord(at temp:Int) -> String{
        pointer = pointer + temp
        if pointer < 0 {
            pointer = -1
            return "Start!"
            
        } else if pointer > wordList.count+1{
            pointer =  wordList.count+1
        }else if pointer == wordList.count{
            return "end"
        }else if pointer ==  wordList.count+1{
            return ""
        }else{
            return wordList[pointer]
        }
        return ""
    }
    
    public mutating func postOnCalendar(learncategory : String) -> Bool{
        if pointer == wordList.count+1{
            viaDatabase.markAsLearned()
            var i = 1
            for learnword in wordList{
                wordListToString.append("NO.\(i): Chinese: \(learnword.components(separatedBy: "+")[0])  English: \(learnword.components(separatedBy: "+")[1])\n")
                i += 1
            }
            let notetitle = "Flipper-\(category)-\(level)"
            let event = addEvent(title: notetitle, note : wordListToString, learnStartTime:  startTime)
            event.add()
            return true
        }
        return false
    }
    
    init(Category : String,wordlist : [String], level : String){
        self.wordList = wordlist
        self.category = Category
        self.level = level
        self.startTime = NSDate() as Date
    }
    
}

