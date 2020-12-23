//
//  main.swift
//  19
//
//  Created by Mark Lively on 12/19/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

enum Rule {
    case letter(String), other(Array<Array<Int>>)
}

extension Dictionary where Key==Int, Value==Rule {
    func listValid(i :Int) -> Array<String> {
        switch self[i]! {
        case .letter(let s):
            return [s]
        case .other(let arr):
            var out:Array<String> = []
            for opt in arr{
                var temp = [""]
                for v in opt {
                    var temp2:Array<String> = []
                    let s1 = listValid(i: v)
                    for s in s1 {
                        for t in temp {
                            temp2.append(t+s)
                        }
                    }
                    temp = temp2
                }
                out.append(contentsOf: temp)
            }
            return out
        }
    }
}

func parseRules(_ s:String)->Dictionary<Int,Rule> {
    var out:Dictionary<Int,Rule> = [:]
    for l in s.components(separatedBy:.newlines){
        let t = l.components(separatedBy: ":")
        let key = Int(t[0])!
        let value:Rule
        if t[1].contains("\""){
            value = Rule.letter(t[1].components(separatedBy: "\"")[1])
        } else {
            value = Rule.other( t[1].components(separatedBy: "|").map{
                options in return options.components(separatedBy: " ").compactMap{Int($0)}
            })
        }
        out[key] = value
    }
    return out
}


func part1(_ s:String) {
    let rules = parseRules(s.components(separatedBy: "\n\n")[0])
    let valid = Set(rules.listValid(i: 0))
    print(valid.count)
    var result = 0
    for l in s.components(separatedBy: "\n\n")[1].components(separatedBy: .newlines){
        if valid.contains(l) {result += 1}
    }
    print(result)
}
part1(test1)
part1(data)

func part2(_ s:String) {
    let rules = parseRules(s.components(separatedBy: "\n\n")[0])
    let r42 = rules.listValid(i: 42)
    let r31 = rules.listValid(i: 31)
    var result = 0
    for l in s.components(separatedBy: "\n\n")[1].components(separatedBy: .newlines){
        var temp = l
        var a = 0
        var b = 0
        var good = true
        while temp.count >= 8 {
            let pref = String(temp.prefix(8))
            temp.removeFirst(8)
            if b == 0 && r42.contains(pref) {
                a += 1
            } else if r31.contains(pref) {
                b += 1
            } else {
                good = false
            }
        }
        if good && a>=2 && b>=1 && b < a {
            print(a,b,l)
            result += 1
        }
    }
    print(result)
}

part2(data)
