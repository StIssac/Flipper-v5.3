//
//  choodeCategoryViewController.swift
//  verison2
//
//  Created by 尹笑康 on 2018/3/31.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import UIKit

class chooseCategoryViewController: UIViewController {
    private var level = "Primary"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let category = (sender as? UIButton)?.currentTitle{
            if let vcvc = segue.destination as? VocCardViewController{
                vcvc.level = level
                vcvc.category = category 
            }
        }
    }
 
    @IBOutlet weak var backView: UIView!
    // Choose level of vocabulary
    @IBAction func Level_Daliy(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            level = "Primary"
            backView.backgroundColor=#colorLiteral(red: 0.8078431373, green: 0.8784313725, blue: 0.9019607843, alpha: 1)
        } else if((sender.selectedSegmentIndex == 1)){
            level = "Intermediate"
            backView.backgroundColor=#colorLiteral(red: 0.7058823529, green: 0.8078431373, blue: 0.8431372549, alpha: 1)
        } else if((sender.selectedSegmentIndex == 2)){
            level = "Advanced"
            backView.backgroundColor=#colorLiteral(red: 0.613526635, green: 0.7632765359, blue: 0.8235068615, alpha: 1)
        }
            
    }
    
}
