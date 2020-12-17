//
//  main.swift
//  17
//
//  Created by Mark Lively on 12/17/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

var grid:Array<Array<Array<Bool>>> = []

func buildGrid(s:String) -> Array<Array<Array<Bool>>> {
    let rows = s.components(separatedBy: .newlines)
    let rowCount = rows.count + 2
    let colCount = rows.first!.count + 2
    let zCount = 3
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    var out = Array(repeating:p0, count:zCount)
    let k = 1
    var j = 1
    for r in rows {
        var i = 1
        for c in r {
            switch c {
            case "#":
                out[k][j][i] = true
            default:
                break
            }
            i += 1
        }
        j += 1
    }
    return out
}

func expandGrid(input:Array<Array<Array<Bool>>>) -> Array<Array<Array<Bool>>> {
    var expandK = false
    var expandJ = false
    var expandI = false
    for i in 0..<input.first!.first!.count {
        for j in 0..<input.first!.count {
            if input[0][j][i] || input[input.count - 1][j][i] {
                expandK = true
                break
            }
        }
        if expandK {break}
    }
    for i in 0..<input.first!.first!.count {
        for k in 0..<input.count {
            if input[k][0][i] || input[k][input.first!.count - 1][i] {
                expandJ = true
                break
            }
        }
        if expandJ {break}
    }
    for j in 0..<input.first!.count {
        for k in 0..<input.count {
            if input[k][j][0] || input[k][j][input.first!.first!.count - 1] {
                expandI = true
                break
            }
        }
        if expandI {break}
    }

    if !expandI && !expandJ && !expandK {return input}

    let zCount = input.count + (expandK ? 2 : 0)
    let rowCount = input.first!.count + (expandJ ? 2 : 0)
    let colCount = input.first!.first!.count + (expandI ? 2 : 0)
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    var out = Array(repeating:p0, count:zCount)
    for k in 0..<input.count{
        for j in 0..<input.first!.count {
            for i in 0..<input.first!.first!.count {
                let kOut = expandK ? k + 1 : k
                let jOut = expandJ ? j + 1 : j
                let iOut = expandI ? i + 1 : i
                out[kOut][jOut][iOut] = input[k][j][i]
            }
        }
    }
    return out
}

func runCycle(input:Array<Array<Array<Bool>>>) -> Array<Array<Array<Bool>>> {
    let zCount = input.count
    let rowCount = input.first!.count
    let colCount = input.first!.first!.count
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    var out = Array(repeating:p0, count:zCount)
    for k in 0..<input.count{
        for j in 0..<input.first!.count {
            for i in 0..<input.first!.first!.count {
                var c = 0
                let nMin = k == 0 ? 0 : k - 1
                let nMax = k == input.count-1 ? k : k + 1
                let mMin = j == 0 ? 0 : j - 1
                let mMax = j == input.first!.count-1 ? j: j + 1
                let lMin = i == 0 ? 0 : i - 1
                let lMax = i == input.first!.first!.count-1 ? i : i + 1
                for n in nMin...nMax {
                    for m in mMin...mMax {
                        for l in lMin...lMax {
                            if input[n][m][l] && (n != k || m != j || l != i) {
                                c += 1
                            }
                        }
                    }
                }
                if (input[k][j][i] && c == 2) || c == 3 {
                    out[k][j][i] = true
                }
            }
        }
    }
    return out
}

func count(input:Array<Array<Array<Bool>>>) -> Int {
    var out = 0
    for k in 0..<input.count {
        for j in 0..<input.first!.count {
            for i in 0..<input.first!.first!.count {
                if input[k][j][i] {out += 1}
            }
        }
    }
    return out
}

func printGrid(input:Array<Array<Array<Bool>>>){

    for k in 0..<input.count {
        var plane = ["z = \(input.count/2 - (k))"]
        for j in 0..<input.first!.count {
            var row = ""
            for i in 0..<input.first!.first!.count {
                row.append( input[k][j][i] ? "#" : ".")
            }
            plane.append(row)
        }
        print(plane.joined(separator: "\n"))
    }
    print("--------------------------")
}


grid = buildGrid(s: test1)
printGrid(input: grid)
for n in 0..<6 {
    grid = runCycle(input: grid)
    grid = expandGrid(input: grid)
    print (n, count(input: grid))
//    printGrid(input: grid)
}

grid = buildGrid(s: data)
printGrid(input: grid)
for n in 0..<6 {
    grid = runCycle(input: grid)
    grid = expandGrid(input: grid)
    print (n, count(input: grid))
//    printGrid(input: grid)
}


///PART 2

var grid4:Array<Array<Array<Array<Bool>>>> = []

func buildGrid4(s:String) -> Array<Array<Array<Array<Bool>>>> {
    let rows = s.components(separatedBy: .newlines)
    let rowCount = rows.count + 2
    let colCount = rows.first!.count + 2
    let zCount = 3
    let wCount = 3
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    let z0 = Array(repeating:p0, count:zCount)
    var out = Array(repeating:z0, count:wCount)
    let w = 1
    let k = 1
    var j = 1
    for r in rows {
        var i = 1
        for c in r {
            switch c {
            case "#":
                out[w][k][j][i] = true
            default:
                break
            }
            i += 1
        }
        j += 1
    }
    return out
}

func expandGrid4(input:Array<Array<Array<Array<Bool>>>>) -> Array<Array<Array<Array<Bool>>>> {
    var expandW = false
    var expandK = false
    var expandJ = false
    var expandI = false
    for w in 0..<input.count {
        for i in 0..<input.first!.first!.first!.count {
            for j in 0..<input.first!.first!.count {
                if input[w][0][j][i] || input[w][input.first!.count - 1][j][i] {
                    expandK = true
                    break
                }
            }
            if expandK {break}
        }
        if expandK {break}
    }
    for w in 0..<input.count {
        for i in 0..<input.first!.first!.first!.count {
            for k in 0..<input.first!.count {
                if input[w][k][0][i] || input[w][k][input.first!.first!.count - 1][i] {
                    expandJ = true
                    break
                }
            }
            if expandJ {break}
        }
        if expandJ {break}
    }
    for w in 0..<input.count {
        for j in 0..<input.first!.first!.count {
            for k in 0..<input.first!.count {
                if input[w][k][j][0] || input[w][k][j][input.first!.first!.first!.count - 1] {
                    expandI = true
                    break
                }
            }
            if expandI {break}
        }
        if expandI {break}
    }
    for k in 0..<input.first!.count{
        for j in 0..<input.first!.first!.count{
            for i in 0..<input.first!.first!.first!.count{
                if input[0][k][j][i] || input[input.count-1][k][j][i] {
                    expandW = true
                    break
                }
            }
            if expandW {break}
        }
        if expandW {break}
    }

    if !expandI && !expandJ && !expandK && !expandW {return input}

    let wCount = input.count + (expandW ? 2 : 0)
    let zCount = input.first!.count + (expandK ? 2 : 0)
    let rowCount = input.first!.first!.count + (expandJ ? 2 : 0)
    let colCount = input.first!.first!.first!.count + (expandI ? 2 : 0)
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    let z0 = Array(repeating:p0, count:zCount)
    var out = Array(repeating:z0, count:wCount)
    for w in 0..<input.count{
        let wOut = expandW ? w + 1 : w
        for k in 0..<input.first!.count{
            let kOut = expandK ? k + 1 : k
            for j in 0..<input.first!.first!.count {
                let jOut = expandJ ? j + 1 : j
                for i in 0..<input.first!.first!.first!.count {
                    let iOut = expandI ? i + 1 : i
                    out[wOut][kOut][jOut][iOut] = input[w][k][j][i]
                }
            }
        }
    }
    return out
}

func runCycle4(input:Array<Array<Array<Array<Bool>>>>) -> Array<Array<Array<Array<Bool>>>> {
    let wCount = input.count
    let zCount = input.first!.count
    let rowCount = input.first!.first!.count
    let colCount = input.first!.first!.first!.count
    let r0 = Array(repeating:false, count:colCount)
    let p0 = Array(repeating:r0, count:rowCount)
    let z0 = Array(repeating:p0, count:rowCount)
    var out = Array(repeating:z0, count:wCount)
    for w in 0..<wCount {
        let oMin = w == 0 ? 0 : w - 1
        let oMax = w == wCount - 1 ? w : w + 1
        for k in 0..<zCount {
            let nMin = k == 0 ? 0 : k - 1
            let nMax = k == zCount - 1 ? k : k + 1
            for j in 0..<rowCount {
                let mMin = j == 0 ? 0 : j - 1
                let mMax = j == rowCount - 1 ? j : j + 1
                for i in 0..<colCount {
                    var c = 0
                    let lMin = i == 0 ? 0 : i - 1
                    let lMax = i == colCount - 1 ? i : i + 1
                    for o in oMin...oMax {
                        for n in nMin...nMax {
                            for m in mMin...mMax {
                                for l in lMin...lMax {
                                    if input[o][n][m][l] && (o != w || n != k || m != j || l != i) {
                                        c += 1
                                    }
                                }
                            }
                        }
                    }
                    if (input[w][k][j][i] && c == 2) || c == 3 {
                        out[w][k][j][i] = true
                    }
                }
            }
        }
    }
    return out
}

func printGrid4(input:Array<Array<Array<Array<Bool>>>>){

    for w in 0..<input.count {
        for k in 0..<input.first!.count {
        var plane = ["z = \(input.count/2 - (k))"]
        for j in 0..<input.first!.first!.count {
            var row = ""
            for i in 0..<input.first!.first!.first!.count {
                row.append( input[w][k][j][i] ? "#" : ".")
            }
            plane.append(row)
        }
        print(plane.joined(separator: "\n"))
    }
    print("--------------------------")
    }
    print("===========================================")
}


func count4(input:Array<Array<Array<Array<Bool>>>>) -> Int {
    var out = 0
    for w in 0..<input.count{
        for k in 0..<input.first!.count {
            for j in 0..<input.first!.first!.count {
                for i in 0..<input.first!.first!.first!.count {
                    if input[w][k][j][i] {out += 1}
                }
            }
        }
    }
    return out
}

print("PART2")

grid4 = buildGrid4(s: test1)
for n in 0..<6 {
    grid4 = runCycle4(input: grid4)
    grid4 = expandGrid4(input: grid4)
    print (n, count4(input: grid4))
//    printGrid4(input: grid4)
}

grid4 = buildGrid4(s: data)
for n in 0..<6 {
    grid4 = runCycle4(input: grid4)
    grid4 = expandGrid4(input: grid4)
    print (n, count4(input: grid4))
//    printGrid4(input: grid4)
}

