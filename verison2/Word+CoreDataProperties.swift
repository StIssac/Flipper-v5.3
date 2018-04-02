//
//  Word+CoreDataProperties.swift
//  verison2
//
//  Created by 尹笑康 on 2018/4/2.
//  Copyright © 2018年 尹笑康. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var category: String?
    @NSManaged public var learned: Bool
    @NSManaged public var word: String?
    @NSManaged public var learneddate: NSDate?
    
}
