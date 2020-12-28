//
//  main.swift
//  25
//
//  Created by Mark Lively on 12/25/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

let target = 7
let door = 5099500
let card = 7648211
//let door = 17807724 //test
//let card = 5764801 // test

let mod = 20201227

var test = 1
var i = 0
while test != door {
    test = (test * target) % mod
    i += 1
}
print (i)
let p = test
test = 1
for _ in 0..<i {
    test = (test * card) % mod
}
print(test)
