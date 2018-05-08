//
//  effect.swift
//  Flipper
//
//  Created by clare on 18/04/2018.
//  Copyright © 2018 CSE 208-Group India. All rights reserved.
//

import Foundation

public func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem){
}
extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}

