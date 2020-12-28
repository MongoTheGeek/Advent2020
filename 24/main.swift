//
//  main.swift
//  24
//
//  Created by Mark Lively on 12/24/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

struct Point:Hashable,Equatable {
    let x:Int
    let y:Int
    func adjacentPoints() -> Array<Point> {
        return [Point(x: x+1, y: y), Point(x: x-1, y: y), Point(x: x, y: y+1), Point(x: x, y: y-1), Point(x: x+1, y: y-1), Point(x: x-1, y: y+1)]
    }
}

func listLocations(_ s:String)->Array<Point>{
    var out:Array<Point> = []
    for l in s.components(separatedBy: .newlines){
        var x = 0
        var y = 0
        var last = ""
        for c in l {
            switch c{
            case "n":
                last = "n"
            case "s":
                last = "s"
            case "e":
                if last == "n"{
                    y += 1
                } else if last == "s" {
                    y -= 1
                    x += 1
                } else {
                    x += 1
                }
                last = ""
            case "w":
                if last == "s" {
                    y -= 1
                } else if last == "n" {
                    y += 1
                    x -= 1
                } else {
                    x -= 1
                }
                last = ""
            default:
                fatalError()
            }
        }
        out.append(Point(x: x, y: y))
    }
    return out
}

func countBlack(_ input:Array<Point>)->Int{
    var out:Set<Point> = []
    for p in input {
        if out.contains(p){
            out.remove(p)
        } else {
            out.insert(p)
        }
    }
    return out.count
}

func onlyBlack(_ input:Array<Point>)->Set<Point>{
    var out:Set<Point> = []
    for p in input {
        if out.contains(p){
            out.remove(p)
        } else {
            out.insert(p)
        }
    }
    return out
}


print(countBlack(listLocations(test1)))
print(countBlack(listLocations(data)))

func life(input:Set<Point>)-> Set<Point> {
    var out:Set<Point> = []
    for p in input {
        var c = 0
        for a in p.adjacentPoints() {
            if input.contains(a) {c+=1}
        }
        if c == 1 || c == 2 {out.insert(p)}
    }
    let  possible = input.flatMap{$0.adjacentPoints()}
    for p in possible {
        var c = 0
        for a in p.adjacentPoints() {
            if input.contains(a) {c+=1}
        }
        if c == 2 {out.insert(p)}
    }
    return out
}

var points = onlyBlack(listLocations(test1))
for i in 1...100 {
    points = life(input: points)
    print(i,points.count)
}

points = onlyBlack(listLocations(data))
for i in 1...100 {
    points = life(input: points)
    print("Actual: ",i,points.count)
}

