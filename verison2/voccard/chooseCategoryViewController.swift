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
 
    // Choose level of vocabulary
    @IBAction func Level_Daliy(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            level = "Primary"
        } else if((sender.selectedSegmentIndex == 1)){
            level = "Intermediate"
        } else if((sender.selectedSegmentIndex == 2)){
            level = "Advanced"
        }
            
    }
    
}
