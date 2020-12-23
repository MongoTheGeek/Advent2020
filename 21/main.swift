//
//  main.swift
//  21
//
//  Created by Mark Lively on 12/21/20.
//  Copyright © 2020 Livelys. All rights reserved.
//

import Foundation

struct Recipe {
    let ingredients:Array<String>
    let allergens:Array<String>
}

func parseRecipes(_ s:String)-> Array<Recipe> {
    var out:Array<Recipe> = []
    for l in s.components(separatedBy: .newlines){
        let p1 = l.components(separatedBy: " (contains ")[0]
        let p2 = l.components(separatedBy: " (contains ")[1].dropLast()
        out.append(Recipe(ingredients: p1.components(separatedBy: .whitespaces), allergens: p2.components(separatedBy: ", ")))
    }
    return out
}

func buildDictionary(_ recipes:Array<Recipe>) -> Dictionary<String,Set<String>> {
    var allAllergens:Set<String> = []
    for r in recipes {
        allAllergens = allAllergens.union(r.allergens)
    }
    var possibleAllergens:Dictionary<String,Set<String>> = [:]
    for allergen in allAllergens {
        let rList = recipes.filter{$0.allergens.contains(allergen)}
        var dataSet = Set(rList[0].ingredients)
        for r in rList {
            dataSet = dataSet.intersection(r.ingredients)
        }
        possibleAllergens[allergen] = dataSet
    }
    return possibleAllergens
}

func countSafeIngredients(_ recipes:Array<Recipe>) ->Array<String> {
    let possibleAllergens = buildDictionary(recipes)
    let list = possibleAllergens.values.flatMap{$0}
    let ingredientList = recipes.reduce([], {$0 + $1.ingredients})
    let safeList = ingredientList.filter({!list.contains($0)})
    return safeList
}

func cleanList(_ dict:Dictionary<String,Set<String>>) -> Dictionary<String,String> {
    var dirty = dict
    while dirty.count < dirty.values.flatMap({$0}).count {
        for k in dirty.keys {
            if dirty[k]!.count == 1 {
                let v = dirty[k]!.first!
                for k2 in dirty.keys {
                    if k != k2 && dirty[k2]!.contains(v){
                        dirty[k2]!.remove(v)
                    }
                }
            }
        }
    }
    var out:Dictionary<String,String> = [:]
    dirty.keys.forEach{out[$0] = dirty[$0]!.first!}
    return out
}

let part1test = countSafeIngredients(parseRecipes(test1))
print (part1test, part1test.count)
let part1 = countSafeIngredients(parseRecipes(data))
print(part1.count)

let part2test = cleanList(buildDictionary(parseRecipes(test1)))
print (part2test.keys.sorted().map{part2test[$0]!}.joined(separator: ","))

let part2 = cleanList(buildDictionary(parseRecipes(data)))
print (part2.keys.sorted().map{part2[$0]!}.joined(separator: ","))
