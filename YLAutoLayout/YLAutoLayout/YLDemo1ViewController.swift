//
//  YLDemo1ViewController.swift
//  YLAutoLayout
//
//  Created by lenovo on 15/7/21.
//  Copyright © 2015年 zylll520. All rights reserved.
//

import UIKit

class YLDemo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGrayColor()
        demo1()
//        demo2()
    }

    private lazy var centerView: UIView = {
        let v1 = UIView()
        v1.backgroundColor = UIColor.redColor()
        self.view.addSubview(v1)
        v1.yl_MakeSizeConstraint(CGSizeMake(200, 200))
        v1.yl_MakeDoubleConstraint(attributes: yl_AlignType.CenterCenter, referView: nil, offset: nil)
        return v1
        }()
    
    private func demo1() { // 控件参照父控件布局，共9种
        let v1 = centerView
        
        let v2 = UIView()
        v2.backgroundColor = UIColor.blueColor()
        v1.addSubview(v2)
        v2.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v2.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftTop, referView: v1, offset: nil)
        
        
        let v3 = UIView()
        v3.backgroundColor = UIColor.blueColor()
        v1.addSubview(v3)
        v3.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v3.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftCenter, referView: v1, offset: nil)
        
        let v4 = UIView()
        v4.backgroundColor = UIColor.blueColor()
        v1.addSubview(v4)
        v4.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v4.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftBottom, referView: v1, offset: nil)
        
        let v5 = UIView()
        v5.backgroundColor = UIColor.blueColor()
        v1.addSubview(v5)
        v5.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v5.yl_MakeDoubleConstraint(attributes: yl_AlignType.CenterTop, referView: v1, offset: nil)
        
        let v6 = UIView()
        v6.backgroundColor = UIColor.blueColor()
        v1.addSubview(v6)
        v6.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v6.yl_MakeDoubleConstraint(attributes: yl_AlignType.CenterCenter, referView: v1, offset: nil)
        
        let v7 = UIView()
        v7.backgroundColor = UIColor.blueColor()
        v1.addSubview(v7)
        v7.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v7.yl_MakeDoubleConstraint(attributes: yl_AlignType.CenterBottom, referView: v1, offset: nil)
        
        let v8 = UIView()
        v8.backgroundColor = UIColor.blueColor()
        v1.addSubview(v8)
        v8.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v8.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightTop, referView: v1, offset: nil)
        
        let v9 = UIView()
        v9.backgroundColor = UIColor.blueColor()
        v1.addSubview(v9)
        v9.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v9.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightCenter, referView: v1, offset: nil)
        
        let v10 = UIView()
        v10.backgroundColor = UIColor.blueColor()
        v1.addSubview(v10)
        v10.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v10.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightBottom, referView: v1, offset: nil)
    }
    
    
    private func demo2() { // 同一层级控件参考，共12种
        let v1 = centerView
        
        let v2 = UIView()
        v2.backgroundColor = UIColor.blueColor()
        view.addSubview(v2)
        v2.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v2.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftTop, referView: v1, offset: nil)
        
        let v3 = UIView()
        v3.backgroundColor = UIColor.blueColor()
        view.addSubview(v3)
        v3.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v3.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftCenter, referView: v1, offset: nil)
        
        let v4 = UIView()
        v4.backgroundColor = UIColor.blueColor()
        view.addSubview(v4)
        v4.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v4.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftBottom, referView: v1, offset: nil)
        
        let v5 = UIView()
        v5.backgroundColor = UIColor.blueColor()
        view.addSubview(v5)
        v5.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v5.yl_MakeDoubleConstraint(attributes: yl_AlignType.TopLeft, referView: v1, offset: nil)
        
        let v6 = UIView()
        v6.backgroundColor = UIColor.blueColor()
        view.addSubview(v6)
        v6.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v6.yl_MakeDoubleConstraint(attributes: yl_AlignType.TopRight, referView: v1, offset: nil)
        //
        let v7 = UIView()
        v7.backgroundColor = UIColor.blueColor()
        view.addSubview(v7)
        v7.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v7.yl_MakeDoubleConstraint(attributes: yl_AlignType.BottomLeft, referView: v1, offset: nil)
        
        
        let v17 = UIView()
        v17.backgroundColor = UIColor.blueColor()
        view.addSubview(v17)
        v17.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v17.yl_MakeDoubleConstraint(attributes: yl_AlignType.BottomRight, referView: v1, offset: nil)
        
        let v8 = UIView()
        v8.backgroundColor = UIColor.blueColor()
        view.addSubview(v8)
        v8.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v8.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightTop, referView: v1, offset: nil)
        
        let v9 = UIView()
        v9.backgroundColor = UIColor.blueColor()
        view.addSubview(v9)
        v9.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v9.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightCenter, referView: v1, offset: nil)
        
        let v10 = UIView()
        v10.backgroundColor = UIColor.blueColor()
        view.addSubview(v10)
        v10.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v10.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightBottom, referView: v1, offset: nil)
        
        
        let v11 = UIView()
        v11.backgroundColor = UIColor.blueColor()
        view.addSubview(v11)
        v11.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v11.yl_MakeDoubleConstraint(attributes: yl_AlignType.TopCenter, referView: v1, offset: nil)
        
        let v12 = UIView()
        v12.backgroundColor = UIColor.blueColor()
        view.addSubview(v12)
        v12.yl_MakeSizeConstraint(CGSizeMake(20, 20))
        v12.yl_MakeDoubleConstraint(attributes: yl_AlignType.BottomCenter, referView: v1, offset: nil)
    }
    

}
