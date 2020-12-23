//
//  main.swift
//  20
//
//  Created by Mark Lively on 12/20/20.
//  Copyright © 2020 Livelys. All rights reserved.
//
//
import Foundation
//
//enum matchSide{
//    case top,bottom,left,right,top_rev,bottom_rev,left_rev,right_rev
//}
//
//func reversed(i:UInt16)->UInt16{
//    var i = i
//    var out:UInt16 = 0
//    for _ in 0..<10 {
//        out = out << 1 + i % 2
//        i = i >> 1
//    }
//    return out
//}
//
//struct Tile:Equatable {
//
//    static func == (lhs:Tile, rhs:Tile) -> Bool{
//        return lhs.id == rhs.id
//    }
//
//    var flipped:Bool = false
//    var rotate:Int = 0
//    let id: Int
//    let pic: Array<String>
//    var top: UInt16 {
//        get {
//            pic[0].reduce(0,{$0 << 1 + ($1 == "#" ? 1 : 0)})
//        }
//    }
//    var bottom: UInt16 {
//        get {
//            pic[9].reversed().reduce(0,{$0 << 1 + ($1 == "#" ? 1 : 0)})
//        }
//    }
//    var left: UInt16 {
//        get {
//            pic.reversed().map({$0.prefix(1)}).reduce(0,{$0 << 1 + ($1 == "#" ? 1 : 0)})
//        }
//    }
//    var right: UInt16 {
//        get {
//            pic.map({$0.suffix(1)}).reduce(0,{$0 << 1 + ($1 == "#" ? 1 : 0)})
//        }
//    }
//
//    var match_right: UInt16 {
//        get {
//            switch rotate {
//            case 0:
//                return flipped ? reversed(i: left) : right
//            case 1:
//                return flipped ? reversed(i: bottom) : top
//            case 2:
//                return flipped ? reversed(i: right) : left
//            case 3:
//                return flipped ? reversed(i: top) : bottom
//            default:
//                return 0
//            }
//        }
//    }
//
//    var match_bottom: UInt16 {
//        get {
//            switch rotate {
//            case 0:
//                return flipped ? reversed(i: bottom) : bottom
//            case 1:
//                return flipped ? reversed(i: right) : right
//            case 2:
//                return flipped ? reversed(i: top) : top
//            case 3:
//                return flipped ? reversed(i: left) : left
//            default:
//                return 0
//            }
//        }
//    }
//
//
//    init(_ s:String){
//        let lines = s.components(separatedBy: .newlines)
//        id = Int(String(lines[0].components(separatedBy: " ")[1].dropLast()))!
//        pic = Array(lines[1...])
//    }
//
//    func matched(_ t:Tile) -> Bool{
//        if self.id == t.id {return false}
//        let ol = [t.top,t.bottom,t.left,t.right]
//        let sl = [self.top,self.bottom,self.left,self.right,
//                 reversed(i: self.top),reversed(i: self.bottom),reversed(i: self.left),reversed(i: self.right)]
//        for o in ol {
//            for s in sl {
//                if o == s {return true}
//            }
//        }
//        return false
//    }
//
//    func matchedSide(_ ot:Tile) -> matchSide? {
//        let otl = [ot.top, ot.bottom, ot.left, ot.right]
//        if otl.contains(top) {return .top}
//        if otl.contains(bottom) {return .bottom}
//        if otl.contains(left) {return .left}
//        if otl.contains(right) {return .right}
//        if otl.contains(reversed(i: top)) {return .top_rev}
//        if otl.contains(reversed(i: bottom)) {return .bottom_rev}
//        if otl.contains(reversed(i: left)) {return .left_rev}
//        if otl.contains(reversed(i: right)) {return .right_rev}
//        return nil
//    }
//
//    func sideMatching(_ ot:UInt16) -> matchSide? {
//        if ot == top {return .top}
//        if ot == bottom {return .bottom}
//        if ot == left {return .left}
//        if ot == right {return .right}
//        if ot == reversed(i: top) {return .top_rev}
//        if ot == reversed(i: bottom) {return .bottom_rev}
//        if ot == reversed(i: left) {return .left_rev}
//        if ot == reversed(i: right) {return .right_rev}
//        return nil
//    }
//
//
//    mutating func faceTop(s:matchSide){
//        switch s {
//        case .top:
//            break
//        case .right:
//            rotate = 3
//        case .bottom:
//            rotate = 2
//        case .left:
//            rotate = 1
//        case .top_rev, .bottom_rev:
//            flipped = true
//        case .left_rev:
//            rotate = 3
//            flipped = true
//        case .right_rev:
//            rotate = 1
//            flipped = true
//        }
//    }
//
//    mutating func faceLeft(s:matchSide){
//        switch s {
//        case .top:
//            rotate = 3
//        case .right:
//            rotate = 2
//        case .bottom:
//            rotate = 1
//        case .left:
//            break
//        case .top_rev:
//            flipped = true
//            rotate = 3
//        case .bottom_rev:
//            flipped = true
//            rotate = 1
//        case .left_rev:
//            rotate = 2
//            flipped = true
//        case .right_rev:
//            rotate = 1
//            flipped = true
//        }
//    }
//
//    func actual(i:Int, j:Int) -> Character {
//        switch rotate {
//        case 0:
//            return flipped ? pic[j].suffix(i+1).first! : pic[j].prefix(i+1).last!
//        case 1:
//            return flipped ? pic[11-i].prefix(j+1).last! : pic[i].prefix(j+1).last!
//        case 2:
//            return flipped ? pic[11-j].prefix(i+1).last! : pic[11-j].suffix(i+1).first!
//        case 3:
//            return flipped ? pic[i].suffix(i+1).first! : pic[11-i].prefix(i+1).last!
//        default:
//            return "O"
//        }
//    }
//}
//
//func part1(_ s:String) {
//    var tiles:Array<Tile> = []
//    for t in s.components(separatedBy:"\n\n"){
//        tiles.append(Tile(t))
//    }
//    print(tiles.count)
//    var outTiles:Array<Tile> = []
//    for t in tiles {
//        var count = 0
//        for ot in tiles {
//            if t.matched(ot){count += 1}
//        }
//        if count == 2 {outTiles.append(t)}
//    }
//    print(outTiles.reduce(1,{$0*$1.id}), outTiles)
//}
//
//part1(test)
//part1(data)
//
//func arrange(_ input:Array<Tile>) -> Array<Array<Tile>> {
//    let rowLength = input.count == 9 ? 3 : 12
//    var unarranged = input
//    var arranged:Array<Array<Tile>> = []
//    var row:Array<Tile> = []
//    var found = false
//    var i = 0
//    while !found {
//        var matched:Array<Tile> = []
//        for j in 0..<input.count {
//            if input[i].matched(input[j]) {matched.append(input[j])}
//        }
//        if matched.count == 2 {
//            found = true
//            var tile = input[i]
//            let sides = matched.map({tile.matchedSide($0)})
//            if sides.contains(.right) || sides.contains(.right_rev) {
//                if sides.contains(.top) || sides.contains(.top_rev){
//                    tile.rotate = 1
//                }
//            } else {
//                if sides.contains(.top) || sides.contains(.top_rev){
//                    tile.rotate = 2
//                } else {
//                    tile.rotate = 3
//                }
//
//            }
//            row.append(tile)
//            unarranged.remove(at:unarranged.firstIndex(of: tile)!)
//        }
//        i += 1
//    }
//    while unarranged.count > 0 {
//        while row.count < rowLength {
//            for i in 0..<unarranged.count {
//                var tile = unarranged[i]
//                if let side = tile.sideMatching(row.last!.match_right) {
//                    tile.faceLeft(s: side)
//                    row.append(tile)
//                    unarranged.remove(at: i)
//                    break
//                }
//            }
//        }
//        arranged.append(row)
//        for i in 0..<unarranged.count {
//            var tile = unarranged[i]
//            if let side = tile.sideMatching(row.first!.match_bottom) {
//                tile.faceTop(s: side)
//                row = [tile]
//                unarranged.remove(at: i)
//                break
//            }
//        }
//    }
//    return arranged
//}
//
//func printFull(_ arr:Array<Array<Tile>>){
//    for ar in arr {
//        for j in 0..<12 {
//            var line = ""
//            for a in ar {
//                for i in 0..<12 {
//                    line.append(a.actual(i: i, j: j))
//                }
//            }
//            print(line)
//        }
//    }
//}
//
//var tiles:Array<Tile> = []
//for t in test.components(separatedBy:"\n\n"){
//    tiles.append(Tile(t))
//}
//let arranged = arrange(tiles)
//printFull(arranged)

enum Side {
    case top,left,bottom,right
}

struct Tile:Equatable {
    let id:Int
    var image:Array<Array<Bool>>
    
    init(_ s:String) {
        let lines = s.components(separatedBy: .newlines)
        id = Int(lines[0].dropLast().dropFirst(5))!
        var temp:Array<Array<Bool>> = []
        for l in lines[1..<lines.count] {
            var row:Array<Bool> = []
            for c in l {
                if c == "#" {row.append(true)} else {row.append(false)}
            }
            temp.append(row)
        }
        image = temp
    }
    
    init(id:Int, image:Array<Array<Bool>>){
        self.id = id
        self.image = image
    }

    mutating func flip() {
        image = image.reversed()
    }
    
    mutating func rotate() {
        var temp:Array<Array<Bool>> = []
        for i in 0..<image.first!.count{
            var row:Array<Bool> = []
            for j in (0..<image.count).reversed() {
                row.append(self.image[j][i])
            }
            temp.append(row)
        }
        image = temp
    }
    
    static func == (lhs:Tile, rhs:Tile) -> Bool{
        return lhs.id == rhs.id
    }
    
    func canMatch(_ t:Tile) -> Side? {
        let left = image.map{$0.first!}
        let right = image.map{$0.last!}
        let top = image.first!
        let bottom = image.last!
        var t = t
        for i in 0..<8{
            if t.image.first! == left {return .left}
            if t.image.first! == right {return .right}
            if t.image.first! == top {return .top}
            if t.image.first! == bottom {return .bottom}
            t.rotate()
            if i == 3 {t.flip()}
        }
        return nil
    }
    
    func matchBottom(_ t:Tile) -> Tile? {
        var t = t
        let bottom = image.last!
        for i in 0..<8{
            let top = t.image.first!
            if top == bottom {return t}
            t.rotate()
            if i == 3 {t.flip()}
        }
        return nil
    }

    func matchRight(_ t:Tile) -> Tile? {
        var t = t
        let right = image.map{$0.last!}
        for i in 0..<8{
            let left = t.image.map{$0.first!}
            if left == right {return t}
            t.rotate()
            if i == 3 {t.flip()}
        }
        return nil
    }

    var waves:Int {
        get {
            return image.flatMap({$0}).reduce(0, {$0 + ($1 ? 1 : 0)})
        }
    }
    
    func matchSerpent(s:Array<Array<Bool>>,i:Int,j:Int) -> Bool {
        for y in 0..<s.count{
            for x in 0..<s[y].count {
                if s[y][x] {
                    if !self.image[y+j][x+i] {return false}
                }
            }
        }
        return true
    }
    
    func countSerpent(s:Array<Array<Bool>>) -> Int{
        var out = 0
        for j in 0..<image.count - s.count {
            for i in 0..<image[0].count - s[0].count {
                if matchSerpent(s: s, i: i, j: j){out += 1}
            }
        }
        return out
    }

}

func buildGrid(_ tiles:Array<Tile>) -> Array<Array<Tile>> {
    var remaining = tiles
    var grid: Array<Array<Tile>> = []
    var row:Array<Tile> = []
    let rowcount = Int(sqrt(Float(tiles.count)))

    for candidate in tiles {
        var sides:Dictionary<Side,Tile> = [:]
        for t in tiles{
            if t != candidate {
                if let side = candidate.canMatch(t){
                    sides[side] = t
                }
            }
        }
        if sides.count == 2 {
            var topleft = candidate
            if sides.keys.contains(.right){
                if sides.keys.contains(.top){topleft.rotate()}
            } else {
                if sides.keys.contains(.top){topleft.rotate();topleft.rotate()}
                else {topleft.rotate();topleft.rotate();topleft.rotate()}
            }
            row.append(topleft)
            remaining.remove(at: remaining.firstIndex(of: candidate)!)
            break
        }
    }
    while remaining.count > 0 {
        while row.count < rowcount {
            for t in remaining {
                if let next = row.last!.matchRight(t){
                    remaining.remove(at: remaining.firstIndex(of: t)!)
                    row.append(next)
                    break
                }
            }
        }
        grid.append(row)
        for t in remaining{
            if let t = row.first!.matchBottom(t){
                row = [t]
                remaining.remove(at: remaining.firstIndex(of: t)!)
                break
            }
        }
    }
    return grid
}

func printGrid(grid:Array<Array<Tile>>){
    for j in 0..<grid.count{
        for j2 in 0..<grid[j][0].image.count {
            var line = ""
            for i in 0..<grid[j].count {
                for i2 in 0..<grid[j][i].image[j2].count {
                    if grid[j][i].image[j2][i2] { line.append("#")} else {line.append(".")}
                }
                line.append(" ")
            }
            print(line)
        }
        print()
    }
}

func mergeTiles(grid:Array<Array<Tile>>)->Tile {
    var image:Array<Array<Bool>> = []
    for j in 0..<grid.count{
        for j2 in 1 ..< (grid[j][0].image.count - 1){
            var row:Array<Bool> = []
            for i in 0..<grid[j].count {
                for i2 in 1..<(grid[j][i].image[j2].count - 1) {
                    row.append(grid[j][i].image[j2][i2])
                }
            }
            image.append(row)
        }
    }
    return Tile(id:0, image:image)
}

func makeSerpent(s:String)->Array<Array<Bool>> {
    var out:Array<Array<Bool>> = []
    for l in s.components(separatedBy: .newlines){
        var row:Array<Bool> = []
        for c in l {
            if c == "#" {
                row.append(true)
            } else {
                row.append(false)
            }
        }
        out.append(row)
    }
    return out
}

var tiles = test.components(separatedBy:"\n\n").map{Tile($0)}
var grid = buildGrid(tiles)
printGrid(grid: grid)
var bigTile = mergeTiles(grid: grid)
let s = makeSerpent(s: serpent)
printGrid(grid: [[bigTile]])

var sCount = 0
for i in 0..<8{
    sCount = max(sCount, bigTile.countSerpent(s: s))
    bigTile.rotate()
    if i == 3 {bigTile.flip()}
}
print(sCount)
print(bigTile.waves,bigTile.waves-15*sCount)

tiles = data.components(separatedBy:"\n\n").map{Tile($0)}
grid = buildGrid(tiles)
printGrid(grid: grid)
bigTile = mergeTiles(grid: grid)
printGrid(grid: [[bigTile]])

sCount = 0
for i in 0..<8{
    sCount = max(sCount, bigTile.countSerpent(s: s))
    bigTile.rotate()
    if i == 3 {bigTile.flip()}
}
print(sCount)
print(bigTile.waves,bigTile.waves-15*sCount)

