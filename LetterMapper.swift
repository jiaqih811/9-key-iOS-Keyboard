//
//  LetterMapper.swift
//  nineKeyKeyboard
//

import Foundation

class LetterMapper {
    var map: [Character: Character]
    init() {
        self.map = [:]
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
        for (i, element) in customMap.enumerated() {
            self.map[Character(UnicodeScalar(97 + i)!)] = element
            // NOTE: If TrieNode switches children to be an array rather 
            // than a dictionary, this will need to be chnaged to match
            // the mapping of ascii to the array
        }
    }
    init(customMap: Array<Int>) {
        self.map = [:]
        for (i, element) in customMap.enumerated() {
            self.map[Character(UnicodeScalar(97 + i)!)] = Character(UnicodeScalar(48 + element)!)
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
}
