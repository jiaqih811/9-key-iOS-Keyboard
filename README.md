# 9-Key-iOS-Keyboard
This project is a custom T9 layout English keyboard for iOS device. We also provide profile system for users to set their own profiles and dictionaries. User can login and manage their own profiles.
#### Note:
Since the profile system part in our app uses some functions and setup which will need our developer account's authorization, you may not build this part on your local device. If you want to see the demonstration of the whole app, please come to see us. We are happy to install it for you. 
So here we just remove the profile part. You can build the keyboard on your local device without profile part. 

## Build instruction ##
Please download the project and open 9-key.xcodeproj to launch the Xcode project.
You can choose to use a simulator or your iOS device to run the project.
### Simulator setting: ###
At top of  Xcode, you can set active scheme and choose device type as shown below.
![setScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/setScheme.png)
Please choose 9-key and select your simulator type, we recommend to use devices later than iPhone6.
Then click build button. A simulator window should be automatically launched after 9-key scheme is built sucessfully. 
Now we need to build the keyboard extension. Please switch the scheme to 9-key-keyboard as shown below.
![switchScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/switchScheme.png)
Then click build to build 9-key-keyboard.
After everything is built sucessfully, please do the follwing setting in your simulator to launch the keyboard.
  - Press [shift + command + H] button which acts as the [Home] button on iPhone
  - GO to Settings -> General -> Keyboard -> Keyboards -> Add New Keyboard -> 9-key
  - Press [shift + command + H] and lauch 9-key app
  - Press the text field and press 🌐 button to switch to the 9-key keyboard (the first time you switch to 9-key keyboard may take some time to load the dictionary)
  - Finish! Enjoy the 9-key keyboard.
  - If you meet and problem during the setting, please contact me.
  
### Build on iPhone setting:
Connect your iPhone to your computer and unlock your iPhone. Launch 9-key.xcodeproj. 
At top of  Xcode, you can set active scheme and choose device type as shown below.
![setScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/setScheme.png)
Please choose 9-key and select your iPhone, we recommend to use devices later then iPhone6.
Then click build button. Note that the first time you build on your iPhone, Xcode may show a warning saying "Could not launch 9-key", which means you need to verify the Developer App certificate on your iPhone. You can veryfy by :
Go to your iPhone -> Settings -> General -> Profiles & Device Management -> corresponding developer account -> Trust.
Now we need to build the keyboard extension. Please switch the scheme to 9-key-keyboard as shown below.
![switchScheme](https://raw.githubusercontent.com/Jiaqi-Huang/9-key-iOS-Keyboard/master/settingImages/switchScheme.png)
Then click build to build 9-key-keyboard.
After everything is built sucessfully, please do the follwing setting in your iPhone to launch the keyboard.
  - Lauch 9-key app
  - Press the text field and press 🌐 button to switch to the 9-key keyboard (the first time you switch to 9-key keyboard may take some time to load the dictionary)
  - Finish! Enjoy the 9-key keyboard.
  - If you meet any problem during the setting, please contact me.
 
## Backend implementation detail
DictionaryQuery implements a trie to look up words that match a given sequence of letters or numbers.
It allows users to give a custom mapping of letters to characters which is used for hte 9-key keyboard.
Words in DictionaryQuery are based off of a text file given by the user.

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

Dictionary sources:

    http://www-01.sil.org/linguistics/wordlists/english/
    https://github.com/dwyl/english-words


