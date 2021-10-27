//
//  MMColor.swift
//  swiftui
//
//  Created by Darcy on 2021/10/26.
//  Copyright © 2021 keeponrunning. All rights reserved.
//
import Foundation
import UIKit

public class MMColor {

    public static func dynamicColor(color1 : UIColor, color2 : UIColor) -> UIColor {
            
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light  {
                    return color1
                }
                return color2
            }
        } else {
            return color1
        }
    }
    
    public static func hexColor(hexString: String, transparency: CGFloat = 1) -> UIColor? {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
                
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }

    
}
