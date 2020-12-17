//
//  main.swift
//  13
//
//  Created by Mark Lively on 12/13/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func part1(_ s:String){
    let c = s.components(separatedBy: .newlines)
    let timestamp = Int(c[0])!
    let buses = c[1].components(separatedBy: ",").compactMap{Int($0)}
    let buses2 = buses.sorted(by: {($0-timestamp%$0) < ($1-timestamp%$1)})
    print(buses2.first!, buses2.first!*(buses2.first!-timestamp%buses2.first!))
}

part1(test1)
part1(data)


func count(_ n:UInt64, _ b:Int)-> Int{
    return (b - Int(n % UInt64(b)))%b
}


func part2(_ s:String){
    let c = s.components(separatedBy: .newlines)
    let buses = c[1].components(separatedBy: ",").map{Int($0)}
    var testArray:Array<(Int,Int)> = []
    for i in 0..<buses.count {
        if let bus = buses[i] {
            testArray.append((bus,i))
        }
    }
    var t:UInt64 = 0
    var increment = 1
    for (b,n) in testArray {
        while count(t,b) != n%b {
            t += UInt64(increment)
        }
        increment *= b
    }
    print(t)
}

part2(test1)
part2(test2)
part2(data)

