//
//  ParallaxHeaderView.swift
//  JYTable+Nav
//
//  Created by atom on 2017/2/20.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

protocol ParallaxHeaderViewDelegate: class {
    
    func lockScrollView(maxOffsetY: CGFloat)
    func autoAdjustNavgationBarAplha(aplha: CGFloat)
    
}

extension ParallaxHeaderViewDelegate where Self: UITableViewController {
    
    func lockScrollView(maxOffsetY: CGFloat) {
    
        self.tableView.contentOffset.y = maxOffsetY
    }
    
    func autoAdjustNavgationBarAplha(aplha: CGFloat) {
        
        self.navigationController?.navigationBar.setMyBackgroundColorAlpha(alpha: aplha)
    
    }

}

enum ParallaxHeaderViewStyle {
    case Default
    case Thumb
}

class ParallHeaderView: UIView {
    
    var subView: UIView
    var contentView: UIView = UIView()
    var maxOffsetY: CGFloat
    var autoAdjustAplha: Bool = false
    weak var delegate: ParallaxHeaderViewDelegate!
    
    private var blurView: UIVisualEffectView?
    private let defaultBlurViewAlpha: CGFloat = 0.5
    private let style: ParallaxHeaderViewStyle
    private let originY: CGFloat = -64
    
    init(style: ParallaxHeaderViewStyle, subView: UIView, headerViewSize: CGSize, maxOffsetY: CGFloat, delegate: ParallaxHeaderViewDelegate){
        
        self.subView = subView
        
        self.maxOffsetY = maxOffsetY < 0 ? maxOffsetY : -maxOffsetY
        
        self.delegate = delegate
        self.style = style
        super.init(frame: CGRect(x: 0, y: 0, width: headerViewSize.width, height: headerViewSize.height))
        subView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        
        self.clipsToBounds = false
        self.contentView.frame = self.bounds
        self.contentView.addSubview(subView)
        self.contentView.clipsToBounds = true
        self.addSubview(contentView)
        
        self.setupStyle()
        
    }
    
    private func setupStyle(){
        
        switch style {
            
        case .Default:
            self.autoAdjustAplha = true
        case .Thumb:
            self.autoAdjustAplha = false
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.alpha = defaultBlurViewAlpha
            blurView.frame = self.subView.frame
            blurView.autoresizingMask = self.subView.autoresizingMask
            
            self.blurView = blurView
            self.contentView.addSubview(blurView)
        }
    
    }
    
    func layoutHeaderViewWhenScroll(offset: CGPoint){
        
        let delta: CGFloat = offset.y
        
        if delta < maxOffsetY {
            
            self.delegate.lockScrollView(maxOffsetY: maxOffsetY)
            
        } else if delta < 0 {
        
            var rect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            rect.origin.y += delta
            rect.size.height -= delta
            self.contentView.frame = rect
        }
        
        
        switch style {
        case .Default:
            self.layoutDefaultViewWhenScroll(delta: delta)
        case .Thumb:
            self.layoutThumbViewWhenScroll(delta: delta)
        
        }
        
        if self.autoAdjustAplha {
            
            let alpha = CGFloat((-originY + delta) / (self.frame.size.height))
            self.delegate.autoAdjustNavgationBarAplha(aplha: alpha)
        }
    }
    
    private func layoutDefaultViewWhenScroll(delta: CGFloat){}
    
    private func layoutThumbViewWhenScroll(delta: CGFloat){
        
        if delta > 0 {
            
            self.contentView.frame.origin.y = delta
        
        }
        
        if let blurView = self.blurView, delta < 0 {
        
            blurView.alpha = defaultBlurViewAlpha - CGFloat(delta / maxOffsetY) < 0 ? 0 : defaultBlurViewAlpha - CGFloat(delta / maxOffsetY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
















