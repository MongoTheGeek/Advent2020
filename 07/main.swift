//
//  main.swift
//  07
//
//  Created by Mark Lively on 12/7/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

struct Bag:Equatable {
    let color:String
    var contents:Array<(String, Int)>
    
    static func == (lhs:Bag, rhs:Bag) -> Bool {return lhs.color == rhs.color}
    
    func holds(_ color:String) -> Bool {
        return contents.reduce(false) {
            $0 || $1.0 == color
        }
    }
    
}

func collectBags(_ input:String)->Array<Bag> {
    var out:Array<Bag> = []
    for l in input.components(separatedBy:.newlines) {
        let split = l.components(separatedBy: " contain ")
        let name = split[0].components(separatedBy:" ")[0...1].joined(separator:" ")
        let contents = split[1]
        if contents.hasPrefix("no ") {
            out.append(Bag(color:name, contents:[]))
        } else {
            var temp:Array<(String,Int)> = []
            for c in contents.components(separatedBy: ", ") {
                let w = c.components(separatedBy: " ")
                let n = Int(w[0])!
                let co = w[1...2].joined(separator: " ")
                temp.append((co,n))
            }
            out.append(Bag(color:name,contents:temp))
        }
    }
    return out
}


func holds(input:Array<Bag>, color:String)->Array<Bag> {
    var out:Array<Bag> = []
    var new:Array<Bag> = input.filter{$0.holds(color)}
    repeat {
        var newnew:Array<Bag> = []
        for n in new {
            if out.firstIndex(of: n) ==  nil{
                out.append(n)
                newnew.append(contentsOf: input.filter{$0.holds(n.color)})
            }
        }
        new = newnew
    } while new.count > 0
    return out
}

func allUnder(input:Array<Bag>, color:String) -> Int {
    let b = input.filter{$0.color == color}.first!
    var out = 1
    for (n,c) in b.contents {
        out += c * allUnder(input: input, color: n)
    }
    return out
}

var bags = collectBags(test1)
print(bags)
bags = holds(input: bags, color: "shiny gold")
print(bags)
print(bags.count)

bags = collectBags(data)
bags = holds(input: bags, color: "shiny gold")
print(bags.count)

bags = collectBags(test1)
print(allUnder(input: bags, color: "shiny gold") - 1 )

bags = collectBags(test2)
print(allUnder(input: bags, color: "shiny gold") - 1 )

bags = collectBags(data)
print(allUnder(input: bags, color: "shiny gold") - 1 )
