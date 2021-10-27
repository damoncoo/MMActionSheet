//
//  MMTitleItem.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public struct MMTitleItem {
    /// text
    public var text: String?
    /// text color
    public var textColor: UIColor?
    /// textFont
    public var textFont: UIFont? = .systemFont(ofSize: 14.0)
    /// textAlignment
    public var textAlignment: NSTextAlignment? = .center
    /// backgroundColor
    public var backgroundColor: MMButtonTitleColor? = .custom(MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "F2F3F5")!, color2: MMColor.hexColor(hexString: "333333")!))

    public init(title: String?,
                titleColor: UIColor? = MMButtonTitleColor.default.rawValue,
                titleFont: UIFont? = .systemFont(ofSize: 14.0),
                textAlignment: NSTextAlignment? = .center,
                backgroundColor: MMButtonTitleColor? = .custom(MMColor.dynamicColor(color1: MMColor.hexColor(hexString: "F2F3F5")!, color2: MMColor.hexColor(hexString: "333333")!))
    ) {
        self.text = title
        self.textColor = titleColor
        self.textFont = titleFont
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor ?? .custom(UIColor.clear)
    }
}
