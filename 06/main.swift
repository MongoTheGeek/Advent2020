//
//  main.swift
//  06
//
//  Created by Mark Lively on 12/6/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

enum Questions:String{
    case a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
}

func getAnswers(_ s:String)->Array<Array<Questions>> {
    var out:Array<Array<Questions>> = []
    for l in s.components(separatedBy: .newlines) {
        var temp:Array<Questions> = []
        for c in l {
            if let q = Questions(rawValue: String(c)){
                temp.append(q)
            }
        }
        out.append(temp)
    }
    return out
}

//part 2

func allYes(_ answers:Array<Array<Questions>>) -> Set<Questions> {
    let temp = answers.map{Set($0)}
    var out = temp[0]
    for s in temp {
        out = out.intersection(s)
    }
    return out
}




var totalQ:Array<Array<Array<Questions>>> = []
for s in test1.components(separatedBy: "\n\n") {
    totalQ.append(getAnswers(s))
}
var sets = totalQ.map{a in
    return Set(a.flatMap{$0})
}
print (sets)
print(sets.count, sets.map{$0.count})
var count = sets.reduce(0, {$0 + $1.count})
print(count)
print("Part2")
sets = totalQ.map{allYes($0)}
print(sets.count, sets.map{$0.count})
count = sets.reduce(0, {$0 + $1.count})
print(count)


totalQ = []
for s in data.components(separatedBy: "\n\n") {
    totalQ.append(getAnswers(s))
}

sets = totalQ.map{a in
    return Set(a.flatMap{$0})
}
count = sets.reduce(0, {$0 + $1.count})
print(count)

print("Part2")
sets = totalQ.map{allYes($0)}
count = sets.reduce(0, {$0 + $1.count})
print(count)
