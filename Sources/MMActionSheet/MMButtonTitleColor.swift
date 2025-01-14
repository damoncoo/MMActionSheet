//
//  MMButtonTitleColor.swift
//  swiftui
//
//  Created by JefferDevs on 2021/9/13.
//  Copyright © 2021 keeponrunning. All rights reserved.
//

import UIKit

public enum MMButtonTitleColor {
    /// `default`
    case `default`
    /// blue
    case blue
    /// danger
    case danger
    /// custom
    case custom(UIColor)
}

extension MMButtonTitleColor: RawRepresentable {
    public typealias RawValue = UIColor

    public init?(rawValue: UIColor) {
        switch rawValue {
        case MMColor.dynamicColor(color1: .black, color2: .white): self = .default
        case UIColor(red: 0.082, green: 0.494, blue: 0.984, alpha: 1.00): self = .blue
        case UIColor.red: self = .danger
        case let color: self = .custom(color)
        }
    }

    public var rawValue: UIColor {
        switch self {
        case .default: return MMColor.dynamicColor(color1: .black, color2: .white)
        case .blue: return UIColor(red: 0.082, green: 0.494, blue: 0.984, alpha: 1.00)
        case .danger: return UIColor.red
        case let .custom(customColor): return customColor
        }
    }
}
