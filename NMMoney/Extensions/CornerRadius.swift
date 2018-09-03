//
//  UIView+CornerRadius.swift
//  TokenWallet
//
//  Created by BAMFAdmin on 28.06.2018.
//  Copyright © 2018 BAMFAdmin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
