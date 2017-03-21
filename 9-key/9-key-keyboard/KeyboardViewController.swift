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


//let path = "/Users/star/documents/words.txt"
let path = Bundle.main.path(forResource: "commonWords", ofType: "txt")

let arr = [2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9]
let dictionQuery = DictionaryQuery(customMap: arr, fileName: path!)
let puncs = [".", ",", "?", "'", "!", "@", "_", "-"]


//keyboard keys size setting
let COLLECTION_HEIGHT = 36 as! CGFloat
let COLLECTION_CELL_HEIGHT = 32 as! CGFloat
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
        
        self.puncCollectionView.frame = CGRect(x: GAP, y: GAP + COLLECTION_HEIGHT, width: SIDE_KEY_WIDTH, height: 3 * KEY_HEIGHT + 2 * GAP)
        
        self.button1.frame = CGRect(x: GAP + SIDE_KEY_WIDTH + GAP, y: GAP + COLLECTION_HEIGHT, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button2.frame = CGRect(x: self.button1.frame.maxX + GAP, y: self.button1.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button3.frame = CGRect(x: self.button2.frame.maxX + GAP, y: self.button1.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        
        self.button4.frame = CGRect(x: self.button1.frame.minX, y: self.button1.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button5.frame = CGRect(x: self.button4.frame.maxX + GAP, y: self.button4.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button6.frame = CGRect(x: self.button5.frame.maxX + GAP, y: self.button4.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        self.button7.frame = CGRect(x: self.button4.frame.minX, y: self.button4.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button8.frame = CGRect(x: self.button7.frame.maxX + GAP, y: self.button7.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        self.button9.frame = CGRect(x: self.button8.frame.maxX + GAP, y: self.button7.frame.minY, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        self.button0.frame = CGRect(x: self.button8.frame.minX, y: self.button8.frame.maxY + GAP, width: KEY_WIDTH, height: KEY_HEIGHT)
        
        self.backspaceButton.frame = CGRect(x: self.button3.frame.maxX + GAP, y: self.button1.frame.minY, width: SIDE_KEY_WIDTH, height: KEY_HEIGHT)
        
        
        collectionView.layer.borderWidth = 0.8
        collectionView.layer.borderColor = UIColor(red: 239/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0).cgColor
        
        
        
        
        words = dictionQuery.getWord(sequence: "2")
        
        words = []
        
        makeRoundCorners()
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
            print(words)
            self.collectionView.reloadData()
            
        }
    }
    
    @IBAction func press2(_ sender: Any) {
        current += "2"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press3(_ sender: Any) {
        current += "3"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press4(_ sender: Any) {
        current += "4"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press5(_ sender: Any) {
        current += "5"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press6(_ sender: Any) {
        current += "6"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press7(_ sender: Any) {
        current += "7"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press8(_ sender: Any) {
        current += "8"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press9(_ sender: Any) {
        current += "9"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        if(words.count == 0) {words.append(current)}
        print(words)
        self.collectionView.reloadData()
    }
    
    
    @IBAction func press0(_ sender: Any) {
        let proxy = self.textDocumentProxy
        proxy.insertText(" ")
    }
    
    
    
}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == self.collectionView){
            return words.count
        }
        else {
            return puncs.count
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return CGSize(width: screenWidth/3, height: screenWidth/3);
        let frame = CGRectFromString(current)
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == self.collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            var label = cell.viewWithTag(1) as! UILabel
            
            label.text = words[indexPath.row]
            label.sizeToFit()
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puncCell", for: indexPath)
            
            
            var label = cell.viewWithTag(2) as! UILabel
            
            label.text = puncs[indexPath.row]
            label.textAlignment = .center
            label.sizeToFit()
            
            
            
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
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(collectionView == self.collectionView) {
            let section = indexPath.section
            let row = indexPath.row
            //        if section == 0 && row == 2{
            //            return 50.0
            //        }
            return COLLECTION_CELL_HEIGHT
        }
        else {
            let section = indexPath.section
            let row = indexPath.row
            //        if section == 0 && row == 2{
            //            return 50.0
            //        }
            return 40.0
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(collectionView == self.collectionView){
            print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
            
            
            let proxy = self.textDocumentProxy
            proxy.insertText("\(words[indexPath.row])")
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

