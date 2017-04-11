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
        }
    }
    
    // Returns the corresponding mapping for a letter
    func getMapping(letter: Character) -> Int{
        if self.map[letter] == nil {
            // This will happen if a number or puncutation is given
            // meaning when there is no specified mapping
            
            // Return the raw number
            if letter >= "0" && letter <= "9" {
                return Int(String(letter))!
            }
            
            // Return the ascii value of the character
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
