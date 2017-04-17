//
//  KeyboardViewController.swift
//  9-key-keyboard
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit

let GROUP_NAME = "group.9-key"
var words = [String]()
var current = ""
var ifNum = false
var capMode = 0 //0 for off, 1 for on, 2 for lock
var spaceMode = false
var settingMode = false
var currentSequenceLabelStr = "Input: "

//let path = "/Users/star/documents/words.txt"
//let path = Bundle.main.path(forResource: "wordFreqDict", ofType: "txt")
var dictionQuery: DictionaryQuery!
let arr = [2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9]
//let dictionQuery = DictionaryQuery(customMap: arr, fileName: path!)
let puncs = [".", ",", "?", "'", "!", "@", "_", "~", "-", "･ω･", "＞ε＜", "°Д °"]


//keyboard keys size setting
let COLLECTION_HEIGHT = 36 as! CGFloat
let COLLECTION_CELL_HEIGHT = 32 as! CGFloat
let PUNC_CELL_HEIGHT = 30 as! CGFloat
let VIEW_HEIGHT = 300 as! CGFloat
let VIEW_WIDTH = 375 as! CGFloat
let GAP = 6 as! CGFloat
let SIDE_KEY_WIDTH = 58 as! CGFloat
let KEY_HEIGHT = ( 280 - COLLECTION_HEIGHT - 5 * GAP ) / 4
let KEY_WIDTH = ( UIScreen.main.bounds.width - 6 * GAP - 2 * SIDE_KEY_WIDTH ) / 3
var FONT_SIZE = 20 as! CGFloat
var FONT_COLOR = UIColor.black



class KeyboardViewController: UIInputViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var puncCollectionView: UICollectionView!
    @IBOutlet var nextKeyboardButton: UIButton!
    
    var heightConstraint: NSLayoutConstraint!
    var nextKeyboardButtonLeftSideConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    
    @IBOutlet weak var backspaceButton: UIButton!
    
    @IBOutlet weak var numButton: UIButton!
    
    @IBOutlet weak var shiftButton: UIButton!
    
    @IBOutlet weak var spaceModeButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    
    
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    
    @IBOutlet weak var fontSizeButton1: UIButton!
    @IBOutlet weak var fontSizeButton2: UIButton!
    @IBOutlet weak var fontSizeButton3: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    @IBOutlet weak var currentSequenceLabel: UILabel!
    
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
        //self.view.backgroundColor = UIColor(red: 239/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 214/255.0, green: 216/255.0, blue: 220/255.0, alpha: 1.0) //sogo
        
        
        
        // Add custom view sizing constraints here
        
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }
        
        setUpHeightConstraint()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ifNum = false
        capMode = 0
        spaceMode = true
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("🌐", comment: "Title for 'Next Keyboard' button"), for: [])
        //self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        //self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        //self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.nextKeyboardButton.frame = CGRect(x: GAP, y: VIEW_HEIGHT - GAP - KEY_HEIGHT, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
        puncCollectionView.frame = CGRect(x: GAP, y: GAP + COLLECTION_HEIGHT, width: SIDE_KEY_WIDTH, height: 3 * KEY_HEIGHT + 2 * GAP)
        
        button1.frame = CGRect(x: GAP + SIDE_KEY_WIDTH + GAP, y: GAP + COLLECTION_HEIGHT, width: KEY_WIDTH, height: KEY_HEIGHT)
        button2.frame = CGRect(x: button1.frame.maxX + GAP, y: button1.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        button3.frame = CGRect(x: button2.frame.maxX + GAP, y: button1.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        
        button4.frame = CGRect(x: button1.frame.minX, y: button1.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        button5.frame = CGRect(x: button4.frame.maxX + GAP, y: button4.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        button6.frame = CGRect(x: button5.frame.maxX + GAP, y: button4.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        button7.frame = CGRect(x: button4.frame.minX, y: button4.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        button8.frame = CGRect(x: button7.frame.maxX + GAP, y: button7.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        button9.frame = CGRect(x: button8.frame.maxX + GAP, y: button7.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        button0.frame = CGRect(x: button8.frame.minX, y: button8.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        numButton.frame = CGRect(x: button7.frame.minX, y: button0.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        shiftButton.frame = CGRect(x: button9.frame.minX, y: button0.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        backspaceButton.frame = CGRect(x: button3.frame.maxX + GAP, y: button1.frame.minY, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
        spaceModeButton.frame = CGRect(x: backspaceButton.frame.minX, y: button6.frame.minY, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
        moreButton.frame = CGRect(x: spaceModeButton.frame.minX, y: button9.frame.minY, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
        sendButton.frame = CGRect(x: spaceModeButton.frame.minX, y: shiftButton.frame.minY, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)

        
        //set button background color
        makeRoundCorners()
        backspaceButton.layer.backgroundColor = UIColor(red: 168/255.0, green: 177/255.0, blue: 189/255.0, alpha: 1.0).cgColor //gray
        spaceModeButton.layer.backgroundColor = UIColor(red: 168/255.0, green: 177/255.0, blue: 189/255.0, alpha: 1.0).cgColor //gray
        moreButton.layer.backgroundColor = UIColor(red: 168/255.0, green: 177/255.0, blue: 189/255.0, alpha: 1.0).cgColor //gray
        shiftButton.layer.backgroundColor = UIColor(red: 168/255.0, green: 177/255.0, blue: 189/255.0, alpha: 1.0).cgColor //gray
        numButton.layer.backgroundColor = UIColor(red: 168/255.0, green: 177/255.0, blue: 189/255.0, alpha: 1.0).cgColor //gray
        
        sendButton.layer.backgroundColor = UIColor(red: 18/255.0, green: 106/255.0, blue: 255/255.0, alpha: 1.0).cgColor //blue

        
        
        
        collectionView.layer.borderWidth = 0.8
        collectionView.layer.borderColor = UIColor(red: 239/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0).cgColor
        
        
        shiftButton.setTitle("Caps Off", for: .normal)
        //shiftButton.setTitleColor(.orange, for: .normal)
        
        numButton.setTitle("123", for: .normal)
        button0.setTitle("▁▁", for: .normal)
        
        sendButton.setTitle("Send", for: .normal)
        moreButton.setTitle("Setting", for: .normal)
        
        
        
        spaceModeButton.titleLabel?.numberOfLines = 2
        
        //spaceModeButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        var str = NSMutableAttributedString(string: "Auto\nSpace")
        //let myAttribute = [ NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)! ]
        str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 4))
        str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(5, 5))
        spaceModeButton.setAttributedTitle(str, for: .normal)
        
        
        let userDefaults = UserDefaults(suiteName: GROUP_NAME)
        let dictName = userDefaults?.object(forKey: "cur_file_name") as! String
        let queryName = userDefaults?.object(forKey: "cur_query_name") as! String
        if dictName != queryName || dictionQuery == nil{
            let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: GROUP_NAME)?.appendingPathComponent(dictName).path
            dictionQuery = DictionaryQuery(customMap: arr, fileName: path!)
            userDefaults!.set(dictName, forKey: "cur_query_name")
            userDefaults!.synchronize()
        }

        
        
        words = dictionQuery.getWord(sequence: "2")
        
        words = []
        
        ifNum = false
        setButtonStyle()
        switchView()
        
        currentSequenceLabel.backgroundColor = UIColor.white
        currentSequenceLabel.text = currentSequenceLabelStr
        
        print("key width = \(KEY_WIDTH)")
        
        print("view loaded")
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Set up constraints for next keyboard button in view did appear
        
        
        
        let nextKeyboardWidthConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: SIDE_KEY_WIDTH)
        let nextKeyboardHeightConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: KEY_HEIGHT)
        
        view.addConstraints([nextKeyboardWidthConstraint,nextKeyboardHeightConstraint])
        
        
        if nextKeyboardButtonLeftSideConstraint == nil {
            nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .left,
                relatedBy: .equal,
                toItem: view,
                attribute: .left,
                multiplier: 1.0,
                constant: GAP)
            let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1.0,
                constant: -(GAP+20))
            view.addConstraints([
                nextKeyboardButtonLeftSideConstraint,
                nextKeyboardButtonBottomConstraint])
        }
        
        self.nextKeyboardButton.frame = CGRect(x: GAP, y: VIEW_HEIGHT - GAP - KEY_HEIGHT, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    
    //setting the round corner apperance
    func makeRoundCorners() {
        for button in self.view.subviews {
            if button is UIButton {
                (button as! UIButton).backgroundColor = UIColor.white
                button.layer.cornerRadius = 6
                button.layer.masksToBounds = true
                
            }
        }
        self.puncCollectionView.layer.cornerRadius = 6
        self.puncCollectionView.layer.masksToBounds = true
        
    }
    
    
    func setUpHeightConstraint()
    {
        let customHeight = VIEW_HEIGHT * (UIScreen.main.bounds.height) / 667 //bound = 667
        //let customHeight = self.view.frame.size.height
        
        print("hhhhhhhhhhhhhhhhhhhhhhhhh")
        print("\(customHeight)")
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: customHeight)
            heightConstraint.priority = UILayoutPriority(UILayoutPriorityRequired)
            
            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = customHeight
        }
    }
    
    @IBAction func backspace(_ sender: Any) {
        if(current == "") {
            let proxy = self.textDocumentProxy
            proxy.deleteBackward()
        } else {
            current = String(current.characters.dropLast())
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
            
        }
    }
    
    @IBAction func press1(_ sender: Any) {
        self.textDocumentProxy.insertText("1")
    }
    
    @IBAction func press2(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("2")
        }
        else {
            current += "2"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func press3(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("3")
        }
        else {
            current += "3"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func press4(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("4")
        }
        else {
            current += "4"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func press5(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("5")
        }
        else {
            current += "5"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    @IBAction func press6(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("6")
        }
        else {
            current += "6"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    @IBAction func press7(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("7")
        }
        else {
            current += "7"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    @IBAction func press8(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("8")
        }
        else {
            current += "8"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    @IBAction func press9(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("9")
        }
        else {
            current += "9"
            print(current)
            words = dictionQuery.getWord(sequence: current)
            if(words.count == 0) {words.append(current)}
            makeCurrentUpper(capMode: capMode)
            print(words)
            currentSequenceLabel.text = currentSequenceLabelStr + current
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func press0(_ sender: Any) {
        if(ifNum) {
            self.textDocumentProxy.insertText("0")
        }
        else {
            let proxy = self.textDocumentProxy
            proxy.insertText(" ")
        }
    }
    
    @IBAction func pressNum(_ sender: Any) {
        if (ifNum) {
            //in number mode
//            button0.setTitle("▁▁", for: .normal)
//            button2.setTitle("ABC", for: .normal)
//            button3.setTitle("DEF", for: .normal)
//            button4.setTitle("GHI", for: .normal)
//            button5.setTitle("JKL", for: .normal)
//            button6.setTitle("MNO", for: .normal)
//            button7.setTitle("PQRS", for: .normal)
//            button8.setTitle("TUV", for: .normal)
//            button9.setTitle("WXYZ", for: .normal)
            ifNum = false
            setButtonStyle()
            
        }
        else{
            //in letter mode
//            button0.setTitle("0", for: .normal)
//            button2.setTitle("2", for: .normal)
//            button3.setTitle("3", for: .normal)
//            button4.setTitle("4", for: .normal)
//            button5.setTitle("5", for: .normal)
//            button6.setTitle("6", for: .normal)
//            button7.setTitle("7", for: .normal)
//            button8.setTitle("8", for: .normal)
//            button9.setTitle("9", for: .normal)
            ifNum = true
            setButtonStyle()
            
        }
        

    }
    
   
    
    
    @IBAction func pressShift(_ sender: Any) {
        if(capMode == 0) {
            //in captial off, then turn on
            //shiftButton.setTitleColor(.blue, for: .normal)
            shiftButton.setTitle("Caps On", for: .normal)
            capMode = 1
        }
        else if (capMode == 1) {
            //in cap on, then make lock
            //shiftButton.setTitleColor(.red, for: .normal)
            shiftButton.setTitle("Caps lock", for: .normal)
            capMode = 2
        }
        else {
            //in caps lock mode, then turn off
            shiftButton.setTitle("Caps Off", for: .normal)
            capMode = 0
        }
    }
    @IBAction func pressSpaceMode(_ sender: Any) {
        if(spaceMode) {
            var str = NSMutableAttributedString(string: "Manul\nSpace")
            //let myAttribute = [ NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)! ]
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 5))
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(6, 5))
            spaceModeButton.setAttributedTitle(str, for: .normal)
            spaceMode = false
        } else {
            var str = NSMutableAttributedString(string: "Auto\nSpace")
            //let myAttribute = [ NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)! ]
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 4))
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(5, 5))
            spaceModeButton.setAttributedTitle(str, for: .normal)
            spaceMode = true
        }
        
        
    }
    
    func makeCurrentUpper(capMode: Int) {
        
        for i in 0...words.count - 1 {
            
            if(capMode == 1) {
                if(words[i].characters.count <= 1) {
                    words[i] = words[i].uppercased()
                }
                else {
                    var current = words[i]
                    current.replaceSubrange(current.startIndex...current.startIndex, with: String(current[current.startIndex]).capitalized)
                    //print("current = \(current)")
                    
                    words[i] = current
                }
            }
            
            if(capMode == 2) {
                words[i] = words[i].uppercased()
            }
            
        }//for
        
    }//makeRound
    
    func setButtonStyle() {
        
        var string0 = "0"
        if(ifNum) {
            string0 = "0"
        } else {
            string0 = "▁▁"
        }

        var str0 = NSMutableAttributedString(string: string0)
        str0.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string0.characters.count))
        str0.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string0.characters.count))
        button0.setAttributedTitle(str0, for: .normal)
        
        var str1 = NSMutableAttributedString(string: "1")
        str1.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, 1))
        str1.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, 1))
        button1.setAttributedTitle(str1, for: .normal)
        
        
        var string2 = "2"
        if(ifNum) {
            string2 = "2"
        } else {
            string2 = "ABC"
        }
        var str2 = NSMutableAttributedString(string: string2)
        str2.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string2.characters.count))
        str2.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string2.characters.count))
        button2.setAttributedTitle(str2, for: .normal)
        
        
        var string3 = "3"
        if(ifNum) {
            string3 = "3"
        } else {
            string3 = "DEF"
        }
        var str3 = NSMutableAttributedString(string: string3)
        str3.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string3.characters.count))
        str3.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string3.characters.count))
        button3.setAttributedTitle(str3, for: .normal)
        
        
        var string4 = "4"
        if(ifNum) {
            string4 = "4"
        } else {
            string4 = "GHI"
        }
        var str4 = NSMutableAttributedString(string: string4)
        str4.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string4.characters.count))
        str4.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string4.characters.count))
        button4.setAttributedTitle(str4, for: .normal)
        
        var string5 = "5"
        if(ifNum) {
            string5 = "5"
        } else {
            string5 = "JKL"
        }
        var str5 = NSMutableAttributedString(string: string5)
        str5.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string5.characters.count))
        str5.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string5.characters.count))
        button5.setAttributedTitle(str5, for: .normal)
        
        
        var string6 = "6"
        if(ifNum) {
            string6 = "6"
        } else {
            string6 = "MNO"
        }
        var str6 = NSMutableAttributedString(string: string6)
        str6.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string6.characters.count))
        str6.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string6.characters.count))
        button6.setAttributedTitle(str6, for: .normal)
        
        
        var string7 = "7"
        if(ifNum) {
            string7 = "7"
        } else {
            string7 = "PQRS"
        }
        var str7 = NSMutableAttributedString(string: string7)
        str7.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string7.characters.count))
        str7.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string7.characters.count))
        button7.setAttributedTitle(str7, for: .normal)
        
        var string8 = "8"
        if(ifNum) {
            string8 = "8"
        } else {
            string8 = "TUV"
        }
        var str8 = NSMutableAttributedString(string: string8)
        str8.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string8.characters.count))
        str8.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string8.characters.count))
        button8.setAttributedTitle(str8, for: .normal)
        
        var string9 = "9"
        if(ifNum) {
            string9 = "9"
        } else {
            string9 = "WXYZ"
        }
        var str9 = NSMutableAttributedString(string: string9)
        str9.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONT_SIZE), range: NSMakeRange(0, string9.characters.count))
        str9.addAttribute(NSForegroundColorAttributeName, value: FONT_COLOR , range: NSMakeRange(0, string9.characters.count))
        button9.setAttributedTitle(str9, for: .normal)
        
        
        
        button0.backgroundColor = UIColor.white
        
    }//setStyle
    
    
    @IBAction func pressSetting(_ sender: Any) {
        settingMode = true
        self.view.backgroundColor = UIColor.white
        switchView()
    }
    
    @IBAction func pressConfirm(_ sender: Any) {
        settingMode = false
        self.view.backgroundColor = UIColor(red: 214/255.0, green: 216/255.0, blue: 220/255.0, alpha: 1.0) //sogo
        switchView()
    }
    
    @IBAction func pressFontSize1(_ sender: Any) {
        FONT_SIZE = 14
        setButtonStyle()
    }
    
    @IBAction func pressFontSize2(_ sender: Any) {
        FONT_SIZE = 20
        setButtonStyle()
    }
    
    @IBAction func pressFontSize3(_ sender: Any) {
        FONT_SIZE = 25
        setButtonStyle()
    }
    
    

    func switchView() {
        for view in self.view.subviews {
            view.isHidden = false
        }
        if(settingMode) {
            button0.isHidden = true
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            button4.isHidden = true
            button5.isHidden = true
            button6.isHidden = true
            button7.isHidden = true
            button8.isHidden = true
            button9.isHidden = true
            
            numButton.isHidden = true
            shiftButton.isHidden = true
            puncCollectionView.isHidden = true
            nextKeyboardButton.isHidden = true
            
            backspaceButton.isHidden = true
            spaceModeButton.isHidden = true
            moreButton.isHidden = true
            sendButton.isHidden = true
            
            collectionView.isHidden = true
            
            currentSequenceLabel.isHidden = true
            
            
            
        } else {
            //normal mode
            
            fontSizeLabel.isHidden = true
            fontSizeButton1.isHidden = true
            fontSizeButton2.isHidden = true
            fontSizeButton3.isHidden = true
            
            confirmButton.isHidden = true
            
        }
        
    }//switch view
    
    
} //class KeyboardViewController:

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == self.collectionView){
            return words.count
        }
        else {
            return puncs.count
        }
        
    }
    
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    //        if(collectionView == self.collectionView){
    //            let frame = CGRectFromString(current)
    //
    //            return CGSize(width: frame.width, height: frame.height)
    //        }
    //        else {
    //            let frame = CGRectFromString(current)
    //            return CGSize(width: frame.width, height: frame.height)
    //        }
    //
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            var label = cell.viewWithTag(1) as! UILabel
            
            label.text = words[indexPath.row]
            label.textAlignment = .center
            label.sizeToFit()
            
            let strCount = label.text?.characters.count
            
            
            
            cell.sizeToFit()
//            print("label width = \(label.frame.width)")
//            print("cell width = \(cell.frame.width)")
//            print("char width = \(strCount! * 30)")
            
            
            
            //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width, height: COLLECTION_CELL_HEIGHT)
            //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: CGFloat(strCount! * 30), height: COLLECTION_CELL_HEIGHT)
            
            //cell.frame.size = CGSize(width: label.frame.width, height: COLLECTION_CELL_HEIGHT)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puncCell", for: indexPath)
            
            
            var label = cell.viewWithTag(2) as! UILabel
            
            label.text = puncs[indexPath.row]
            label.textAlignment = .center
            //label.sizeToFit()
            
            
            
            
            //            //customize cell's width and hight
            //            cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width, height: PUNC_CELL_HEIGHT)
            //
            
            //make bottom border of cell
            let border = CALayer()
            let width = CGFloat(0.3)
            border.borderColor = UIColor.darkGray.cgColor
            border.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
            
            border.borderWidth = width
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            
            return cell
        }
        
        //let frame = CGRectFromString(label.text!)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(collectionView == self.collectionView){
            print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
            
            
            let proxy = self.textDocumentProxy
            proxy.insertText("\(words[indexPath.row])")
            if(spaceMode) {self.textDocumentProxy.insertText(" ")}
            dictionQuery.updateSelectedWordCount(word: words[indexPath.row])
            self.collectionView.reloadData()
            current = ""
            words = []
        }
        else {
            print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
            
            
            let proxy = self.textDocumentProxy
            proxy.insertText("\(puncs[indexPath.row])")
            self.collectionView.reloadData()
            
        }
    }
}

