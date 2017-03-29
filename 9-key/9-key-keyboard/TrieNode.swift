//
//  trieNode.swift
//  nineKeyKeyboard
//
import Foundation

class TrieNode {
    typealias pair = (word:String, frequency:Int)
    //var children = [Character:TrieNode]()
    var children = [TrieNode]()
    var key = ""
    var words = Array<pair>()
    var isWord = false
    var initialized = false
    var minimumFreq = -1
    
    init(){
        
    }
    func setKey(keyIn:String){
        self.key = keyIn
        
    }
    func setNumChildren(length: Int) {
        for i in 1...length {
            self.children.append(TrieNode())
        }
        self.initialized = true
    }
    
}
