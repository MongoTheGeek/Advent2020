//
//  main.swift
//  09
//
//  Created by Mark Lively on 12/9/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func validate(array:Array<Int>, preamble:Int) -> Array<Int>{
    var current:Array<Int> = []
    var out:Array<Int> = []
    for i in 0..<preamble {
        current.append(array[i])
    }
    for i in preamble..<array.count {
        let test = array[i]
        var pop = false
        for j in 0..<current.count-1{
            for k in j..<current.count{
                if current[j] + current[k] == test {
                    pop = true
                    break
                }
            }
            if pop {break}
        }
        if !pop {out.append(test) }
        current.removeFirst()
        current.append(test)
    }
    return out
}

//part 2

func findRange(array:Array<Int>, target:Int) -> Int {
    var i = 0
    var temp:Array<Int> = []
    while temp.reduce(0,+) != target {
        if temp.reduce(0,+) < target {
            temp.append(array[i])
            i+=1
        } else {
            temp.removeFirst()
        }
    }
    print(temp)
    return temp.min()! + temp.max()!
}

var preamble = 5
var bad:Array<Int> = []
var array = test.components(separatedBy: .newlines).map{Int($0)!}
var result = validate(array:array, preamble:preamble).first!
print(findRange(array: array, target: result))



preamble = 25
bad = []
array = data.components(separatedBy: .newlines).map{Int($0)!}
result = validate(array:array, preamble:preamble).first!
print(result)

print(findRange(array: array, target: result))
