//
//  trieNode.swift
//  nineKeyKeyboard
//

import Foundation

class TrieNode {
    var children = [Character:TrieNode]()
    var key = ""
    var words = Array<String>()
    var isWord = false
    // Add word frequencies for future
    init(){
        
    }
    init(keyIn:String) {
        self.key = keyIn
    }
    
}
