//
//  main.swift
//  15
//
//  Created by Mark Lively on 12/15/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func _2020(_ arr:Array<Int>, end:Int = 2020) -> Int{
    var i = 0
    var last = 0
    var dict:Dictionary<Int,Int> = [:]
    for n in arr {
        i += 1
        dict[n] = i
        last = n
    }
    repeat {
        if let prev = dict[last] {
            dict[last] = i
            last = i - prev
        } else {
            dict[last] = i
            last = 0
        }
        i += 1
    } while i < end
    return last
}

print(_2020(test1), result1)
print(_2020(test2), result2)
print(_2020(test3), result3)
print(_2020(test4), result4)
print(_2020(test5), result5)
print(_2020(test6), result6)
print(_2020(test7), result7)
print(_2020(data))

print(_2020(data, end:30000000))
