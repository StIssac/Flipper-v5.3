//
//  Card.swift
//  test1
//
//  Created by 尹笑康 on 2018/3/8.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import Foundation

struct Card{
    
    private static var Number = 1
    var isFaceup = false
    var isMatch = false
    var ID: Int
    var NO: Int
    
    init(){
        self.ID = Card.Number
        self.NO = Card.Number*2
        Card.Number += 1
    }
    
    init(Id : Int, No : Int){
        self.ID = Id
        self.NO = No
    }
}

