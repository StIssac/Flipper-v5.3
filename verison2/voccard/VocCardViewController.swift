//
//  ViewController.swift
//  test4
//
//  Created by 尹笑康 on 2018/3/24.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import UIKit

class VocCardViewController: UIViewController {
    
    public var level = "level"
    private var WordList = ["word"]{
        didSet{
            Swift.print(WordList)
        }
    }
    public var category = "category"{
        didSet{
            if category == "Review"{
                level = "All"
                WordList = readFile.review()
            }else{
                WordList = returnWordList(level: level, category: category)
            }
        }
    }
    
    public func returnWordList (level: String,category : String) -> [String]{
        let temp = readFile.returnCategory(level: level, catgory: category)
        return temp
    }
    
    private var hasPost = false
    private var wordDisplay = "end"{
        didSet{
            if !hasPost{
                if wordDisplay == "end"{
                    if hasPost{
                        firstLabel.text = ""
                        SecondLabel.text = "Posted!"
                        checkButton.alpha = 1.0
                        quizButton.alpha = 1.0
                        SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                        thirdLabel.text = ""
                    }else{
                        firstLabel.text = ""
                        SecondLabel.text = "Post it?"
                        quizButton.alpha = 1.0
                        SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                        thirdLabel.text = ""
                    }
                }else if wordDisplay == "Start!"{
                    firstLabel.text = ""
                    SecondLabel.text = "Start!"
                    SecondLabel.textColor = #colorLiteral(red: 0.007843137255, green: 0.1333333333, blue: 0.368627451, alpha: 1)
                    thirdLabel.text = ""
                }else if wordDisplay != ""{
                    firstLabel.text = wordDisplay.components(separatedBy: "+")[0]
                    SecondLabel.text = "---------"
                    SecondLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
                    thirdLabel.text = wordDisplay.components(separatedBy: "+")[1]
                }
                
                
            }
        }
    }
    lazy var game = vocCardModel(Category: category, wordlist: WordList, level : level)
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBAction func nextOne(_ sender: UIButton) {
        if WordList.count > 5{
            wordDisplay = game.ReturnWord(at: 1)
            if !hasPost{
                if game.postOnCalendar(learncategory : category){
                    hasPost = true
                    firstLabel.text = ""
                    SecondLabel.text = "Posted!"
                    thirdLabel.text = ""
                    checkButton.alpha = 1.0
                    quizButton.alpha = 1.0
                }
            }
        }else if category != "Review"{
            firstLabel.text = "Learn out!"
            SecondLabel.text = ""
            thirdLabel.text = "Well done!"
        }else{
            firstLabel.text = ""
            SecondLabel.text = "Learn First!"
            thirdLabel.text = ""
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton)?.currentTitle == "Quiz"{
            if let gvc = segue.destination as? GameViewController{
               gvc.inputWordList = WordList
            }
        }
    }
    
    @IBAction func checkCalendar(_ sender: UIButton) {
            let urlString = "calshow:"
            if let url = URL(string: urlString) {
                //  Deal with different version of iOS
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
    }
   
     
    @IBAction func lastOne(_ sender: UIButton) {
        if WordList.count > 5{
            wordDisplay = game.ReturnWord(at: -1)
        }
    }
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
