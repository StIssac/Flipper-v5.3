//
//  readFile.swift
//  Flipper
//
//  Created by 尹笑康 on 2018/5/3.
//  Copyright © 2018年 CSE 208-Group India. All rights reserved.
//

import Foundation

struct viaDatabase {
    public static var userName = "admin"{
        didSet{
            learnedWordFileName =  userName + "learnword"
            reviewWordFileName =  userName + "reviewWord"
        }
    }
    private static var learnedWordFileName =  "learnword"{
        didSet{
            DocunmentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            learnedWordFileURL = DocunmentDirURL.appendingPathComponent(learnedWordFileName).appendingPathExtension("txt")
        }
    }
    private  static var DocunmentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    private static var learnedWordFileURL = DocunmentDirURL.appendingPathComponent("learnword").appendingPathExtension("txt")
    private static var reviewWordFileName =  "reviewWord"{
        didSet{
            try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            reviewWordFileURL = reDocunmentDirURL.appendingPathComponent(reviewWordFileName).appendingPathExtension("txt")
        }
    }
    private  static var reDocunmentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    private static var reviewWordFileURL = reDocunmentDirURL.appendingPathComponent("reviewWord").appendingPathExtension("txt")
    private static let originFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "word", ofType: "txt")!)
    private static var contentOfFile = ""
    private static var allWord = [""]
    private static var word = [""]
    private static var  indexOfLearnWord = [""]
    
    public static func update(){
        do{
            contentOfFile = try String(contentsOf: originFileURL)
            allWord = contentOfFile.components(separatedBy: "\n")
        }catch let error as NSError{
            Swift.print(error)
        }
        do{
            contentOfFile = try String(contentsOf: learnedWordFileURL)
            word = contentOfFile.components(separatedBy: "\n")
        }catch let error as NSError{
            Swift.print(error)
        }
        
        var containedWord = [""]
        for line in word{
            containedWord.append(line.components(separatedBy: ",")[0])
        }
        for line in allWord{
            if !word.contains(line.components(separatedBy: ",")[0]){
                word.append(line)
            }
        }
        
        do{
            let writeToFile = word.joined(separator: "\n")
            try writeToFile.write(to: learnedWordFileURL, atomically: true, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            Swift.print(error)
        }
        
    }
    
    public static func returnCategory(level : String ,catgory : String) -> [String]{
        do{
            contentOfFile = try String(contentsOf: learnedWordFileURL)
        }catch let error as NSError{
            Swift.print(error)
        }
        do{
            if contentOfFile.count < 10{
                contentOfFile = try String(contentsOf: originFileURL)
            }
            allWord = contentOfFile.components(separatedBy: "\n")
        }catch let error as NSError{
            Swift.print(error)
        }
        var tempWord = [""]
        indexOfLearnWord = []
        for line in allWord{
            var lineItem = line.components(separatedBy: ",")
            if lineItem.count == 6{
                if tempWord.count < 6 && lineItem[2] == "0" && lineItem[3] == level && lineItem[4] == catgory  {
                    if(tempWord == [""] ){
                        tempWord = [lineItem[0]]
                        indexOfLearnWord = [lineItem[5]]
                    }else{
                        tempWord.append(lineItem[0])
                        indexOfLearnWord.append(lineItem[5])
                    }
                }
                
            }
        }
        return tempWord
    }
    
    public static func  markAsLearned(){
        var i = 0
        while i < allWord.count{
            var lineItem = allWord[i].components(separatedBy: ",")
            if lineItem.count == 6{
                if indexOfLearnWord.contains(lineItem[5]){
                    lineItem[2] = "1"
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let now = formatter.string(from: NSDate() as Date)
                    lineItem[1] = now
                    allWord[i] = lineItem.joined(separator: ",")
                }
            }
            i += 1
        }
        do{
            let writeToFile = allWord.joined(separator: "\n")
            try writeToFile.write(to: learnedWordFileURL, atomically: true, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            Swift.print(error)
        }
    }
    
    public static func review( numberOfElement : Int) -> [String]{
        var wordCount = 0
        do{
            contentOfFile = try String(contentsOf: learnedWordFileURL)
        }catch let error as NSError{
            Swift.print(error)
        }
        do{
            if contentOfFile.count < 10{
                contentOfFile = try String(contentsOf: originFileURL)
            }
            allWord = contentOfFile.components(separatedBy: "\n")
        }catch let error as NSError{
            Swift.print(error)
        }
        var allLearnedWord = [""]
        for line in allWord{
            if  allLearnedWord.count < 6{
                
            }
            var lineItem = line.components(separatedBy: ",")
            if lineItem.count == 6{
                if lineItem[2] == "1"{
                    wordCount += 1
                    if allLearnedWord == [""]{
                        allLearnedWord = [lineItem[0]]
                    }else{
                        allLearnedWord.append(lineItem[0])
                    }
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let learnTime = lineItem[1]
                    let time = formatter.date(from: learnTime)!
                    let now = NSDate() as Date
                    if(time.addingTimeInterval(30*3600*24) < now){
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                    }
                    if(time.addingTimeInterval(7*3600*24) < now){
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                    }
                    if(time.addingTimeInterval(3600*24) > now){
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                    }
                    if(time.addingTimeInterval(2*3600*24) > now){
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                    }
                }
            }
        }
        
        var contentOfReviewFile = ""
        var readed = true
        do{
            contentOfReviewFile = try String(contentsOf: reviewWordFileURL)
        }catch let error as NSError{
            Swift.print(error)
            readed = false
        }

        if readed {
            let wordList = contentOfReviewFile.components(separatedBy: "\n")
            for line in wordList {
                let lineItem = line.components(separatedBy: "+++")
                if lineItem.count == 2{
                    if (lineItem[1] == "false"){
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                        allLearnedWord.append(lineItem[0])
                    }else{
                        var i = 3
                        while (i > 0){
                            i -= 1
                            let index = allLearnedWord.index(of: lineItem[0])
                            if index != nil {
                                allLearnedWord.remove(at: index!)
                            }
                        }
                    }
                }
            }
        }
        
        var retrunWord = [""]
        if wordCount == 0 {
            return [""]
        }
        if wordCount <= 6 {
            while(retrunWord.count < 6){
                let randomIndex = Int(arc4random_uniform(UInt32(allLearnedWord.count-1)))
                if !retrunWord.contains(allLearnedWord[randomIndex]){
                    if retrunWord == [""]{
                        retrunWord = [allLearnedWord[randomIndex]]
                    }else{
                        retrunWord.append(allLearnedWord[randomIndex])
                    }
                }
            }
        }else{
            while(retrunWord.count < numberOfElement){
                let randomIndex = Int(arc4random_uniform(UInt32(allLearnedWord.count-1)))
                if !retrunWord.contains(allLearnedWord[randomIndex]){
                    if retrunWord == [""]{
                        retrunWord = [allLearnedWord[randomIndex]]
                    }else{
                        retrunWord.append(allLearnedWord[randomIndex])
                    }
                }
            }
        }
        return retrunWord
    }
    
    
    public static func reviewRecord (win : String , list : [String]){
        var learnRecord = [""]
        for word in list{
            let line = word + "+++" + win
            learnRecord.append(line)
        }
        var contentOfReviewFile = ""
        do{
            contentOfReviewFile = try String(contentsOf: reviewWordFileURL)
        }catch let error as NSError{
            Swift.print(error)
        }
        do{
            let writeToFile = contentOfReviewFile + learnRecord.joined(separator: "\n")
            try writeToFile.write(to: reviewWordFileURL, atomically: true, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            Swift.print(error)
        }
    }
    
    
}
