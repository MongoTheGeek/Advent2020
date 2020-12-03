//
//  main.swift
//  02
//
//  Created by Mark Lively on 12/1/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

//Part 1
func countValid(_ input:Array<String>) ->Int {
    var c = 0
    for l in input {
        let split = l.components(separatedBy: CharacterSet([" ", "-", ":"]))
        let min = Int(split[0])!
        let max = Int(split[1])!
        let char = split[2]
        let pass = split[4].components(separatedBy: char)
        if pass.count > min && pass.count < max + 2 {
            c+=1
//            print(l)
        }
    }
    return c
}

print(countValid(test.components(separatedBy: .newlines)))

print(countValid(data.components(separatedBy: .newlines)))

//Part2

func newValid(_ input:Array<String>) ->Int {
    var c = 0
    for l in input {
        let split = l.components(separatedBy: CharacterSet([" ", "-", ":"]))
        let left = Int(split[0])!-1
        let right = Int(split[1])!-1
        let char = split[2].cString(using: .utf8)![0]
        let pass = split[4].cString(using: .utf8)!
        if (pass[left] == char && pass[right] != char) || (pass[left] != char && pass[right] == char)  {
            c+=1
//            print(l)
        }
    }
    return c
}

print(newValid(test.components(separatedBy: .newlines)))

print(newValid(data.components(separatedBy: .newlines)))
