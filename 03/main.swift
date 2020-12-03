//
//  main.swift
//  03
//
//  Created by Mark Lively on 12/2/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

//Part 1

func parseMap(input:String) -> Array<Array<Bool>> {
    var out:Array<Array<Bool>> = []
    let lines = input.components(separatedBy:.newlines)
    for l in lines {
        var o:Array<Bool> = []
        for c in l {
            o.append(c == "#")
        }
        out.append(o)
    }
    return out
}

func countHits(map:Array<Array<Bool>>, shift:Int, drop:Int = 1) ->Int {
    var x = 0
    var y = 0
    var hit = 0
    let width = map[0].count
    repeat {
        if (map[y][x]){hit += 1}
        y += drop
        x = (x + shift) % width
    } while y < map.count
    return hit
}

var map = parseMap(input: test2)
print("test", countHits(map: map, shift: 3))
map = parseMap(input: data)
print("problem", countHits(map: map, shift: 3))


//Part 2


print("Part 2")
map = parseMap(input: test2)
var answer = countHits(map: map, shift: 1) * countHits(map: map, shift: 3) * countHits(map: map, shift: 5) * countHits(map: map, shift: 7) * countHits(map: map, shift: 1, drop: 2)
print("test", answer)
map = parseMap(input: data)
answer = countHits(map: map, shift: 1) * countHits(map: map, shift: 3) * countHits(map: map, shift: 5) * countHits(map: map, shift: 7) * countHits(map: map, shift: 1, drop: 2)
print("problem", answer)
