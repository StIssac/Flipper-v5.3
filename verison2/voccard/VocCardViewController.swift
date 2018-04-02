//
//  ViewController.swift
//  test4
//
//  Created by 尹笑康 on 2018/3/24.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import UIKit

class VocCardViewController: UIViewController {
    
    
    public var numberWordList = ["一+one","二+two","三+three","四+four","五+five","六+six","七+seven","八+eight","九+nine"]
    private var foodWordList = ["鸡肉+chicken","鸡蛋+egg","牛肉+beef","猪肉+pork"]
    private var animalWordList = ["dog+狗","cat+猫","fish+鱼","pig+猪","ox+牛","rat+鼠"]
    private var plantWordList = ["树+tree","花+flower","草+grass"]
    private var earthWordList = ["山+hill","河+river","天+sky"]
    
    public func returnWordList (category : String) -> [String]{
        if(category == "Number"){
            return numberWordList
        } else if (category == "Food"){
            return foodWordList
        } else if(category == "Animal"){
            return animalWordList
        } else if(category == "Plant"){
            return plantWordList
        } else if(category == "Earth"){
            return earthWordList
        }
        return [""]
    }
    
    
    
    private var WordList = ["word"]
     var category = "category"{
        didSet{
           WordList = returnWordList(category: category)
        }
    }
    
    private var hasPost = false
    private var wordDisplay = "end"{
        didSet{
            if !hasPost{
                if wordDisplay == "end"{
                    if hasPost{
                        firstLabl.text = ""
                        SecondLabel.text = "Posted!"
                        SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                        thirdLabel.text = ""
                    }else{
                        firstLabl.text = ""
                        SecondLabel.text = "Post it?"
                        SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                        thirdLabel.text = ""
                    }
                }else if wordDisplay == "Start!"{
                    firstLabl.text = ""
                    SecondLabel.text = "Start!"
                    SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                    thirdLabel.text = ""
                }else if wordDisplay != ""{
                    firstLabl.text = wordDisplay.components(separatedBy: "+")[0]
                    SecondLabel.text = "---------"
                    SecondLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    thirdLabel.text = wordDisplay.components(separatedBy: "+")[1]
                }
                
                
            }
        }
    }
    lazy var game = test4Model(Category: category, wordlist: WordList)
    
    @IBOutlet weak var firstLabl: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBAction func nextOne(_ sender: UIButton) {
        wordDisplay = game.ReturnWord(at: 1)
        if !hasPost{
            if game.postOnCalendar(learncategory : category){
                hasPost = true
                firstLabl.text = ""
                SecondLabel.text = "Posted!"
                thirdLabel.text = ""
            }
        }
    }
    
    
    @IBAction func lastOne(_ sender: UIButton) {
        wordDisplay = game.ReturnWord(at: -1)

    }
     

}


// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
