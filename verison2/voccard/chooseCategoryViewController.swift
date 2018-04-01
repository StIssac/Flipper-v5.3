//
//  choodeCategoryViewController.swift
//  verison2
//
//  Created by 尹笑康 on 2018/3/31.
//  Copyright © 2018年 尹笑康. All rights reserved.
//

import UIKit

class chooseCategoryViewController: UIViewController {

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let category = (sender as? UIButton)?.currentTitle{
            if let vcvc = segue.destination as? VocCardViewController{
                vcvc.category = category 
            }
        }
    }
 
}
