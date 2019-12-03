//
//  ThreadSafeExample.swift
//  Multithreading827
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


//How to create thread safe property
class Object {
    
    private var _x = 0 //can't access from outside
    let serial = DispatchQueue(label: "con") //serial by default
    
    
    var x: Int {
        get {
            //sync on read
            return serial.sync {
                return _x
            }
        }
        set(new) {
            //async with a barrier set
            serial.async(flags: .barrier) {
                self._x = new
            }
        }
    }
    
    
    
    
    
}
