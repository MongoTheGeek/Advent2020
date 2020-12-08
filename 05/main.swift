//
//  main.swift
//  05
//
//  Created by Mark Lively on 12/4/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func seatNumber(_ s:String) -> Int {
    var out:Int = 0
    for c in s {
        switch c {
        case "F", "L":
            out *= 2
        case "B", "R":
            out = out * 2 + 1
        default:
            fatalError()
        }
    }
    
    return out
}

let dataArray = data.components(separatedBy:.newlines)
print(dataArray.map{seatNumber($0)}.max() ?? "Fail")

let seats = dataArray.map{seatNumber($0)}.sorted()

var last:Int?

for s in seats {
    if let last = last {
        if s != last + 1 {
            print(s-1)
            break
        }

    }
    last = s
}
