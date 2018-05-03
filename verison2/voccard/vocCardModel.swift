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
    
    
    private var wordListToString = "Word Today:\n"
    
    
    public mutating func  ReturnWord(at temp:Int) -> String{
        pointer = pointer + temp
        //print ("pointer:\(pointer)  count:\(wordList.count)")
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
            readFile.markAsLearned()
            var i = 1
            for learnword in wordList{
                wordListToString = wordListToString + "NO.\(i): Chinese: \(learnword.components(separatedBy: "+")[0])  English: \(learnword.components(separatedBy: "+")[1])\n"
                i += 1
                
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let now = formatter.string(from: NSDate() as Date)
            wordListToString = wordListToString + "learned at: \(now)"
            let notetitle = "Flipper-\(category)-\(level)"
            let event = addEvent(title: notetitle, note : wordListToString)
            //print(wordListToString)
            event.add()
            return true
        }
        return false
    }
    
    init(Category : String,wordlist : [String], level : String){
        self.wordList = wordlist
        self.category = Category
        self.level = level
    }
    
}

