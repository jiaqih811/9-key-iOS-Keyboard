//
//  DictionaryQuery.swift
//  nineKeyKeyboard
//

import Foundation

class DictionaryQuery {
    
    var root = TrieNode()
    var map: LetterMapper
    
    
    init() {
        self.map = LetterMapper()
    }
    // Custom mapping for letters
    init(customMap:Array<Int>) {
        self.map = LetterMapper(customMap: customMap)
    }
    init(customMap:Array<Character>) {
        self.map = LetterMapper(customMap: customMap)
    }
    init(customMap:Array<Int>, fileName:String) {
        self.map = LetterMapper(customMap: customMap)
        self.loadDictionary(fileName: fileName)
    }
    init(customMap:Array<Character>, fileName:String) {
        self.map = LetterMapper(customMap: customMap)
        self.loadDictionary(fileName: fileName)
    }
    
    
    // Loads the specified file and adds its contents to the trie
    // Words are newline separated
    
    func loadDictionary(fileName:String) {
        /*if let dir = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first {
            let path = dir.appendingPathComponent(fileName)
            do {
                let contents = try String(contentsOf: path)
                let lines = contents.components(separatedBy: "\n")
                for line in lines {
                    addWord(word: line)
                }
            }
            catch{
                print("Failed to load dictionary")
            }
        }
        else {
            print("Could not find file")
        }*/
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileName){
            let content = fileManager.contents(atPath: fileName)
            let newStr = String(data: content!, encoding: .utf8)
            let lines = newStr!.components(separatedBy: "\n")
            for line in lines {
                addWord(word: line)
            }
        }
        else {
            print("Could not find file")
        }
    }
    
    // Adds the given word to the dictionary trie
    func addWord(word:String) {
        if word.characters.count == 0 {
            return
        }
        var newWord = word.lowercased()
        var node = root
        var stringSoFar = ""
        for (i, char) in newWord.characters.enumerated() {
            let index = map.getMapping(letter: char)
            stringSoFar += String(char)
            // A node exists for the letter
            if node.children[index] == nil {
                node.children[index] = TrieNode(keyIn: stringSoFar)
            }
            node = node.children[index]!
            
            // Duplicate checking
            /*if node.words.contains(newWord) {
                // TODO: Future will probably use this part for word count
                return
            }*/
            
            
            // If it's a word, we want to keep it at the beginning of the list
            if i + 1 == newWord.characters.count {
                node.words.insert(newWord, at: 0)
            }
            else {
                node.words.append(newWord)
            }
        }
        node.isWord = true
        
    }
    
    // INPUTS: Sequence: String of key presses. numResults: number of results to return
    // Sequence is the sequence of key presses or characters as a string
    // Ex: "468" for "hot"
    // Currently  supports punctuation as part of the word
    // Assumes all characters are lower case
    // Returns an array of possible words
    // NOTE: Possibly add option to return the TrieNode itself
    //       so that a future query can use that TrieNode + a new character
    //       to get the next set
    func getWord(sequence:String, numResults:Int? = 0) -> Array<String>{
        if sequence.characters.count == 0 {
            return []
        }
        
        var node = root
        
        for char in sequence.characters {
            let index = map.getMapping(letter: char)
            if node.children[index] == nil {
                // No matches
                return []
            }
            node = node.children[index]!
        }
        if numResults! > 0 {
            return Array(node.words[0..<(numResults!)])
        }
        return node.words
    }
    
    // Removes a word from the trie
    func removeWord(word:String) {
        if word.characters.count == 0 {
            return
        }
        var lowerWord = word.lowercased()
        var node = root
        var parentNode = root
        for char in lowerWord.characters {
            let index = map.getMapping(letter: char)
            
            // A node exists for the letter
            if node.children[index] == nil {
                return
            }
            node = node.children[index]!
            
            let toRemove = node.words.index(of: lowerWord)
            node.words.remove(at: toRemove!)
            // Remove the empty child node
            if node.words.count == 0 {
                parentNode.children[char] = nil
            }
            parentNode = node
        }
    }
}
