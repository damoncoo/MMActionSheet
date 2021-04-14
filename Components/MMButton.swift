//
//  DDButton.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

class MMButton: UIButton {
    
    public static var normalColor = UIColor.white
    
    public static var normalHighlightColor = MMColor.hexColor(hexString: "#F2F3F5")

    public static var darkColor = UIColor.black
    
    public static var darkHighlightColor =  MMColor.hexColor(hexString: "#000000", transparency: 0.3)

    static func currentColor() -> UIColor {
        
        return MMColor.dynamicColor(color1: normalColor, color2: darkColor)
    }
    
    static func currentHighlightColor() -> UIColor {
        
        return MMColor.dynamicColor(color1: normalHighlightColor!, color2: darkHighlightColor!)
    }
    
    var handler: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.setBackgroundImage(self.imageWithColor(color: MMButton.currentColor() , size:self.bounds.size), for: .normal)
        self.setBackgroundImage(self.imageWithColor(color: MMButton.currentHighlightColor() , size: self.bounds.size), for: .highlighted)
    }
    
    func imageWithColor(color:UIColor,size:CGSize) ->UIImage {
        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    func updateTitleColor(type : String?)  {
        
        var titleColor : UIColor?

        switch(type) {
        case "blue":
            titleColor = MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "#70a1ff")!,
                                              color2: MMColor.hexColor(hexString: "#70a1ff")!)
            break
        case "danger"?:
            titleColor = UIColor.red
            break
        default:
            titleColor = MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "#000000")!,
                                              color2: MMColor.hexColor(hexString: "#FFFFFF")!)
        }
        self.setTitleColor(titleColor, for: .normal)
    }
    

}
