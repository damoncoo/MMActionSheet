//
//  MMTools.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public struct MMTools {
    /// Default
    public struct DefaultColor {
        public static let backgroundColor = MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "#F2F3F5")!, color2: MMColor.hexColor(hexString: "#2B2B2B", transparency: 1)!)
        public static let normalColor = MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "#FFFFFF")!, color2: MMColor.hexColor(hexString: "#191919", transparency: 1)!)
        public static let highlightColor = MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "#F2F3F5")!, color2: MMColor.hexColor(hexString: "#333333")!)
    }
    
    static var isIphoneX: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
