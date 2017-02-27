//
//  NavgationBarExtension.swift
//  JYTable+Nav
//
//  Created by atom on 2017/2/20.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

var key: String = "coverView"

extension UINavigationBar {
    
    var coverView: UIView? {
        
        get {
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        
        set {
        
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        }
    
    }
    
    func setMyBackgroundColor(color: UIColor) {
        
        if self.coverView != nil {
            
            self.coverView?.backgroundColor = color
        
        } else {
            
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.size.width, height: self.bounds.height + 20))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.insertSubview(view, at: 0)
        
        }
    
    }
    
    func setMyBackgroundColorAlpha(alpha: CGFloat){
    
        guard let coverView = self.coverView else { return }
        
        self.coverView?.backgroundColor = coverView.backgroundColor?.withAlphaComponent(alpha)
    }

}
