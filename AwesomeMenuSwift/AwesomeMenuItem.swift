//
//  AwesomeMenuItem.swift
//  AwesomeMenuSwift
//
//  Created by 李江波 on 2017/8/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

@objc protocol AwesomeMenuItemDelegate: NSObjectProtocol {

    @objc func AwesomeMenuItemTouchesBegan(item: AwesomeMenuItem)
    @objc func AwesomeMenuItemTouchesEnd(item: AwesomeMenuItem)
}
//内连函数
@inline(__always) func ScaleRect(rect: CGRect, n: CGFloat) -> CGRect { return CGRect(x: (rect.size.width - rect.size.width * n) / 2, y: (rect.size.height - rect.size.height * n) / 2, width: rect.size.width * n, height: rect.size.height * n) }

class AwesomeMenuItem: UIImageView {
    
    
    
    var contentImageView: UIImageView?
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    var nearPoint: CGPoint?
    var farPoint: CGPoint?
    
    weak var delegate: AwesomeMenuItemDelegate?
    
    init(image: UIImage?, highlightedImage: UIImage?, contentImage: UIImage?, highlightedContentImage: UIImage?) {
        
        super.init(image: image, highlightedImage: highlightedImage)
        isUserInteractionEnabled = true
        contentImageView = UIImageView(image: contentImage, highlightedImage: highlightedContentImage)
        self.addSubview(contentImageView!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bounds = CGRect(x: 0, y: 0, width: (self.image?.size.width)!, height: (self.image?.size.height)!)
        let width = contentImageView?.image?.size.width ?? 0
        let height = contentImageView?.image?.size.height ?? 0
        contentImageView?.frame = CGRect(x: self.bounds.size.width / 2 - width / 2 , y: self.bounds.size.height / 2 - height / 2, width: width, height: height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isHighlighted = true
        if delegate!.responds(to: #selector(AwesomeMenuItemDelegate.AwesomeMenuItemTouchesBegan(item:))) {
            delegate?.AwesomeMenuItemTouchesBegan(item: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = (touches as NSSet).anyObject() as! UITouch
        let location: CGPoint = touch.location(in: self)
        if ScaleRect(rect: bounds, n: 2).contains(location) {
            isHighlighted = false
        }
    }
    
    
}














