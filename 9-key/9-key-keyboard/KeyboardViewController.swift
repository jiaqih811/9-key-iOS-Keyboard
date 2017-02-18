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


let path = "/Users/star/documents/words.txt"
let arr = [2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9]
let dictionQuery = DictionaryQuery(customMap: arr, fileName: path)


class KeyboardViewController: UIInputViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        self.view.backgroundColor = UIColor.yellow
        
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
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        

        
        words = dictionQuery.getWord(sequence: "2")
        
        words = []
        
        
        print("view loaded")
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Set up constraints for next keyboard button in view did appear
        
    
        
        if nextKeyboardButtonLeftSideConstraint == nil {
            nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .left,
                relatedBy: .equal,
                toItem: view,
                attribute: .left,
                multiplier: 1.0,
                constant: 0.0)
            let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(
                item: nextKeyboardButton,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 0.0)
            view.addConstraints([
                nextKeyboardButtonLeftSideConstraint,
                nextKeyboardButtonBottomConstraint])
        }
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
    
    
    //setting the button apperance
    func makeRoundCorners() {
        for button in self.view.subviews {
            if button is UIButton {
                (button as! UIButton).backgroundColor = UIColor.white
                button.layer.cornerRadius = 3
                button.layer.masksToBounds = true
                
            }
        }

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
            print(words)
            self.collectionView.reloadData()
            
        }
    }
    
    @IBAction func press2(_ sender: Any) {
        current += "2"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press3(_ sender: Any) {
        current += "3"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press4(_ sender: Any) {
        current += "4"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    
    @IBAction func press5(_ sender: Any) {
        current += "5"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press6(_ sender: Any) {
        current += "6"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press7(_ sender: Any) {
        current += "7"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press8(_ sender: Any) {
        current += "8"
        print(current)
        words = dictionQuery.getWord(sequence: current)
        print(words)
        self.collectionView.reloadData()
    }
    @IBAction func press9(_ sender: Any) {
        current += "9"
        print(current)
        words = dictionQuery.getWord(sequence: current)
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
        return words.count
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return CGSize(width: screenWidth/3, height: screenWidth/3);
        let frame = CGRectFromString(current)
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        var label = cell.viewWithTag(1) as! UILabel
        
        label.text = words[indexPath.row]
        label.sizeToFit()
        
        
        //let frame = CGRectFromString(label.text!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        
        let proxy = self.textDocumentProxy
        proxy.insertText("\(words[indexPath.row])")
        self.collectionView.reloadData()
        current = ""
        words = []
    }
}

