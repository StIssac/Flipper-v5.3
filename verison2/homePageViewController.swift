//
//  homePageViewController.swift
//  Flipper
//
//  Created by 尹笑康 on 2018/5/3.
//  Copyright © 2018年 CSE 208-Group India. All rights reserved.
//

import UIKit

class homePageViewController: UIViewController {
    private(set) static var userName = "admin"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton)?.currentTitle == "Quiz"{
            if let gvc = segue.destination as? GameViewController{
                let temp = readFile.review()
                if temp.count > 5 {
                    gvc.inputWordList = readFile.review()
                }
            }
        }
        if (sender as? UIButton)?.currentTitle == "Review"{
            if let vcvc = segue.destination as? VocCardViewController{
                vcvc.category = "Review"
            }
        }
        
    }
}
