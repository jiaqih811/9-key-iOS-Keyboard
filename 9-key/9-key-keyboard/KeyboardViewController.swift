//
//  KeyboardViewController.swift
//  9-key-keyboard
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit


var words = [String]()
var current = ""
var ifNum = false
var capMode = 0 //0 for off, 1 for on, 2 for lock
var spaceMode = false

//let path = "/Users/star/documents/words.txt"
let path = Bundle.main.path(forResource: "wordFreqDict", ofType: "txt")

let arr = [2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9]
let dictionQuery = DictionaryQuery(customMap: arr, fileName: path!)
let puncs = [".", ",", "?", "'", "!", "@", "_", "~", "-", "･ω･", "＞ε＜", "°Д °"]


//keyboard keys size setting
let COLLECTION_HEIGHT = 36 as! CGFloat
let COLLECTION_CELL_HEIGHT = 32 as! CGFloat
let PUNC_CELL_HEIGHT = 30 as! CGFloat
let VIEW_HEIGHT = 280 as! CGFloat
let VIEW_WIDTH = 375 as! CGFloat
let GAP = 6 as! CGFloat
let SIDE_KEY_WIDTH = 58 as! CGFloat
let KEY_HEIGHT = ( VIEW_HEIGHT - COLLECTION_HEIGHT - 5 * GAP ) / 4
let KEY_WIDTH = ( UIScreen.main.bounds.width - 6 * GAP - 2 * SIDE_KEY_WIDTH ) / 3



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
        moreButton.setTitle("More", for: .normal)
        
        
        
        spaceModeButton.titleLabel?.numberOfLines = 2
        
        //spaceModeButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        var str = NSMutableAttributedString(string: "Auto\nSpace")
        //let myAttribute = [ NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)! ]
        str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 4))
        str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(5, 5))
        spaceModeButton.setAttributedTitle(str, for: .normal)
        
        
        words = dictionQuery.getWord(sequence: "2")
        
        words = []
        
        
        
        
        
        
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
                constant: -GAP)
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
        let customHeight = 280 * (UIScreen.main.bounds.height) / 667 //bound = 667
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
            button0.setTitle("▁▁", for: .normal)
            button2.setTitle("ABC", for: .normal)
            button3.setTitle("DEF", for: .normal)
            button4.setTitle("GHI", for: .normal)
            button5.setTitle("JKL", for: .normal)
            button6.setTitle("MNO", for: .normal)
            button7.setTitle("PQRS", for: .normal)
            button8.setTitle("TUV", for: .normal)
            button9.setTitle("WXYZ", for: .normal)
            ifNum = false
        }
        else{
            //in letter mode
            button0.setTitle("0", for: .normal)
            button2.setTitle("2", for: .normal)
            button3.setTitle("3", for: .normal)
            button4.setTitle("4", for: .normal)
            button5.setTitle("5", for: .normal)
            button6.setTitle("6", for: .normal)
            button7.setTitle("7", for: .normal)
            button8.setTitle("8", for: .normal)
            button9.setTitle("9", for: .normal)
            ifNum = true
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
        
    }
    
    
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

