//
//  main.swift
//  TestDictionary
//

import Foundation
//let path = NSString(string: "/Users/brian/Desktop/TestDictionary/words.txt").expandingTildeInPath
let path = "~/Desktop/wordFreqDict.txt"
/*let fileManager = FileManager.default
if fileManager.fileExists(atPath: "/Users/brian/Desktop/TestDictionary/words.txt"){
    let content = fileManager.contents(atPath: "/Users/brian/Desktop/TestDictionary/words.txt")
    let newStr = String(data: content!, encoding: .utf8)
    let test = newStr!.components(separatedBy: "\n")
    print(test)
}*/

let file = "words.txt"
let text = "some text"


print("\nTest 2")
/*let test2 = LetterMapper()
print(test2.getMapping(letter: "h"))
print(test2.getMapping(letter: "a"))
print(test2.getMapping(letter: "z"))
print(test2.getMapping(letter: "3"))
print(test2.getMapping(letter: "'"))
print("\nTest 3")*/
let arr = [2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9]
/*
let test3 = LetterMapper(customMap: arr)
print(test3.getMapping(letter: "h"))
print(test3.getMapping(letter: "a"))
print(test3.getMapping(letter: "z"))
print(test3.getMapping(letter: "3"))
print(test3.getMapping(letter: "'"))

print("\nTest 4")
let test4 = DictionaryQuery()
test4.addWord(word: "hello'll")
test4.addWord(word: "hello")
test4.addWord(word: "test")
test4.addWord(word: "yo")
print(test4.getWord(sequence: "hel"))
print(test4.getWord(sequence: "h"))
print(test4.getWord(sequence: "z"))
print(test4.getWord(sequence: "3"))
*/

print("\nTest 5")
let test5 = DictionaryQuery(customMap: arr)
print(test5.getWord(sequence: "test"))
test5.addWord(word: "hello'll", frequency:9)
test5.addWord(word: "hello", frequency: 10)
test5.addWord(word: "test", frequency: 30)
test5.addWord(word: "yo", frequency: 5)
test5.addWord(word: "yo", frequency: 10)
print(test5.getWord(sequence: "hel"))
print(test5.getWord(sequence: "h"))
print(test5.getWord(sequence: "z"))
print(test5.getWord(sequence: "3"))
print(test5.getWord(sequence: "4"))
test5.updateFrequencies()
print(test5.getWord(sequence: "hel"))
print(test5.getWord(sequence: "4"))
test5.updateSelectedWordCount(word: "hello'll")
test5.updateSelectedWordCount(word: "hello'll")
print(test5.getWord(sequence: "4"))
test5.updateFrequencies()
print(test5.getWord(sequence: "4"))

print("\nTest 6 - Import dictionary")
let test6 = DictionaryQuery()
test6.loadDictionary(fileName: path)
print(test6.getWord(sequence: "this"))
print(test6.getWord(sequence: "water", numResults: 3))

print("\nTest 7")
let test7 = DictionaryQuery(customMap: arr, fileName: path)
print("Dictionayr made")
//print(test7.getWord(sequence: "468", numResults: 10))
print(test7.getWord(sequence: "2").count)
print(test7.getWord(sequence: "2", numResults: 10))
print(test7.getWord(sequence: "76389"))
print("start sorting")
test7.updateFrequencies()
print("done sorting")
test7.updateSelectedWordCount(word: "be")
test7.exportDictionary()
