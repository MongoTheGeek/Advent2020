//
//  main.swift
//  04
//
//  Created by Mark Lively on 12/3/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

let rqd = ["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"]

struct Passport:Equatable{
    var byr:String?
    var iyr:String?
    var eyr:String?
    var hgt:String?
    var hcl:String?
    var ecl:String?
    var pid:String?
    var cid:String?

    var valid:Bool {get { return byr != nil && iyr != nil && eyr != nil && hgt != nil && hcl != nil && ecl != nil && pid != nil && cid != nil}}
    var valid2:Bool {get { return byr != nil && iyr != nil && eyr != nil && hgt != nil && hcl != nil && ecl != nil && pid != nil}}
    
    var valid3:Bool {
        guard let byr = byr, let byr2 = Int(byr) else {return false}
        if byr2 < 1920 || byr2 > 2002 {return false}
        guard let hgt = hgt else  {return false}
        if hgt.hasSuffix("in"){
            guard let hgt2 = Int(hgt.dropLast(2)) else {return false}
            if hgt2 < 59 || hgt2 > 76 {return false}
        } else if hgt.hasSuffix("cm"){
            guard let hgt2 = Int(hgt.dropLast(2)) else {return false}
            if hgt2 < 150 || hgt2 > 193 {return false}
        } else { return false}
        guard let eyr = eyr, let eyr2 = Int(eyr) else {return false}
        if eyr2 < 2020 || eyr2 > 2030 {return false}
        guard let iyr = iyr, let iyr2 = Int(iyr) else {return false}
        if iyr2 < 2010 || iyr2 > 2020 {return false}
        guard let hcl = hcl else {return false}
        let hex = "1234567890abcdefABCDEF"
        if hcl.count != 7 || !hcl.hasPrefix("#") || hcl.components(separatedBy: CharacterSet(charactersIn: hex)).joined() != "#" {
            return false
        }
        if !["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl){return false}
        guard let pid = pid else {return false}
        let num = "0123456789"
        if pid.count != 9 || pid.components(separatedBy: CharacterSet(charactersIn: num)).joined() != "" {
            return false
        }

        return true
    }
    
    init(_ s:String) {
        let tokens = s.components(separatedBy: .whitespacesAndNewlines)
        for t in tokens {
            if t.contains(":") {
            let k = t.components(separatedBy: ":")[0]
            let v = t.components(separatedBy: ":")[1]
                switch k {
                case "byr":
                    byr = v
                case "iyr":
                    iyr = v
                case "eyr":
                    eyr = v
                case "hgt":
                    hgt = v
                case "hcl":
                    hcl = v
                case "ecl":
                    ecl = v
                case "pid":
                    pid = v
                case "cid":
                    cid = v
                default:
                    fatalError(s)
                }
            }
        }
    }
}

var array:Array<Passport> = test.components(separatedBy: "\n\n").map{Passport($0)}
var tot:Int = array.count
var vg:Int = array.reduce(0){return $0 + ($1.valid ? 1 : 0)}
var g:Int = array.reduce(0){return $0 + ($1.valid2 ? 1 : 0)}
var o:Int = array.reduce(0){return $0 + ($1.valid2 ? 1 : 0)}
print (tot, vg, g, o)

array = data.components(separatedBy: "\n\n").map{Passport($0)}

tot = array.count
vg = array.reduce(0){return $0 + ($1.valid ? 1 : 0)}
g = array.reduce(0){return $0 + ($1.valid2 ? 1 : 0)}
o = array.reduce(0){return $0 + ($1.valid3 ? 1 : 0)}
print (tot, vg, g, o)

array = good.components(separatedBy: "\n\n").map{Passport($0)}

tot = array.count
vg = array.reduce(0){return $0 + ($1.valid ? 1 : 0)}
g = array.reduce(0){return $0 + ($1.valid2 ? 1 : 0)}
o = array.reduce(0){return $0 + ($1.valid3 ? 1 : 0)}
print (tot, vg, g, o)
