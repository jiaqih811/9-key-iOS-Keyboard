//
//  DictionaryQuery.swift
//  nineKeyKeyboard
//
import Foundation

class DictionaryQuery {
    typealias pair = (word:String, frequency:Int)
    
    var root = TrieNode()
    var map: LetterMapper
    var path = ""
    var numSymbols = 26
    
    init() {
        self.map = LetterMapper()
        self.root.setNumChildren(length: self.numSymbols)
    }
    // Initialize with a custom mapping and file
    init(customMap:Array<Int>, fileName:String? = nil) {
        self.map = LetterMapper(customMap: customMap)
        var dict = [Int:Int]()
        var count = 0
        for value in customMap {
            if dict[value] == nil {
                count += 1
                dict[value] = 1
            }
        }
        if count < 10 {
            count = 10
        }
        self.numSymbols = count
        self.root.setNumChildren(length: self.numSymbols)
        if fileName != nil {
            self.loadDictionary(fileName: fileName!)
        }
    }
    init(customMap:Array<Character>, fileName:String? = nil) {
        self.map = LetterMapper(customMap: customMap)
        var dict = [Character:Int]()
        var count = 0
        for value in customMap {
            if dict[value] == nil {
                count += 1
                dict[value] = 1
            }
        }
        if count < 10 {
            count = 10
        }
        self.numSymbols = count
        self.root.setNumChildren(length: self.numSymbols)
        if fileName != nil {
            self.loadDictionary(fileName: fileName!)
        }
    }
    
    // Loads the specified file and adds its contents to the trie
    // Words are newline separated
    func loadDictionary(fileName:String) {
        // Expand file path
        self.path = NSString(string: fileName).expandingTildeInPath
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: self.path){
            // Read contents of file
            let content = fileManager.contents(atPath: self.path)
            let newStr = String(data: content!, encoding: .utf8)
            // Split into word/freq pairs
            let lines = newStr!.components(separatedBy: "\n")
            // Add to dictionary
            for line in lines {
                if line.characters.count == 0 {
                    break
                }
                let lineInfo = line.components(separatedBy: ",")
                addWord(word: lineInfo[0], frequency: Int(lineInfo[1])!)
            }
        }
        else {
            print("Could not find file")
        }
        print("Load finish")
    }
    
    // Adds the given word to the dictionary trie
    func addWord(word:String, frequency:Int) {
        if word.characters.count == 0 {
            return
        }
        var newWord = word.lowercased()
        var node = root
        var stringSoFar = ""
        var numPunctuation = 0
        for (index, char) in newWord.characters.enumerated() {
            // Ignore punctuation
            if !( (char >= "0" && char <= "9") || (char >= "a" && char <= "z") ) {
                // TODO special case if last character is a punctuation ie poke' or something
                if index == newWord.characters.count - 1 {
                    node.words.append((word: newWord, frequency: frequency))
                }
                numPunctuation += 1
                continue
            }
            let index = map.getMapping(letter: char)
            stringSoFar += String(char)
            
            // A node exists for the letter
            if node.children[index].initialized == false {
                node.children[index].setKey(keyIn: stringSoFar)
                node.children[index].setNumChildren(length: numSymbols)
            }
            node = node.children[index]
            
            // TODO if stringsofar == newWord
            if stringSoFar.characters.count + numPunctuation == newWord.characters.count {
                var duplicate = false
                // Duplicate checking / frequency incrementing
                //            let temp = node.words.map{$0.word}
                for i in 0..<node.words.count {
                    
                    if node.words[i].word == newWord {
                        node.words[i].frequency += frequency
                        duplicate = true
                        break
                    }
                }
                if !duplicate {
                    node.words.append((word: newWord, frequency: frequency))
                }
            }
            
        }
        node.isWord = true
    }
    
    // Constructs an array of the words in a node
    func getWordsFromNode(node:TrieNode) -> Array<String> {
        var words = [String]()
        for pair in node.words {
            words.append(pair.word)
        }
        return words
        
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
    func getWord(sequence:String, numResults:Int? = 0) -> Array<String> {
        if sequence.characters.count == 0 {
            return []
        }
        
        var node = root
        var result = [String]()
        // On single key press, list the single characters first
        if sequence.characters.count == 1 {
            if sequence >= "0" && sequence <= "9" {
                let charArr = map.getReverseMapping(num: Int(String(sequence.characters.first!))!)
                for char in charArr {
                    result.append(String(char))
                }
            }
                // This is the case where a letter itself is passed in
                // Don't need to find other letters it may represent
            else {
                result.append(String(sequence))
            }
        }
        // Traverse the trie and get the list of words
        for char in sequence.characters {
            // Ignore punctuation
            if !( (char >= "0" && char <= "9") || (char >= "a" && char <= "z") ) {
                continue
            }
            
            let index = map.getMapping(letter: char)
            if node.children[index].initialized == false {
                // No matches
                return []
            }
            node = node.children[index]
        }
        
        // TODO add recursive call somewhere in here
        
        //        if numResults! > 0 {
        //            let numWords = node.words.count
        //            if numResults! < numWords {
        ////                let temp = Array(node.words.map { $0.word } [0..<(numResults!)])
        //                let temp = Array( getWordsFromNode(node: node) [0..<(numResults!)])
        //                result.append(contentsOf: temp)
        //                return result
        //            }
        //        }
        ////        result.append(contentsOf: node.words.map{$0.word})
        //        result.append(contentsOf: getWordsFromNode(node: node))
        //        return result
        
        var pairResult = getChildWords(node: node)
        pairResult.sort { $0.frequency > $1.frequency }
        if numResults! > 0 {
            let numWords = pairResult.count
            if numResults! < numWords {
                //  let temp = Array(node.words.map { $0.word } [0..<(numResults!)])
                let temp = Array( pairResult.map {$0.word } [0..<(numResults!)])
                result.append(contentsOf: temp)
                return result
            }
        }
        result.append(contentsOf: pairResult.map{$0.word})
        return result
    }
    
    func getChildWords(node:TrieNode, depth:Int? = -1) -> Array<pair>{
        var words = [pair]()
        words.append(contentsOf: node.words)
        for child in node.children {
            
            // TODO: Modify recursive call if you want true BFS
            if depth! > 0 {
                words.append(contentsOf: getChildWords(node: child, depth: depth! - 1))
            }
            else if depth == -1 {
                words.append(contentsOf: getChildWords(node: child, depth: depth!))
            }
        }
        
        return words
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
            if node.children[index].initialized == false {
                return
            }
            node = node.children[index]
            
            //            let toRemove = node.words.map {$0.word}.index(of: lowerWord)
            let toRemove = getWordsFromNode(node: node).index(of: lowerWord)
            node.words.remove(at: toRemove!)
            
            // Remove the empty child node
            if node.words.count == 0 {
                parentNode.children[index] = TrieNode()
            }
            parentNode = node
        }
    }
    
    // Sorts all word lists by frequencies
    func updateFrequencies( node:TrieNode? = nil) {
        if node == nil {
            updateFrequencies(node: self.root)
        }
        else {
            node?.words.sort { $0.frequency > $1.frequency }
            for child in (node?.children)!{
                updateFrequencies(node: child)
            }
        }
    }
    
    // Increments the word count for the given word
    func updateSelectedWordCount(word:String, frequency:Int? = 1) {
        if word.characters.count == 0 {
            return
        }
        var newWord = word.lowercased()
        var node = root
        for char in newWord.characters {
            // Ignore punctuation
            if !( (char >= "0" && char <= "9") || (char >= "a" && char <= "z") ) {
                continue
            }
            let index = map.getMapping(letter: char)
            
            node = node.children[index]
            
            // Frequency incrementing
            for i in 0..<node.words.count {
                if node.words[i].word == newWord {
                    node.words[i].frequency += 1
                    break
                }
            }
            
        }
        node.isWord = true
    }
    
    // Writes the dictionary to file based on the children of the root node
    // Returns true on success and false on failure
    func exportDictionary() -> Bool {
        // TODO fix this function for update
        var newData = ""
        let wordPairs = getChildWords(node: root)
        for (word, frequency) in (wordPairs) {
            newData += word + "," + String(frequency) + "\n"
        }
        do {
            try newData.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
            return true
        }
        catch let error as NSError {
            print("Export failed")
            return false
        }
    }
}
