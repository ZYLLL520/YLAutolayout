//
//  UIView+AutoLayout.swift
//  YLAutoLayout
//
//  Created by lenovo on 15/7/10.
//  Copyright © 2015年 zylll520. All rights reserved.
//

import UIKit

/*
  top       1
  bottom    2
  left      3
  right     4
  center    5
*/

public enum yl_AlignType: Int {
    
    case LeftTop        = 31        /// 左上
    case LeftCenter     = 35        /// 左中
    case LeftBottom     = 32        /// 左下
    
    case RightTop       = 41        /// 右上
    case RightCenter    = 45        /// 右中
    case RightBottom    = 42        /// 右下
    
    case CenterTop      = 51        /// 中上
    case CenterCenter   = 55        /// 中中
    case CenterBottom   = 52        /// 中下
    
    case TopLeft        = 13        /// 上左
    case TopCenter      = 15        /// 上中
    case TopRight       = 14        /// 上右
    
    case BottomLeft     = 23        /// 下左
    case BottomCenter   = 25        /// 下中
    case BottomRight    = 24        /// 下右
    
    private func typeToArray() -> [NSLayoutAttribute] { // 枚举类型转类型数组
        var cons = [NSLayoutAttribute]()
        let firstNumber = self.rawValue / 10
        let lastNumber = self.rawValue % 10
        cons.append(numberToType(firstNumber, isFirst: true))
        cons.append(numberToType(lastNumber, isFirst: false))
        return cons
    }
    
    private func numberToType(number: Int, isFirst: Bool) -> NSLayoutAttribute { // 数字转类型
        switch number {
        case 1:
            return NSLayoutAttribute.Top
        case 2:
            return NSLayoutAttribute.Bottom
        case 3:
            return NSLayoutAttribute.Left
        case 4:
            return NSLayoutAttribute.Right
        case 5:
            return isFirst ? NSLayoutAttribute.CenterX : NSLayoutAttribute.CenterY
        default:
            print("Data error, please check carefully!")
            return NSLayoutAttribute.Baseline
        }
    }
    
}

extension UIView {
    
    // MARK: - Add Constraint
    
    ///  添加两个控件之间的所需的4种约束
    ///
    ///  :param: attributes 约束类型
    ///  :param: referView  参照视图
    ///  :param: size       控件大小
    ///  :param: offset     偏移量
    ///
    ///  :returns: 对象的约束
    public func yl_MakeFourConstraint(attributes attributes: yl_AlignType, referView: UIView?, size: CGSize?, offset: CGPoint?) -> [NSLayoutConstraint] {
        var cons = [NSLayoutConstraint]()
        cons += yl_MakeDoubleConstraint(attributes: attributes, referView: referView, offset: offset)
        if let mySize = size {
            cons += yl_MakeSizeConstraint(mySize)
        }
        return cons
    }
    
    ///  添加两个控件之间的约束
    ///
    ///  :param: attributes 约束类型
    ///
    ///  :param: referView  参照视图（省略为父视图）
    ///
    ///  :param: offset     约束大小（省略为0，0）
    ///
    ///  :returns: 对应的约束
    public func yl_MakeDoubleConstraint(attributes attributes: yl_AlignType, referView: UIView?, offset: CGPoint?) -> [NSLayoutConstraint] {
        assert(superview != nil, "View's superview must not be nil")
        if referView != nil && !self.isDescendantOfView(referView!) {
            assert(referView!.superview != nil, "referView should add to the superView")
        }
        
        // 判断控件层级关系
        let isSameFather = (referView != nil && !self.isDescendantOfView(referView!))
        var addCons = attributes.typeToArray()
        if isSameFather && (addCons.contains(NSLayoutAttribute.Top) || addCons.contains(NSLayoutAttribute.Bottom)) && addCons.contains(NSLayoutAttribute.CenterY) { // 错误修正
            addCons.removeLast()
            addCons.append(NSLayoutAttribute.CenterX)
        }
        // 添加约束
        var returnCons = [NSLayoutConstraint]()
        let firstAtt = isSameFather ? addCons[0].reverseType() : addCons[0]
        
        returnCons += p_addConstraint(firstAtt: firstAtt, referView: referView ?? superview!, lastAtt: addCons[0], constant: offset?.x ?? 0)
        returnCons += p_addConstraint(firstAtt: addCons[1], referView: referView ?? superview!, lastAtt: addCons[1], constant: offset?.y ?? 0)
        return returnCons
    }
    
    ///  添加约束
    ///
    ///  :param: attribute 约束类型
    ///  :param: referView 参照视图（省略则为父视图）
    ///  :param: constant  约束大小（省略则为0，0）
    ///
    ///  :returns: 对应的约束
    public func yl_MakeConstraint(attribute attribute: NSLayoutAttribute, referView: UIView?, constant: CGFloat?) -> [NSLayoutConstraint] {
        
        assert(superview != nil, "View's superview must not be nil")
        if referView != nil && !self.isDescendantOfView(referView!) {
            assert(referView!.superview != nil, "referView should add to the superView")
        }
        
        // 参照父视图
        var cons = [NSLayoutConstraint]()
        let myReferView = (referView == nil || self.isDescendantOfView(referView!)) ? superview! : referView!
        
        // 同一层次的两个视图参考
        cons += p_addConstraint(firstAtt: attribute, referView: myReferView, lastAtt: attribute, constant: constant ?? 0)
        return cons
    }
    
    // MARK: - Add Size Constraint
    
    ///  设置控件的大小约束
    ///
    ///  :param: size 约束大小( -1 表示忽略)
    ///
    ///  :returns: 对应的约束
    public func yl_MakeSizeConstraint(size: CGSize) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        // 宽度约束
        if size.width > -1 {
            cons += NSLayoutConstraint.constraintsWithVisualFormat("H:[subView(\(size.width))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subView": self])
        }
        // 宽度约束
        if size.height > -1 {
            cons += NSLayoutConstraint.constraintsWithVisualFormat("V:[subView(\(size.height))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subView": self])
        }
        addConstraints(cons)
        return cons
    }
    
    ///  指定两个控件大小相等
    ///
    ///  :param: referView 参照视图(省略则为父视图)
    ///
    ///  :returns: 对应的约束
    public func yl_MakeSizeEqual(referView: UIView?) -> [NSLayoutConstraint] {
        assert(superview != nil, "View's superview must not be nil")
        if referView != nil && !self.isDescendantOfView(referView!) { // 同一层级
            assert(referView!.superview != nil, "referView should add to the superView")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: referView ?? self.superview, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0))
        cons.append(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: referView ?? self.superview, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0))
        
        superview!.addConstraints(cons)
        return cons
    }
    
    // MARK: - Other Constraint
    
    ///  填充子视图
    ///
    ///  - parameter insets: 间距 默认为UIEdgeInsetsZero
    public func yl_MakeFill(insets: UIEdgeInsets = UIEdgeInsetsZero) -> [NSLayoutConstraint] {
        assert(superview != nil, "View's superview must not be nil")
        
        translatesAutoresizingMaskIntoConstraints = false
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(insets.left)-[subView]-\(insets.right)-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : self])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(insets.top)-[subView]-\(insets.bottom)-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: ["subView" : self])
        
        superview!.addConstraints(cons)
        return cons
    }
    
    ///  在当前视图内部垂直平铺控件
    ///
    ///  - parameter views:  子视图数组
    ///  - parameter insets: 间距
    ///
    ///  - returns: 约束数组
    public func yl_MakeVerticalTile(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        assert(!views.isEmpty, "view should no be empty")
        
        var cons = [NSLayoutConstraint]()
        let firstView = views[0]
        firstView.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftTop, referView: self, offset: CGPointMake(insets.left, insets.top))
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        var preView = firstView
        for i in 1..<views.count {
            let subView = views[i]
            cons += subView.yl_MakeSizeEqual(firstView)
            subView.yl_MakeDoubleConstraint(attributes: yl_AlignType.RightTop, referView: preView, offset: CGPointMake(insets.right, 0))
            preView = subView
        }
        
        let lastView = views.last!
        cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -insets.right))
        
        addConstraints(cons)
        return cons
    }
    
    ///  在当前视图内部水平平铺控件
    ///
    ///  - parameter views:  子视图数组
    ///  - parameter insets: 间距
    ///
    ///  - returns: 约束数组
    public func yl_MakeHorizontalTile(views: [UIView], insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        assert(!views.isEmpty, "views should not be empty")
        
        var cons = [NSLayoutConstraint]()
        
        let firstView = views[0]
        firstView.yl_MakeDoubleConstraint(attributes: yl_AlignType.LeftTop, referView: self, offset: CGPointMake(insets.left, insets.top))
        cons.append(NSLayoutConstraint(item: firstView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -insets.right))
        
        var preView = firstView
        for i in 1..<views.count {
            let subView = views[i]
            cons += subView.yl_MakeSizeEqual(preView)
            subView.yl_MakeDoubleConstraint(attributes: yl_AlignType.BottomLeft, referView: preView, offset: CGPointMake(insets.bottom, 0))
            preView = subView
        }
        
        let lastView = views.last!
        cons.append(NSLayoutConstraint(item: lastView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -insets.bottom))
        
        addConstraints(cons)
        return cons
    }
    
    // MARK: - Search、update or clear Constraint
    
    ///  从约束数组中查找指定 attribute 的约束
    ///
    ///  - parameter constraintsList: 约束数组
    ///  - parameter attribute:       约束属性
    ///
    ///  - returns: attribute 对应的约束
    public func yl_SearchConstraint(constraintsList: [NSLayoutConstraint], attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        for constraint in constraintsList {
            if constraint.firstItem as! NSObject == self && constraint.firstAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
    
    ///  删除控件的所有布局
    public func yl_ClearConstraint() {
        let cons = p_allConstraints()
        superview!.removeConstraints(cons)
    }
    
    ///  更新控件的指定约束
    ///
    ///  :param: attribute    约束类型
    ///  :param: constant     约束值
    ///  :param: isNeedLayout 是否立刻更新视图
    public func yl_UpdateConstraint(attribute attribute: NSLayoutAttribute, constant: CGFloat, isNeedLayout: Bool) {
        if let constraint = p_SearchConstraint(attribute: attribute) {
            constraint.constant = constant
        } else {
            assert(true, "view must add this constraint before update constraint")
        }
        
        if isNeedLayout {
            layoutIfNeeded()
        }
    }
    
    // MARK: - private func
    
    private func p_addConstraint(firstAtt firstAtt: NSLayoutAttribute, referView: UIView, lastAtt: NSLayoutAttribute, constant: CGFloat) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let con = NSLayoutConstraint(item: self, attribute: firstAtt, relatedBy: NSLayoutRelation.Equal, toItem: referView, attribute: lastAtt, multiplier: 1.0, constant: constant)
        
        self.superview!.addConstraint(con)
        
        return [con]
    }
    
    private func p_allConstraints() -> [NSLayoutConstraint] {
        assert(superview != nil, "View's superview must not be nil")
        var cons = [NSLayoutConstraint]()
        for con in superview!.constraints {
            if con.firstItem as! NSObject == self {
                cons .append(con)
            }
        }
        return cons
    }
    
    // TODO: 查询约束有待测试！
    private func p_SearchConstraint(attribute attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        let constraints = p_allConstraints()
        for constraint in constraints {
            if constraint.firstItem as! NSObject == self && constraint.firstAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
    
}

private extension NSLayoutAttribute {
    private func reverseType() -> NSLayoutAttribute { // 反转类型
        switch self {
        case .Top:
            return NSLayoutAttribute.Bottom
        case .Bottom:
            return NSLayoutAttribute.Top
        case .Left:
            return NSLayoutAttribute.Right
        case .Right:
            return NSLayoutAttribute.Left
        default:
            return self
        }
    }
}
