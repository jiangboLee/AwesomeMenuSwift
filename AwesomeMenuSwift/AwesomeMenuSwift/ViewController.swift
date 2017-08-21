//
//  ViewController.swift
//  AwesomeMenuSwift
//
//  Created by 李江波 on 2017/8/20.
//  Copyright © 2017年 lijiangbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startItem = AwesomeMenuItem(image: #imageLiteral(resourceName: "icon_pathMenu_background_normal"), highlightedImage: #imageLiteral(resourceName: "icon_pathMenu_background_highlighted"), contentImage: #imageLiteral(resourceName: "icon_pathMenu_mainMine_normal"), highlightedContentImage: #imageLiteral(resourceName: "icon_pathMenu_mainMine_highlighted"))
        let item0 = AwesomeMenuItem(image: #imageLiteral(resourceName: "bg_pathMenu_black_normal"), highlightedImage: nil, contentImage: #imageLiteral(resourceName: "icon_pathMenu_mainMine_normal"), highlightedContentImage: #imageLiteral(resourceName: "icon_pathMenu_mainMine_highlighted"))
        let item1 = AwesomeMenuItem(image: #imageLiteral(resourceName: "bg_pathMenu_black_normal"), highlightedImage: nil, contentImage: #imageLiteral(resourceName: "icon_pathMenu_collect_normal"), highlightedContentImage: #imageLiteral(resourceName: "icon_pathMenu_collect_highlighted"))
        let item2 = AwesomeMenuItem(image: #imageLiteral(resourceName: "bg_pathMenu_black_normal"), highlightedImage: nil, contentImage: #imageLiteral(resourceName: "icon_pathMenu_scan_normal"), highlightedContentImage: #imageLiteral(resourceName: "icon_pathMenu_scan_highlighted"))
        let item3 = AwesomeMenuItem(image: #imageLiteral(resourceName: "bg_pathMenu_black_normal"), highlightedImage: nil, contentImage: #imageLiteral(resourceName: "icon_pathMenu_more_normal"), highlightedContentImage: #imageLiteral(resourceName: "icon_pathMenu_more_highlighted"))
        let arr = [item0, item1, item2, item3]
        let menu = AwesomeMenu(frame: CGRect.zero, startItem: startItem, menuItems: arr)
        view.addSubview(menu)
        //设置展开角度
        menu.menuWholeAngle = CGFloat(Double.pi / 2)
        //中间按钮不旋转
        menu.rotateAddButton = false
        //设置菜单按钮的位置
        menu.startPoint = CGPoint(x: 50, y: 200)
        //设置透明度
        menu.alpha = 0.7
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}















