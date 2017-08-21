//
//  AwesomeMenu.swift
//  AwesomeMenuSwift
//
//  Created by 李江波 on 2017/8/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

protocol AwesomeMenuDelegate: NSObjectProtocol {
    
    func awesomeMenu(menu: AwesomeMenu, didSelectedIndex: NSInteger)
    
}

class AwesomeMenu: UIView {
    
    private struct kAwesomeMenuDefault {
        let kAwesomeMenuDefaultNearRadius: CGFloat = 110.0
        let kAwesomeMenuDefaultEndRadius: CGFloat = 120.0
        let kAwesomeMenuDefaultFarRadius: CGFloat = 140.0
        let kAwesomeMenuDefaultStartPointX: CGFloat = 160.0
        let kAwesomeMenuDefaultStartPointY: CGFloat = 240.0
        let kAwesomeMenuDefaultTimeOffset: CGFloat = 0.036
        let kAwesomeMenuDefaultRotateAngle: CGFloat = 0.0
        let kAwesomeMenuDefaultMenuWholeAngle: CGFloat = CGFloat(Double.pi * 2)
        let kAwesomeMenuDefaultExpandRotation: CGFloat = CGFloat(Double.pi)
        let kAwesomeMenuDefaultCloseRotation: CGFloat = CGFloat(Double.pi * 2)
        let kAwesomeMenuDefaultAnimationDuration: CGFloat = 0.5
        let kAwesomeMenuStartMenuDefaultAnimationDuration: CGFloat = 0.3
    }
    private let kAwesomeDefault = kAwesomeMenuDefault()
//    var menuItems: Array
    var nearRadius: CGFloat
    var endRadius: CGFloat
    var farRadius: CGFloat
    var startPoint: CGPoint {
    
        didSet {
            self.startButton?.center = startPoint
        }
    }
    var timeOffset: CGFloat
    var rotateAngle: CGFloat
    var menuWholeAngle: CGFloat
    var expandRotation: CGFloat
    var closeRotation: CGFloat
    var animationDuration: CGFloat
    var rotateAddButton: Bool
    
    var startButton: AwesomeMenuItem?
    var menuItems: Array<AwesomeMenuItem> {
        
        willSet {
            if menuItems == newValue {
                return
            }
            for V in subviews {
                if V.tag >= 1000 {
                    V.removeFromSuperview()
                }
            }
        }
    }
    var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                setMenu()
            } else {
                
            }
            if rotateAddButton {
                let angle = isExpanded ? -CGFloat(Double.pi / 4) : 0
                UIView.animate(withDuration: TimeInterval(kAwesomeDefault.kAwesomeMenuStartMenuDefaultAnimationDuration), animations: { 
                    self.startButton?.transform = CGAffineTransform(rotationAngle: angle)
                })
            }
            if timer == nil {
                flag = isExpanded ? 0 : (menuItems.count - 1)
                let selector = isExpanded ? #selector(expandAnimation) : #selector(closeAnimation)
                
                timer = Timer(timeInterval: TimeInterval(timeOffset), target: self, selector: selector, userInfo: nil, repeats: true)
                RunLoop.current.add(timer!, forMode: .commonModes)
                isAnimating = true
            }
            
        }
        
    }
    //设置代理
    weak var delegate: AwesomeMenuDelegate?
    
    //设置图片
    var image: UIImage? {
        didSet {
            self.startButton?.image = image
        }
    }
    var highlightedImage: UIImage? {
        didSet {
            self.startButton?.highlightedImage = highlightedImage
        }
    }
    var contentImage: UIImage? {
        didSet {
            self.startButton?.contentImageView?.image = contentImage
        }
    }
    var highlightedContentImage: UIImage? {
        didSet {
            self.startButton?.contentImageView?.highlightedImage = highlightedImage
        }
    }
    
    private var isAnimating: Bool = false
    private var timer: Timer?
    private var flag: Int = 0
    
    init(frame: CGRect, startItem: AwesomeMenuItem, menuItems: Array<AwesomeMenuItem>) {
        
        self.nearRadius = kAwesomeDefault.kAwesomeMenuDefaultNearRadius
        self.endRadius = kAwesomeDefault.kAwesomeMenuDefaultEndRadius
        self.farRadius = kAwesomeDefault.kAwesomeMenuDefaultFarRadius
        self.startPoint = CGPoint(x: kAwesomeDefault.kAwesomeMenuDefaultStartPointX, y: kAwesomeDefault.kAwesomeMenuDefaultStartPointY)
        self.timeOffset = kAwesomeDefault.kAwesomeMenuDefaultTimeOffset
        self.rotateAngle = kAwesomeDefault.kAwesomeMenuDefaultRotateAngle
        self.menuWholeAngle = kAwesomeDefault.kAwesomeMenuDefaultMenuWholeAngle
        self.expandRotation = kAwesomeDefault.kAwesomeMenuDefaultExpandRotation
        self.closeRotation = kAwesomeDefault.kAwesomeMenuDefaultCloseRotation
        self.animationDuration = kAwesomeDefault.kAwesomeMenuDefaultAnimationDuration
        self.rotateAddButton = true
        
        self.menuItems = menuItems
        self.startButton = startItem
//        self.startButton.delegate = self
        self.startButton?.center = self.startPoint
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(self.startButton!)
        
    }
    
    //MARK: 公共方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func menuItemAtIndex(index: Int) -> AwesomeMenuItem? {
        if index >= menuItems.count {
            return nil
        }
        return menuItems[index]
    }
    
    func open() {
        
        if isAnimating || isExpanded {
            return
        }
        isExpanded = true
    }
    
    func close() {
        
        if isAnimating || isExpanded {
            return
        }
        isExpanded = false
    }
    
    
    //MARK: UIView's methods
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if isAnimating {
            return false
        }
        if isExpanded == true {
            return true
        } else {
            return self.startButton!.frame.contains(point)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isExpanded = !isExpanded
    }

    //MARK: Instance methods
    private func setMenu() {
        let count: Int = menuItems.count
        for i in 0..<count {
            let item = menuItems[i]
            item.tag = 1000 + i
            item.startPoint = startPoint
            
            if menuWholeAngle >= CGFloat(Double.pi * 2) {
                menuWholeAngle = menuWholeAngle - menuWholeAngle / CGFloat(count)
            }
            let endPoint = CGPoint(x: startPoint.x + endRadius * CGFloat(sinf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count-1)))), y: startPoint.y - endRadius * CGFloat(cosf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count - 1)))))
            item.endPoint = RotateCGPointAroundCenter(point: endPoint, center: startPoint, angle: rotateAngle)
            let nearPoint = CGPoint(x: startPoint.x + nearRadius * CGFloat(sinf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count-1)))), y: startPoint.x - nearRadius * CGFloat(sinf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count-1)))))
            item.nearPoint = RotateCGPointAroundCenter(point: nearPoint, center: startPoint, angle: rotateAngle)
            let farPoint = CGPoint(x: startPoint.x + farRadius * CGFloat(sinf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count-1)))), y: startPoint.x - farRadius * CGFloat(sinf(Float(CGFloat(i) * menuWholeAngle / CGFloat(count-1)))))
            item.farPoint = RotateCGPointAroundCenter(point: farPoint, center: startPoint, angle: rotateAngle)
            item.center = item.startPoint!
//            item.delegate = self
            insertSubview(item, belowSubview: startButton!)
        }
    }
    
    //MARK:  Private methods
    private func RotateCGPointAroundCenter(point: CGPoint, center: CGPoint, angle: CGFloat) -> CGPoint {
        
        let translation = CGAffineTransform(translationX: center.x, y: center.y)
        let rotation = CGAffineTransform(rotationAngle: angle)
        let transformGroup = translation.inverted().concatenating(rotation).concatenating(translation)
        return point.applying(transformGroup)
    }
    
    @objc private func expandAnimation() {
        
        if flag == menuItems.count {
            isAnimating = false
            timer?.invalidate()
            timer = nil
            return
        }
        let tag = 1000 + flag
        let item = viewWithTag(tag) as! AwesomeMenuItem
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.values = Array(arrayLiteral: expandRotation, 0)
        rotateAnimation.duration = CFTimeInterval(animationDuration)
        rotateAnimation.keyTimes = Array(arrayLiteral: 0.3, 0.4)
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = CFTimeInterval(animationDuration)
        let path = CGMutablePath()
        path.move(to: item.startPoint!)
        path.addLine(to: item.farPoint!)
        path.addLine(to: item.endPoint!)
        positionAnimation.path = path
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = Array(arrayLiteral: positionAnimation, rotateAnimation)
        animationGroup.duration = CFTimeInterval(animationDuration)
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        if flag == menuItems.count - 1 {
            animationGroup.setValue("firstAnimation", forKey: "id")
        }
        
        item.layer.add(animationGroup, forKey: "Expand")
        item.center = item.endPoint!
        flag += 1
    }
    
    @objc private func closeAnimation() {
       
        if flag == -1 {
            isAnimating = false
            timer?.invalidate()
            timer = nil
            return
        }
        let tag = 1000 + flag
        let item = viewWithTag(tag) as! AwesomeMenuItem
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.values = Array(arrayLiteral: 0 ,closeRotation, 0)
        rotateAnimation.duration = CFTimeInterval(animationDuration)
        rotateAnimation.keyTimes = Array(arrayLiteral: 0 ,0.4, 0.5)
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = CFTimeInterval(animationDuration)
        let path = CGMutablePath()
        path.move(to: item.endPoint!)
        path.addLine(to: item.farPoint!)
        path.addLine(to: item.startPoint!)
        positionAnimation.path = path
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = Array(arrayLiteral: positionAnimation, rotateAnimation)
        animationGroup.duration = CFTimeInterval(animationDuration)
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        if flag == 0 {
            animationGroup.setValue("lastAnimation", forKey: "id")
        }
        
        item.layer.add(animationGroup, forKey: "Close")
        item.center = item.startPoint!
        flag -= 1
    }
}






























