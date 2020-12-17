//
//  main.swift
//  14
//
//  Created by Mark Lively on 12/14/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func applyMask1(input:Int64, current:Int64, mask:String) -> Int64{
    var tInput = input
    var tCurrent = current
    var out:Int64 = 0
    var mul:Int64 = 1
    for c in mask.reversed() {
        switch c{
        case "X":
            out += mul * (tInput % 2)
        case "1":
            out += mul * 1
        case "0":
            out += 0
        default:
            fatalError()
        }
        tCurrent = tCurrent >> 1
        tInput = tInput >> 1
        mul = mul << 1
    }
    return out
    
}

func stage1(_ s:String){
    var locList:Array<Int> = []
    var memory:Dictionary<Int,Int64> =  [:]
    var mask = ""
    for l in s.components(separatedBy: .newlines){
        if l.hasPrefix("mask") {
            mask = String(l.dropFirst(7))
        } else {
            let loc = Int(String(l.components(separatedBy: "[")[1].components(separatedBy: "]")[0]))!
            locList.append(loc)
            let num = Int64(l.components(separatedBy:" = ")[1])!
            let temp = memory[loc] ?? 0
            memory[loc] = applyMask1(input:num, current:temp, mask:mask)
        }
    }
    print(memory.values.reduce(Int64(0), +))
    print(locList.count,memory.keys.count)
}

stage1(test1)
stage1(data)

func applyMask2(input:Int64, mask:String) -> Array<Int64>{
    var tInput = input
    var out:Array<Int64> = [0]
    var mul:Int64 = 1
    for c in mask.reversed() {
        switch c{
        case "0":
            out = out.map{$0 + mul * (tInput % 2)}
        case "1":
            out = out.map{$0 + mul}
        case "X":
            out += out.map{$0 + mul}
        default:
            fatalError()
        }
        tInput = tInput >> 1
        mul = mul << 1
    }
    return out
    
}


func stage2(_ s:String){
    var memory:Dictionary<Int64,Int64> = [:]
    var mask = "000000000000000000000000000000000000"
    for l in s.components(separatedBy: .newlines){
        if l.hasPrefix("mask") {
            mask = String(l.dropFirst(7))
        } else {
            let loc = Int64(String(l.components(separatedBy: "[")[1].components(separatedBy: "]")[0]))!
            let num = Int64(l.components(separatedBy:" = ")[1])!
            let locList = applyMask2(input: loc, mask: mask)
            locList.forEach{memory[$0] = num}
        }
    }
    print(memory.values.reduce(Int64(0), +))
}

stage2(test2)
stage2(data)

