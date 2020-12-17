//
//  main.swift
//  11
//
//  Created by Mark Lively on 12/11/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

enum Cell:CustomStringConvertible {
    var description: String {
    get {
            switch self {
            case .floor:
                return "."
            case .full:
                return "#"
            default:
                return "L"
            }
        }
    }
    
    case floor, empty, full
}

func buildData(_ s:String) -> Array<Array<Cell>> {
    let w = s.components(separatedBy: .newlines).first!.count + 2
    var out:Array<Array<Cell>> = [Array(repeating: .floor, count: w)]
    for r in s.components(separatedBy: .newlines) {
        var temp:Array<Cell> = [.floor]
        for c in r {
            switch c {
            case ".":
                temp.append(.floor)
            case "#":
                temp.append(.full)
            case "L":
                temp.append(.empty)
            default:
                fatalError()
            }
        }
        temp.append(.floor)
        out.append(temp)
    }
    out.append(Array(repeating: .floor, count: w))
    return out
}

func count(i:Int, j:Int, array:Array<Array<Cell>>) -> Int {
    var acc = 0
    for k in i-1...i+1 {
        for l in j-1...j+1 {
            if array[l][k] == .full && (k != i || l != j) {
                acc += 1
            }
        }
    }
    return acc
}



func cycle(_ input:Array<Array<Cell>>, f:(Int,Int,Array<Array<Cell>>)->Int = count , limit:Int = 4)->Array<Array<Cell>> {
    var out = input
    for i in 1 ..< input[0].count-1{
        for j in 1..<input.count-1 {
            switch input[j][i] {
            case .empty:
                if f(i, j, input) == 0 {
                    out[j][i] = .full
                }
            case .full:
                if f(i, j, input) >= limit {
                    out[j][i] = .empty
                }
            case .floor:
                break
            }
        }
    }
    return out
}

func total(input:Array<Array<Cell>>) -> Dictionary<Cell,Int> {
    var out:Dictionary<Cell,Int> = [.floor:0, .empty:0, .full:0]
    for i in 1 ..< input[0].count-1{
        for j in 1..<input.count-1 {
            out[array[j][i]]! += 1
        }
    }
    return out
}


var array = buildData(test1)
var done = false
var i = 0
while !done {
    let new = cycle(array)
    done = new == array
    i+=1
    print(i,total(input:new),done)
    array = new
}

//array = buildData(data)
//done = false
//i = 0
//while !done {
//    let new = cycle(array)
//    done = new == array
//    i+=1
//    print(i,total(input:new),done)
//    array = new
//}
//

//part 2

func count2(i0:Int, j0:Int, array:Array<Array<Cell>>) -> Int {
    var acc = 0
    for k in -1...1{
        for l in -1...1 {
            if  k != 0 || l != 0 {
                var i = i0 + k
                var j = j0 + l
                var done = false
                repeat {
                    switch array[j][i] {
                    case .full:
                        acc += 1
                        done = true
                    case .empty:
                        done = true
                    case.floor:
                        done = false
                    }
                    i += k
                    j += l
                    if j <= 0 || i <= 0 || j >= array.count-1 || i >= array[0].count-1 {
                        done = true
                    }
                } while !done
            }
        }
    }
    return acc
}

func pa(array:Array<Array<Cell>>){
    var out = ""
    array.forEach{
        a in out.append(a.map{"\($0)"}.joined())
        out.append("\n")
    }
    print(out)
}

array = buildData(data)
done = false
i = 0
while !done {
    let new = cycle(array,f:count2,limit:5)
    done = new == array
    i+=1
    print(i,total(input:new),done)
    array = new
    pa(array: array)
}

