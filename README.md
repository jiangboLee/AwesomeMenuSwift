# AwesomeMenuSwift
## 基于AwesomeMenu的swift
[原oc版本链接](https://github.com/levey/AwesomeMenu)

因为要用到这个AwesomeMenu这个第三方,但项目是Swift的，虽然可以用桥接文件，由于有空就将其转换成Swift.

#### 使用方法与原来一模一样
```
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
        //设置代理
        menu.delegate = self
```
#### 代理方法如下
```
extension ViewController: AwesomeMenuDelegate {

    func awesomeMenu(menu: AwesomeMenu, didSelectedIndex: NSInteger) {
        
        awesomeMenuWillAnimationClose(menu: menu)
        switch didSelectedIndex {
        case 0:
            print("点击了第一个")
            view.backgroundColor = UIColor.red
        case 1:
            print("点击了第二个")
            view.backgroundColor = UIColor.blue
        case 2:
            print("点击了第三个")
            view.backgroundColor = UIColor.yellow
        case 3:
            print("点击了第四个")
            view.backgroundColor = UIColor.lightGray
        default:
            print("")
        }
    }
    
    func awesomeMenuWillAnimationOpen(menu: AwesomeMenu) {
        
        print("WillAnimationOpen")
        UIView.animate(withDuration: 0.25) { 
            menu.alpha = 1
            menu.contentImage = #imageLiteral(resourceName: "icon_pathMenu_cross_normal")
            menu.highlightedContentImage = #imageLiteral(resourceName: "icon_pathMenu_cross_highlighted")
        }
    }
    
    func awesomeMenuWillAnimationClose(menu: AwesomeMenu) {
        print("WillAnimationClose")
        UIView.animate(withDuration: 0.25) {
            menu.alpha = 0.7
            menu.contentImage = #imageLiteral(resourceName: "icon_pathMenu_mainMine_normal")
            menu.highlightedContentImage = #imageLiteral(resourceName: "icon_pathMenu_mainMine_highlighted")
        }
    }
    
    func awesomeMenuDidFinishAnimationOpen(menu: AwesomeMenu) {
        print("DidFinishAnimationOpen")
    }
    
    func awesomeMenuDidFinishAnimationClose(menu: AwesomeMenu) {
        print("DidFinishAnimationClose")
    }
}

```
#### demo效果图

![1.gif](http://upload-images.jianshu.io/upload_images/2868618-435ed18eceaa4da2.gif?imageMogr2/auto-orient/strip)

[demo地址](https://github.com/jiangboLee/AwesomeMenuSwift)
