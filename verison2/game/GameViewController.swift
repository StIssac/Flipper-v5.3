//
//  ViewController.swift
//  test1
//
//  Created by 尹笑康 on 2018/3/7.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
    {
        if repeatCount <= 0  {
            return
        }
        self.winLabel.alpha = 0.0
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler(handler: {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 && self.TimerLabel.text == ("Remaining time:\(count+1)s"){
                timer.cancel()
                self.winLabel.alpha = 1.0
                self.winLabel.text = "YOU LOSE!"
                self.TimerLabel.text=("Remaining time:0s")
            }
        })
        timer.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchTimer(timeInterval: 1, repeatCount: 60) { (timer, count) in
            if self.winLabel.text == "" && count+1 == Int(self.TimerLabel.text!.components(separatedBy: ":")[1].components(separatedBy: "s")[0]){
                self.TimerLabel.text=("Remaining time:\(count)s")
                
            }
        }
        
    }
    
    lazy var game = CardModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        get{
            return (cardButtons.count)/2
        }
    }
    
    
    @IBOutlet private weak var ReTry: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var ScoreLabel: UILabel!
    
    @IBOutlet  private weak var TimerLabel: UILabel!
    
    @IBOutlet private weak var winLabel: UILabel!
    
    
    @IBAction func restartButton(_ sender: UIButton) {
        Restart()
    }
    
    private func Restart(){
        TimerLabel.text=("Remaining time:60s")
        viewDidLoad()
        winLabel.text = ""
        self.winLabel.alpha = 0.0
        for button in cardButtons{
            button.alpha = 1.0
            button.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
            button.setTitle("", for: UIControlState.normal)
        }
        game = CardModel(numberOfPairsOfCards: numberOfPairsOfCards)
        ReTry.text = "Remaining Try:\(CardModel.RemainingTry)"
        ScoreLabel.text = "Score:\(CardModel.Score)"
    }
    
    public var inputWordList = ["😀+😀","😃+😃","😄+😄","🐶+🐶","🐭+🐭","🐷+🐷","🍎+🍎","🍐+🍐","🏈+🏈","🏀+🏀","🛩+🛩","🛸+🛸","⌚️+⌚️","💽+💽","⌨️+⌨️"]
    
    private(set) var words = [Int:String]()
    
    private func setTime(time: Int){
        TimerLabel.text =  ("Remaining time:\(time)s")
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceup{
                button.setTitle(word(for: card), for: UIControlState.normal)
                button.backgroundColor =  #colorLiteral(red: 0.862745098, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatch ?  #colorLiteral(red: 1, green: 0.5518556993, blue: 0, alpha: 0) : #colorLiteral(red: 0.9294117647, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
                
            }
            if (CardModel.Score == 6){
                button.alpha = 0.0             }
            
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if winLabel.text == ""{
            let CardNumber = cardButtons.index(of: sender)!
            game.chooseCard(at: CardNumber)
            updateViewFromModel()
            ReTry.text = "Remaining Try:\(CardModel.RemainingTry)"
            ScoreLabel.text = "Score:\(CardModel.Score)"
            if CardModel.RemainingTry == 0{
                winLabel.text = "YOU LOSE :("
                winLabel.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                self.winLabel.alpha = 1.0
            }
            if CardModel.Score == 6{
                winLabel.text = "YOU WIN :)"
                winLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                self.winLabel.alpha = 1.0
            }
        }
        
    }
    
    
    private func word(for card: Card) -> String {
        
        if words[card.ID] == nil, inputWordList.count>0{
            
            let randomIndex = Int(arc4random_uniform(UInt32(inputWordList.count)))
            words[card.ID] = inputWordList[randomIndex]
            inputWordList.remove(at: randomIndex)
            
        }
        
        return (words[card.ID]?.components(separatedBy: "+")[card.NO % 2])!
        
    }
    
    
}


