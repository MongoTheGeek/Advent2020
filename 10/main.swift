//
//  main.swift
//  10
//
//  Created by Mark Lively on 12/10/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

print("Hello, World!")

func buildJolts(_ s:String) -> Array<Int> {
    var l = s.components(separatedBy:.newlines).map{Int($0)!}.sorted()
    l.insert(0, at: 0)
    l.append(l.last!+3)
    return l
}

func oneByThree(_ ints:Array<Int>) -> Int{
    var temp:Array<Int> = Array(repeating: 0, count: 4)
    for i in 1..<ints.count {
        let n = ints[i]-ints[i-1]
        temp[n] += 1
    }
    print(temp)
    return temp[1] * temp[3]
}

func subLists(_ ints:Array<Int>) -> Array<(Int,Int)> {
    var out:Array<(Int,Int)> = []
    var start = -1
    for i in 1..<ints.count {
        if ints[i]-ints[i-1] == 3 {
            if start != -1 {
                out.append((start,ints[i-1]))
                start = -1
            }
        } else {
            if start == -1 {
                start = ints[i-1]
            }
        }
    }
    return out
}

func valid(j:Int, i:Int)->Bool{
    var diff = 0
    var j = j
    for _ in 0...i {
        if j%2 == 1 {
            diff = 0
        } else {
            diff += 1
        }
        j = j >> 1
        if diff > 3 {
            return false
        }
    }
    return true
}

func buildDiffList(_ max:Int)->Array<Int> {
    var out = Array(repeating: 1, count: max+1)
    var n = 2
    for i in 3...max{
        var acc = 0
        print("----\(i)----")
        for j in 0..<n {
            if valid(j:j, i:i-2) {
                acc += 1
                print(j)
            }
        }
        print("----\(i)----\(acc)-----")
        n *= 2
        out[i]=acc
    }
    return out
}
print(oneByThree(buildJolts(test1)))
print(oneByThree(buildJolts(test2)))
print(oneByThree(buildJolts(data)))

let difflist = buildDiffList(9)
print(difflist)

var sl = subLists(buildJolts(test1))
print(sl)
var dl = sl.map{1+$0.1-$0.0}
print(dl)
print(dl.map{difflist[$0]}.reduce(1,*))

sl = subLists(buildJolts(test2))
dl = sl.map{1+$0.1-$0.0}
print(dl)
print(dl.map{difflist[$0]}.reduce(1,*))

sl = subLists(buildJolts(data))
dl = sl.map{1+$0.1-$0.0}
print(dl)
print(dl.map{difflist[$0]}.reduce(UInt64(1)){$0*UInt64($1)})


