//
//  LetterMapper.swift
//  nineKeyKeyboard
//

import Foundation

class LetterMapper {
    var map: [Character: Character]
    var reverseMap: [Character: Array<Character>]
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
    init(customMap: Array<Int>) {
        self.map = [:]
        self.reverseMap = [:]
        for (i, element) in customMap.enumerated() {
            self.map[Character(UnicodeScalar(97 + i)!)] = Character(UnicodeScalar(48 + element)!)
            if self.reverseMap[Character(UnicodeScalar(48 + element)!)] == nil {
                self.reverseMap[Character(UnicodeScalar(48 + element)!)] = [Character]()
            }
            self.reverseMap[Character(UnicodeScalar(48 + element)!)]!.append(Character(UnicodeScalar(97 + i)!))
            // NOTE: If TrieNode switches children to be an array rather
            // than a dictionary, this will need to be chnaged to match
            // the mapping of ascii to the array
        }
    }
    func getMapping(letter: Character) -> Character{
        if self.map[letter] == nil {
            // This will happen if a number or puncutation is given
            return letter
        }
        return self.map[letter]!
    }
    
    // Given letter, returns the array of characters that map to it
    func getReverseMapping(letter: Character) -> Array<Character> {
        if self.reverseMap[letter] == nil {
            return [letter]
        }
        return self.reverseMap[letter]!
    }
}
