//
//  main.swift
//  01
//
//  Created by Mark Lively on 12/1/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

//Part 1

func find2020(_ input:Array<Int>) -> Int {
    for i in input{
        for j in input {
            if i+j == 2020 {
                return i*j
            }
        }
    }
    return 0
}

var nums = test1.components(separatedBy: .newlines).compactMap{Int($0)}
print(find2020(nums))

nums = input.components(separatedBy: .newlines).compactMap{Int($0)}
print(find2020(nums))


//Part 2
func find2020_3(_ input:Array<Int>) -> Int {
    for i in 0..<input.count - 2 {
        if input[i] < 2020 {
            for j in i+1 ..< input.count - 1 {
                if input[i]+input[j] < 2020 {
                    for k in j+1 ..< input.count {
                        if input[i]+input[j]+input[k] == 2020 {return input[i]*input[j]*input[k]}
                    }
                }
            }
        }
    }
    return 0
}

print("part2")
nums = test1.components(separatedBy: .newlines).compactMap{Int($0)}
print(find2020_3(nums))

nums = input.components(separatedBy: .newlines).compactMap{Int($0)}
print(find2020_3(nums))
