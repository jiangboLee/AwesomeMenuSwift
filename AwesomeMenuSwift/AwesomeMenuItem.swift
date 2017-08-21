//
//  AwesomeMenuItem.swift
//  AwesomeMenuSwift
//
//  Created by 李江波 on 2017/8/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class AwesomeMenuItem: UIImageView {
    
    var contentImageView: UIImageView?
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    var nearPoint: CGPoint?
    var farPoint: CGPoint?
    
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
    
}














