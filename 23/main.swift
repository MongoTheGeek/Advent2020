//
//  main.swift
//  23
//
//  Created by Mark Lively on 12/23/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

let test = "389125467"
let data = "739862541"

class LL {
    static var MAX:Int = 0

    let num:Int
    var next:LL?
    init(_ i:Int){
        num = i
        if i > LL.MAX {LL.MAX = i}
    }

    func find(_ n:Int)-> LL {
        return LLArray[n]
    }
    
    func play() -> LL {
        var nextN = num == 1 ? LL.MAX : num - 1
        while next!.num == nextN || next!.next!.num == nextN || next!.next!.next!.num == nextN {
            nextN = nextN == 1 ? LL.MAX : nextN - 1
        }

        let endSpot = find(nextN)
        let temp = next!
        next = next!.next!.next!.next
        temp.next!.next!.next = endSpot.next
        endSpot.next = temp
        return next!
    }
}
var LLArray:Array<LL> = Array(repeating: LL(0), count: 1000001)


func buildBigLL(_ s:String) -> LL {
    var arr = s.map{Int(String($0))!}
    arr.append(contentsOf: 10...1_000_000)
    let loop = LL(arr[0])
    LLArray[loop.num] = loop
    var tail = loop
    for i in arr[1...]{
        let e = LL(i)
        LLArray[i] = e
        tail.next = e
        tail = e
    }
    tail.next = loop
    return loop
}

func buildLL(_ s:String) -> LL {
    let arr = s.map{Int(String($0))!}
    let loop = LL(arr[0])
    LLArray[loop.num] = loop
    var tail = loop
    for i in arr[1...]{
        let e = LL(i)
        LLArray[i] = e
        tail.next = e
        tail = e
    }
    tail.next = loop
    return loop
}



func buildArray(_ s:String)->Array<Int>{
    return s.map{Int(String($0))!}
}

func play(_ arr:inout Array<Int>){
    if arr[0]%10_000 == 0 {print(arr[0])}
    let pickup = arr[1...3]
    for _ in 0..<3 {arr.remove(at: 1)}
    var active = arr[0] == 1 ? arr.max()! : arr[0] - 1
    while pickup.contains(active){
        active = active == 1 ? arr.max()! : active - 1
    }
    let ind = arr.firstIndex(of: active)! + 1
    for c in pickup.reversed() {
        arr.insert(c, at: ind)
    }
    arr.append(arr.removeFirst())
}

var arr = buildArray(test)
for _ in 0..<10{
    play(&arr)
}
print(arr.map{"\($0)"}.joined())
for _ in 10..<100{
    play(&arr)
}
print(arr.map{"\($0)"}.joined())


arr = buildArray(data)
for _ in 0..<100{
    play(&arr)
}
print(arr.map{"\($0)"}.joined())

///
/// PART 2
///

var loop = buildLL(test)
for _ in 0..<10{
    loop = loop.play()
}

arr = []
loop = loop.find(1)
for _ in 0..<10 {
    arr.append(loop.num)
    loop = loop.next!
}
print(arr.map{"\($0)"}.joined())


loop = buildLL(test)
for _ in 0..<100{
    loop = loop.play()
}
arr = []
loop = loop.find(1)
for _ in 0..<10 {
    arr.append(loop.num)
    loop = loop.next!
}
print(arr.map{"\($0)"}.joined())


arr = buildArray(data)
for _ in 0..<100{
    play(&arr)
}
arr = []
loop = loop.find(1)
for _ in 0..<10 {
    arr.append(loop.num)
    loop = loop.next!
}
print(arr.map{"\($0)"}.joined())

loop = buildBigLL(data)
for _ in 0..<10_000_000 {
    loop = loop.play()
}
loop = loop.find(1)
let a = loop.next!.num
let b = loop.next!.next!.num
print(a,b,a*b)
