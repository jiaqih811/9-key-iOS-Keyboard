//
//  CustomButton.swift
//  9-key
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//
import Foundation
import UIKit

class CommonButton: UIButton {
    private var frontColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInitView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        didInitView()
    }
    
    private func didInitView() {
        //self.backgroundColor = KeyboardThemeManager.theme.KeyboardButtonBackgroundColorNormal
        self.layer.cornerRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //frontColor = backgroundColor
        //backgroundColor = KeyboardThemeManager.theme.KeyboardButtonBackgroundColorPressed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //backgroundColor = frontColor
    }
    
}

class DeleteButton: UIButton {
    private var frontColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInitView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        didInitView()
    }
    
    private func didInitView() {
        //self.backgroundColor = KeyboardThemeManager.theme.KeyboardButtonBackgroundColorNormal
        self.layer.cornerRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //frontColor = backgroundColor
        //backgroundColor = KeyboardThemeManager.theme.KeyboardButtonBackgroundColorPressed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //backgroundColor = frontColor
    }
    
}






//test

//var testButton: UIButton!










