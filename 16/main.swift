//
//  main.swift
//  16
//
//  Created by Mark Lively on 12/15/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func part1(s:String){
    var fields:Dictionary<String,Array<Int>> = [:]
    let myTicket:Array<Int>
    var tickets:Array<Array<Int>> = []
    let sections = s.components(separatedBy:"\n\n")
    for f in sections[0].components(separatedBy: "\n") {
        let key = f.components(separatedBy: ": ")[0]
        let ranges = f.components(separatedBy: ": ")[1].components(separatedBy: " or ")
        var values:Array<Int> = []
        for r in ranges {
            let s = r.components(separatedBy: "-")
            let start = Int(s[0])!
            let end = Int(s[1])!
            values.append(contentsOf: start...end)
        }
        fields[key] = values
    }

    myTicket = sections[1].components(separatedBy:.newlines)[1].components(separatedBy: ",").map{Int($0)!}
    
    for l in sections[2].components(separatedBy: .newlines)[1...] {
        tickets.append((l.components(separatedBy: ",").map{Int($0)!}))
    }
    
    let allValid = Set(fields.values.flatMap({$0}))
    
    let bad = tickets.flatMap({$0}).filter{!allValid.contains($0)}.reduce(0, +)
    print (bad)
}

part1(s:test1)
part1(s:data)



func part2(s:String){
    var fields:Dictionary<String,Array<Int>> = [:]
    let myTicket:Array<Int>
    var tickets:Array<Array<Int>> = []
    let sections = s.components(separatedBy:"\n\n")
    for f in sections[0].components(separatedBy: "\n") {
        let key = f.components(separatedBy: ": ")[0]
        let ranges = f.components(separatedBy: ": ")[1].components(separatedBy: " or ")
        var values:Array<Int> = []
        for r in ranges {
            let s = r.components(separatedBy: "-")
            let start = Int(s[0])!
            let end = Int(s[1])!
            values.append(contentsOf: start...end)
        }
        fields[key] = values
    }

    myTicket = sections[1].components(separatedBy:.newlines)[1].components(separatedBy: ",").map{Int($0)!}
    
    for l in sections[2].components(separatedBy: .newlines)[1...] {
        tickets.append((l.components(separatedBy: ",").map{Int($0)!}))
    }
    
    let allValid = Set(fields.values.flatMap({$0}))
    
    tickets = tickets.filter{t in t.reduce(true){$0 && allValid.contains($1)}}
    

    var fieldMap:Dictionary<String,Set<Int>> = [:]
    for nk in fields.keys{
        fieldMap[nk] = []
        let arr = fields[nk]!
        for i in 0..<tickets[0].count {
            var found = true
            for j in 0..<tickets.count {
                if !arr.contains(tickets[j][i]){
                    found = false
                    break
                }
            }
            if found {fieldMap[nk]?.insert(i)}
        }
    }

    var multipass = true
    repeat {
        let nk = fieldMap.keys.sorted{fieldMap[$0]!.count < fieldMap[$1]!.count}
        for k in nk {
            if fieldMap[k]!.count == 1 {
                for j in nk {
                    if j != k {
                        fieldMap[j]!.remove(fieldMap[k]!.first!)
                    }
                }
            }
        }
        multipass = fieldMap.values.reduce(true, {$0 && ($1.count != 1)})
    } while multipass
    let neededKeys = fields.keys.filter{$0.hasPrefix("departure")}
    let outFields = neededKeys.map{fieldMap[$0]!.first!}
    print(outFields)
    print(outFields.reduce(1, {$0 * myTicket[$1]}))
}

part2(s: data)
