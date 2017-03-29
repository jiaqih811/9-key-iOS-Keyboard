//
//  LetterMapper.swift
//  nineKeyKeyboard
//

import Foundation

class LetterMapper {
    var map: [Character: Int]
    var reverseMap: [Int: Array<Character>]
    init() {
        self.map = [:]
        self.reverseMap = [:]
        /*for i in 0...25 {
            self.map[Character(UnicodeScalar(97 + i)!)] = Character(UnicodeScalar(97 + i)!)
        }*/
    }
    // customMap is an array where the first index corresponds to
    // the key that a is on, second index is where b is, etc.
    // For example, [2, 2, 2, 3, 3, 3, ...] means a-c are on key 2
    // d-f are on key 3, etc.
    init(customMap: Array<Character>) {
        self.map = [:]
        self.reverseMap = [:]
        for (i, element) in customMap.enumerated() {
            let elementNum = Int(String(element))
            self.map[Character(UnicodeScalar(97 + i)!)] = elementNum
            if self.reverseMap[elementNum!] == nil {
                self.reverseMap[elementNum!] = [Character]()
            }
            self.reverseMap[elementNum!]!.append(Character(UnicodeScalar(97 + i)!))
            // NOTE: If TrieNode switches children to be an array rather
            // than a dictionary, this will need to be chnaged to match
            // the mapping of ascii to the array
        }
    }
    init(customMap: Array<Int>) {
        self.map = [:]
        self.reverseMap = [:]
        for (i, element) in customMap.enumerated() {
            self.map[Character(UnicodeScalar(97 + i)!)] = element
            if self.reverseMap[element] == nil {
                self.reverseMap[element] = [Character]()
            }
            self.reverseMap[element]!.append(Character(UnicodeScalar(97 + i)!))
            // NOTE: If TrieNode switches children to be an array rather
            // than a dictionary, this will need to be chnaged to match
            // the mapping of ascii to the array
        }
    }
    func getMapping(letter: Character) -> Int{
        if self.map[letter] == nil {
            if letter >= "0" && letter <= "9" {
                return Int(String(letter))!
            }
            // This will happen if a number or puncutation is given
            let str = String(letter)
            let scalar = str.unicodeScalars
            let index = scalar[scalar.startIndex].value - 97
            return Int(index)
        }
        return self.map[letter]!
    }
    
    // Given letter, returns the array of characters that map to it
    func getReverseMapping(num: Int) -> Array<Character> {
        if self.reverseMap[num] == nil {
            return [Character(String(num))]
        }
        return self.reverseMap[num]!
    }
}
