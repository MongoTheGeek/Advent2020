//
//  main.swift
//  22
//
//  Created by Mark Lively on 12/22/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

func buildDecks(s:String)->(Array<Int>,Array<Int>){
    let p1 = s.components(separatedBy:"\n\n")[0]
    let p2 = s.components(separatedBy:"\n\n")[1]
    let d1 = p1.components(separatedBy: .newlines).compactMap({Int($0)})
    let d2 = p2.components(separatedBy: .newlines).compactMap({Int($0)})
    return (d1,d2)
}

func combatTurn(p1:inout Array<Int>, p2:inout Array<Int>, printScore:Bool = false){
    if printScore{
        print("Player 1:\(p1)")
        print("Player 2:\(p2)")
    }
    let c1 = p1.removeFirst()
    let c2 = p2.removeFirst()
    if printScore{
        print("Player 1 plays:\(c1)")
        print("Player 2 plays:\(c2)")
    }
    if c1 > c2 {
        if printScore{
            print("Player 1 wins")
        }
        p1.append(c1)
        p1.append(c2)
    } else {
        if printScore{
            print("Player 2 wins")
        }
        p2.append(c2)
        p2.append(c1)
    }
}

func rCombatTurn(p1:inout Array<Int>, p2:inout Array<Int>, printScore:Bool = false, depth:Int){
    if printScore{
        print("Player 1:\(p1)")
        print("Player 2:\(p2)")
    }
    let c1 = p1.removeFirst()
    let c2 = p2.removeFirst()
    let win:Bool
    if c1 <= p1.count && c2 <= p2.count {
        let q1 = Array(p1[0..<c1])
        let q2 = Array(p2[0..<c2])
        win = playRecursiveGame(p1: q1, p2: q2, printScore:printScore, depth:depth+1)
    } else {
        win = c1 > c2
    }
    if printScore{
        print("Player 1 plays:\(c1)")
        print("Player 2 plays:\(c2)")
    }
    if win {
        if printScore{
            print("Player 1 wins")
        }
        p1.append(c1)
        p1.append(c2)
    } else {
        if printScore{
            print("Player 2 wins")
        }
        p2.append(c2)
        p2.append(c1)
    }
}

func playRecursiveGame(p1:Array<Int>, p2:Array<Int>, printScore:Bool = false, depth:Int) -> Bool {
//    if depth == 3 {return true}
    var pastDecks:Set<String> = []
    if printScore{print("New game with \(p1.count + p2.count) cards.")}
    var q1 = p1
    var q2 = p2
    while q1.count > 0 && q2.count > 0 {
        if pastDecks.contains("\(q1)-\(q2)") {
            if printScore{print("matched deck")}
            return true
        } else {
           pastDecks.insert("\(q1)-\(q2)")
        }
        rCombatTurn(p1: &q1, p2: &q2, printScore: printScore, depth:depth)
    }
    if depth == 0 {
        print(score(q1), score(q2))
    } else {
        print(Array(repeating: "*", count: depth).joined())
    }
    return q2.count == 0
}

func score(_ p:Array<Int>) -> Int {
    var out = 0
    if p.count == 0 {return 0}
    for i in 1...p.count {
        out += i * p[p.count - i]
    }
    return out
}

var (p1,p2) = buildDecks(s: test)
while p1.count != 0 && p2.count != 0 {
    combatTurn(p1: &p1, p2: &p2, printScore: true)
    print(score(p1),score(p2))
}

(p1,p2) = buildDecks(s: data)
while p1.count != 0 && p2.count != 0 {
    combatTurn(p1: &p1, p2: &p2)
}
print(score(p1),score(p2))

print("Part 2")
(p1,p2) = buildDecks(s: test2)
print(playRecursiveGame(p1: p1, p2: p2, printScore:true, depth:0))

(p1,p2) = buildDecks(s: test)
print(playRecursiveGame(p1: p1, p2: p2, printScore:true, depth:0))

(p1,p2) = buildDecks(s: data)
print(playRecursiveGame(p1: p1, p2: p2, depth:0))
