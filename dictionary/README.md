Usage of DictionaryQuery:

Initialization:

    init(customMap:Array<Int>) / init(customMap:Array<Character>): 
    Makes a trie that will have follow the mapping specified.
    customMap should be an array where index 0 corresponds to that 'a' should have in the trie.
    
    Ex.         a  b  c  d  e  f  g  h
    customMap: [2, 2, 2, 3, 3, 4, 4, 4, ... ]

    A dictionary file may also be specified in the second parameter to load the dictionary at initialization

Loading a dictionary:

    loadDictionary(fileName:String):
    Attempts to load the file specified as a dictionary.
    File must be located in the documents folder (for now)
    File should contain one word or dictionary entry per line



Adding/removing words to dictionary:

    addWord(word:String): Adds word to the dictionary trie
    removeWord(word:String): Removes word from the dictionary trie

Retriving possible words:

    getWord(sequence:String, numResults:Int? = 0):
    Returns an array of strings that match the sequence given.
    numResults is optional. If specified, it will limit the number of results returned.
