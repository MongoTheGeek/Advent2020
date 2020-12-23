//
//  main.swift
//  18
//
//  Created by Mark Lively on 12/18/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func part1(_ s:String) -> Int {
    var total = 0
    let lines = s.components(separatedBy: .newlines)
    for l in lines {
        var add = true
        var result = 0
        var opStack:Array<Bool> = []
        var resultStack:Array<Int> = []
        for t in l {
            switch t{
            case "0"..."9":
                let n = Int(String(t))!
                result = add ? n + result : n * result
            case "+":
                add = true
            case "*":
                add = false
            case "(":
                resultStack.append(result)
                opStack.append(add)
                result = 0
                add = true
            case ")":
                let r0 = resultStack.last!
                let o0 = opStack.last!
                result = o0 ? result + r0 : result * r0
                resultStack.removeLast()
                opStack.removeLast()
            default:
                continue
            }
        }
        total += result
    }
    return total
}

print(part1(test1))
print(part1(test2))
print(part1(test3))
print(part1(test4))
print(part1(test5))
print(part1(data))

///Part 2

enum Oper {
    case plus, times, open
}
func part2(_ s:String) ->Int {
    var total = 0
    for l in s.components(separatedBy: .newlines){
        var numStack:Array<Int> = []
        var operStack:Array<Oper> = []
        for t in l {
            switch t{
            case "0"..."9":
                let n = Int(String(t))!
                if operStack.last == .plus {
                    operStack.removeLast()
                    numStack[numStack.count - 1] += n
                } else {
                    numStack.append(n)
                }
            case "(":
                operStack.append(.open)
            case "+":
                operStack.append(.plus)
            case "*":
                operStack.append(.times)
            case ")":
                var tot = numStack.last!
                var i = 0
                numStack.removeLast()
                for o in operStack.reversed(){
                    i += 1
                    if o == .plus {
                        tot = tot + numStack.last!
                        numStack.removeLast()
                    } else if o == .times {
                        tot = tot * numStack.last!
                        numStack.removeLast()
                    } else {
                        numStack.append(tot)
                        break
                    }
                }
                operStack.removeLast(i)
                if operStack.last == .plus {
                    operStack.removeLast()
                    let n1 = numStack[numStack.count - 1]
                    let n2 = numStack[numStack.count - 2]
                    numStack.removeLast(2)
                    numStack.append(n1+n2)
                }
            default:
                continue
            }
        }
        total += numStack.reduce(1, *)
        if operStack.reduce(false, {$0 || $1 != .times}){
            fatalError()
        }
    }
    return total
}

print(part2(test1))
print(part2(test2))
print(part2(test3))
print(part2(test4))
print(part2(test5))
print(part2(data))
