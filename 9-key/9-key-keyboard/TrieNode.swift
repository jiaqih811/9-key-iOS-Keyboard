//
//  trieNode.swift
//  nineKeyKeyboard
//
import Foundation

class TrieNode {
    typealias pair = (word:String, frequency:Int)
    var children = [Character:TrieNode]()
    var key = ""
    var words = Array<pair>()
    var isWord = false
    // Add word frequencies for future
    init(){
        
    }
    init(keyIn:String) {
        self.key = keyIn
    }
    
}
