//
//  KeyboardViewController.swift
//  9-key-keyboard
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit

//定义枚举类型标注shift按键所单击的次数
enum SHIFT_TYPE
{
    case shift_LOWERALWAYS;
    case shift_UPPERONCE;
    case shift_UPPERALWAYS;
}

//定义枚举类型标注当前键盘类型
enum KEYBOARD_TYPE
{
    case alphabet; //字母键盘
    case number; //数字键盘
}

//定义一个全局的变量，标注单击shift按键的次数
var shiftFlag:SHIFT_TYPE = SHIFT_TYPE.shift_LOWERALWAYS;



class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        
        
        
    
        
        
        
        
        
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
    
    
    
    

}


