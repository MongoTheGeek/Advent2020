//
//  main.swift
//  12
//
//  Created by Mark Lively on 12/11/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation


var x = 0
var y = 0
var d = 0
var wx = 10
var wy = 1

func parseD(_ s:String){
    let c = s.prefix(1)
    let n = Int(s.dropFirst())!
    switch c {
    case "R":
        d -= n
    case "L":
        d += n
    case "F":
        let d2 = (d % 360 + 360) % 360
        switch d2 {
        case 0:
            x += n
        case 90:
            y += n
        case 180:
            x -= n
        case 270:
            y -= n
        default:
            fatalError()
        }
    case "E":
        x += n
    case "N":
        y += n
    case "W":
        x -= n
    case "S":
        y -= n
    default:
        fatalError()
    }
//    print(x,y)
}

func parseD2(_ s:String){
    let c = s.prefix(1)
    let n = Int(s.dropFirst())!
    switch c {
    case "R":
        let d2 = (n % 360 + 360) % 360
        switch d2 {
        case 0:
            break
        case 90:
            let t = wx
            wx = wy
            wy = -t
        case 180:
            wx = -wx
            wy = -wy
        case 270:
            let t = wx
            wx = -wy
            wy = t
        default:
            fatalError()
        }
    case "L":
        let d2 = (n % 360 + 360) % 360
        switch d2 {
        case 0:
            break
        case 90:
            let t = wx
            wx = -wy
            wy = t
        case 180:
            wx = -wx
            wy = -wy
        case 270:
            let t = wx
            wx = wy
            wy = -t
        default:
            fatalError()
        }
    case "F":
        x += n * wx
        y += n * wy
    case "E":
        wx += n
    case "N":
        wy += n
    case "W":
        wx -= n
    case "S":
        wy -= n
    default:
        fatalError()
    }
//    print(x,y)
}




for l in test1.components(separatedBy: .newlines){
    parseD(l)
}
print(abs(x)+abs(y))

x = 0
y = 0
d = 0

for l in data.components(separatedBy: .newlines){
    parseD(l)
}
print(abs(x)+abs(y))



print("Part 2")

x = 0
y = 0
d = 0
wx = 10
wy = 1
for l in test1.components(separatedBy: .newlines){
    parseD2(l)
}
print(abs(x)+abs(y))

x = 0
y = 0
d = 0
wx = 10
wy = 1

for l in data.components(separatedBy: .newlines){
    parseD2(l)
}
print(abs(x)+abs(y))

