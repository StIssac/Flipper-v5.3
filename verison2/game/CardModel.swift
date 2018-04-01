//
//  CardModel.swift
//  test1
//
//  Created by 尹笑康 on 2018/3/8.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import Foundation

struct  CardModel{
    
    var cards = [Card]()
    private(set) static var RemainingTry = 0
    private(set) static var Score = 0
    
    
    
    
    private  var indexOfOneOnlyOneFaceUp: Int? {
        get{
            let faceUPCardIndices = cards.indices.filter { cards[$0].isFaceup }
            return faceUPCardIndices.count == 1 ? faceUPCardIndices.first : nil
        }
        
        set{
            for index in cards.indices{
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        if !cards[index].isMatch{
            if let matchIndex = indexOfOneOnlyOneFaceUp, matchIndex != index{
                if cards[matchIndex].ID == cards[index].ID{
                    cards[matchIndex].isMatch=true
                    cards[index].isMatch=true
                    CardModel.Score += 1
                    
                }
                cards[index].isFaceup=true
                CardModel.RemainingTry -= 1
            }else{
                
                indexOfOneOnlyOneFaceUp=index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        CardModel.RemainingTry = numberOfPairsOfCards*2
        CardModel.Score = 0
        
        var tempCards = [Card]()
        CardModel.RemainingTry = numberOfPairsOfCards*2
        CardModel.Score = 0
        
        
        for _ in 1...numberOfPairsOfCards{
            
            let card = Card()
            let card2 = Card(Id: card.ID,No: card.NO+1)
            tempCards.append(card)
            tempCards.append(card2)
        }
        
        for _ in 0...tempCards.count-1{
            let randomIndex = Int(arc4random_uniform(UInt32(tempCards.count-1)))
            //print("\(index)++++\(randomIndex)")
            cards.append(tempCards[randomIndex])
            tempCards.remove(at: randomIndex)
        }
    }
    
    
}


