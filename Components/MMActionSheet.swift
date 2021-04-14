//
//  MMActionSheet.swift
//  swiftui
//
//  Created by 郭永红 on 2017/10/9.
//  Copyright © 2017年 keeponrunning. All rights reserved.
//

import UIKit

//常量
let mmdivideLineHeight : CGFloat = 1                       /* 按钮与按钮之间的分割线高度 */
let mmscreenBounds = UIScreen.main.bounds                /* 屏幕Bounds */
let mmscreenSize   = mmscreenBounds.size                 /* 屏幕大小 */
let mmscreenWidth  = mmscreenSize.width                  /* 屏幕宽度 */
let mmscreenHeight = mmscreenSize.height                 /* 屏幕高度 */
let mmbuttonHeight : CGFloat = 48.0 * mmscreenWidth / 375  /* button高度 */
let mmtitleHeight : CGFloat = 48.0 * mmscreenWidth / 375   /* 标题的高度 */
let mmbtnPadding : CGFloat = 5 * mmscreenWidth / 375       /* 取消按钮与其他按钮之间的间距 */
let mmdefaultDuration = 0.25

let mmmaxHeight = mmscreenHeight / 2                     /* sheet的最大高度 */

public typealias actionClickBlock = (String) ->()

public class MMActionSheet : UIView {
    var title : String?     //标题
    var buttons : Array<Dictionary<String, String>>?    //按钮组
    var duration : Double?  //动画时长
    var cancelButton : Dictionary<String, String>?     //取消按钮
    
    var normalButtons = [UIButton]()

    //适配iphoneX
    var paddng_bottom : CGFloat = mmscreenHeight == 812.0 ? 34.0 : 0.0
    
    var actionSheetHeight : CGFloat = 0
    var scrollView : UIScrollView = UIScrollView()
    public var actionSheetView : UIView = UIView()

    public var callBack : actionClickBlock?

    override init(frame : CGRect) {
        super.init(frame : frame)
    }

    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder : ) has not been implemented")
    }


    /// 初始化
    ///
    /// - Parameters :
    ///   - title : 标题
    ///   - buttons : 按钮数组
    ///   - duration : 动画时长
    ///   - cancel : 是否需要取消按钮
    convenience public init(title : String?, buttons : Array<Dictionary<String, String>>?, duration : Double?, cancelBtn : Dictionary<String, String>?) {

        //半透明背景
        self.init(frame : mmscreenBounds)
        self.title = title ?? ""
        self.buttons = buttons ?? []
        self.duration = duration ?? mmdefaultDuration
        self.cancelButton = cancelBtn ?? [ : ]
        //添加单击事件，隐藏sheet
        let singleTap = UITapGestureRecognizer.init(target : self, action : #selector(self.singleTapDismiss))
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)

        //actionSheet
        initActionSheet()
        //初始化UI
        initUI()
    }

    func initActionSheet() {
        
        self.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.3)
        
        self.actionSheetView.backgroundColor = MMColor.dynamicColor(color1 : MMColor.hexColor(hexString : "#F7F8F9")!, color2 : MMColor.hexColor(hexString : "#333333")!)
        
        let btnCount = buttons?.count ?? 0
        var tHeight : CGFloat = 0.0
        if (self.title != nil && self.title != "")   {
            tHeight = mmtitleHeight
        }

        var cancelHeight : CGFloat = 0.0
        if self.cancelButton! != [ : ] {
            cancelHeight = mmbuttonHeight + mmbtnPadding
        }
        
        let itemHeight = CGFloat(btnCount) * mmbuttonHeight + CGFloat(btnCount) * mmdivideLineHeight + paddng_bottom
        let height = min(itemHeight, mmmaxHeight)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x : 0, y : 0, width : mmscreenWidth, height : height + tHeight)
        self.actionSheetView.addSubview(scrollView)

        actionSheetHeight = height + tHeight + cancelHeight
        let aFrame : CGRect = CGRect.init(x : 0, y : mmscreenHeight, width : mmscreenWidth, height : actionSheetHeight)
        self.actionSheetView.frame = aFrame
        self.addSubview(self.actionSheetView)

        // 根据内容高度计算动画时长
        self.duration = duration ?? (mmdefaultDuration * Double(actionSheetHeight/216))
    }

    func initUI() {

        //标题不为空，则添加标题
        var titleH : CGFloat = 0
        if (self.title != nil && self.title != "")  {
            let titlelabel = UILabel.init(frame : CGRect.init(x : 0, y : 0, width : mmscreenWidth, height : mmtitleHeight))
            titlelabel.text = self.title
            titlelabel.textAlignment = .center
            if #available(iOS 8.2, *) {
                titlelabel.font = UIFont.systemFont(ofSize : 16, weight : .medium)
            } else {
                titlelabel.font = UIFont.systemFont(ofSize : 16)
            }
            titlelabel.backgroundColor = MMColor.dynamicColor(color1 : UIColor.white, color2 : UIColor.black)
            titlelabel.textColor = MMColor.dynamicColor(color1 : UIColor.black, color2 : UIColor.white)

            self.actionSheetView.addSubview(titlelabel)
            
            let line = UIView(frame : CGRect.init(x : 0, y : mmtitleHeight - 1, width : mmscreenWidth, height : 1))
            line.backgroundColor = MMColor.dynamicColor(color1 : MMColor.hexColor(hexString : "#f2f3f5")!,
                                                        color2 : MMColor.hexColor(hexString : "#333333")!)
            self.actionSheetView.addSubview(line)
            
            titleH = mmtitleHeight
        }

        //事件按钮组
        let itemHeight = CGFloat(buttons?.count ?? 0) * mmbuttonHeight + CGFloat(buttons?.count ?? 0) * mmdivideLineHeight + paddng_bottom + titleH
        let view = UIView(frame : CGRect(x : 0, y : 0, width : mmscreenWidth, height : itemHeight))
        self.scrollView.addSubview(view)
        let buttonsCount = self.buttons?.count ?? 0
        for index in 0..<buttonsCount {
            let btn = self.buttons![index]

            var tHeight : CGFloat = 0.0
            if (self.title != nil && self.title != "")   {
                tHeight = mmtitleHeight
            }

            let origin_y = tHeight + mmbuttonHeight * CGFloat(index) + mmdivideLineHeight * CGFloat(index)

            let button = MMButton.init(type : .custom)
            button.frame = CGRect.init(x : 0.0, y : origin_y, width : mmscreenWidth, height : mmbuttonHeight)
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize : 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = btn["handler"]
            button.setTitle(btn["title"], for : .normal)
            
            button.updateTitleColor(type : btn["type"])

            button.setBackgroundImage(self.imageWithColor(color : MMButton.currentColor(), size : button.bounds.size), for : .normal)
            button.setBackgroundImage(self.imageWithColor(color : MMButton.currentHighlightColor(), size : button.bounds.size), for : .highlighted)
            button.addTarget(self, action : #selector(self.actionClick), for : .touchUpInside)
            view.addSubview(button)
        }
        scrollView.contentSize = CGSize(width : mmscreenWidth, height : itemHeight)

        //如果取消为ture则添加取消按钮
        if self.cancelButton! != [ : ] {
            let button = MMButton.init(type : .custom)
            button.frame = CGRect.init(x : 0, y : Int(self.actionSheetView.bounds.size.height - mmbuttonHeight - paddng_bottom), width : Int(mmscreenWidth), height : Int(mmbuttonHeight))
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize : 16)
            } else {
                // Fallback on earlier versions
            }
            button.handler = self.cancelButton?["handler"] ?? "cancel"
            button.setTitle(self.cancelButton?["title"] ?? "取消", for : .normal)
                     
            button.updateTitleColor(type : self.cancelButton!["type"])
            button.setBackgroundImage(self.imageWithColor(color : MMButton.currentColor(), size : button.bounds.size), for : .normal)
            button.setBackgroundImage(self.imageWithColor(color : MMButton.currentHighlightColor(), size : button.bounds.size), for : .highlighted)
         
            button.addTarget(self, action : #selector(self.actionClick), for : .touchUpInside)
            self.actionSheetView.addSubview(button)
        }


    }

    @objc func actionClick(button : MMButton) {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!(button.handler!)
        }
    }

    @objc func singleTapDismiss() {
        self.dismiss()
        if (self.callBack != nil) {
            self.callBack!("cancel")
        }
    }

    /// 显示
    public func present() {
        UIView.animate(withDuration : 0.1, animations : {
            UIApplication.shared.keyWindow?.addSubview(self)
        }) { (finished : Bool) in
            UIView.animate(withDuration : self.duration!) {
                var tempFrame = self.actionSheetView.frame
                tempFrame.origin.y = mmscreenHeight - tempFrame.size.height
                self.actionSheetView.frame = tempFrame
            }
        }

    }

    /// 隐藏
    func dismiss() {
        UIView.animate(withDuration : self.duration!, animations : {
            var tempFrame = self.actionSheetView.frame
            tempFrame.origin.y = mmscreenHeight
            self.actionSheetView.frame = tempFrame
        }) { (finished : Bool) in
            self.removeFromSuperview()
        }
    }

    /// 修改样式
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight], radius : 6, view : self.actionSheetView)
    }

    func imageWithColor(color : UIColor,size : CGSize) ->UIImage {
        let rect = CGRect(x : 0, y : 0, width : size.width, height : size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection : UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    func roundCorners(_ corners : UIRectCorner, radius : CGFloat, view : UIView) {
        let maskPath = UIBezierPath(
            roundedRect : bounds,
            byRoundingCorners : corners,
            cornerRadii : CGSize(width : radius, height : radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func dynamicColor(color1 : UIColor, color2 : UIColor) -> UIColor {
        
        if #available(iOS 13.0, *) {
            let dark = UITraitCollection.current.userInterfaceStyle == .dark
            return dark ? color2 : color1
        } else {
            return color1
        }
    }
        
}

extension MMActionSheet : UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer : UIGestureRecognizer, shouldReceive touch : UITouch) -> Bool {
        if touch.view == self.actionSheetView {
            return false
        }
        return true
    }
}

