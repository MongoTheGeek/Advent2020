//
//  main.swift
//  08
//
//  Created by Mark Lively on 12/8/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

var acc = 0
var run:Array<Bool> = []
var n = 0
var inst:Array<String> = []

func setup(_ s:String){
    inst = s.components(separatedBy: .newlines)
    run = Array(repeating: false, count: inst.count)
    acc = 0
    n = 0
}

func stage1(_ s:String) {
    let w = s.components(separatedBy:" ")
    let c = w[0]
    switch c {
    case "acc":
        if w[1].hasPrefix("+"){
            acc += Int(w[1].dropFirst())!
        } else {
            acc += Int(w[1])!
        }
        n += 1
    case "jmp":
        if w[1].hasPrefix("+"){
            n += Int(w[1].dropFirst())!
        } else {
            n += Int(w[1])!
        }
    default:
        n += 1
        break
    }
}

setup(test1)
while true {
    if run[n] {break}
    run[n] = true
    stage1(inst[n])
}
print(n,acc)

setup(data)
var success = false
for i in 0..<inst.count {
    if !inst[i].hasPrefix("acc"){
        while true {
            if n >= inst.count {
                success = true
                break
            }
            if run[n] {break}
            run[n] = true
            if n == i {
                let new:String
                if inst[n].hasPrefix("nop"){
                    new = "jmp"+inst[n].dropFirst(3)
                } else {
                    new = "nop"+inst[n].dropFirst(3)
                }
                stage1(new)
            } else {
                stage1(inst[n])
            }
        }
        print(i,n,acc)
        if success {break}
        setup(data)
    }
}
