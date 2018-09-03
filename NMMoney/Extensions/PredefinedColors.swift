//
//  UIColor+PredefinedColors.swift
//  TokenWallet
//
//  Created by BAMFAdmin on 25.06.2018.
//  Copyright © 2018 BAMFAdmin. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Inits color with 0 - 255 format of RGB
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    enum StartButtons {
        static var simple: UIColor {
            return UIColor(r: 0, g: 147, b: 191)
        }
        static var pressed: UIColor {
            return UIColor(r: 43, g: 113, b: 141)
        }
    }
    
    enum Text {
        static var lightRed: UIColor {
            return UIColor(r: 236.0, g: 0.0, b: 68.0)
        }
        static var karatGold: UIColor {
            return UIColor(r: 213.0, g: 189.0, b: 132.0)
        }
        
        static var light: UIColor {
            return UIColor(r: 239.0, g: 240.0, b: 242.0)
        }
        
        static var warning: UIColor {
            return UIColor(r: 255.0, g: 157.0, b: 96.0)
        }
        
        static var gray: UIColor {
            return UIColor(r: 129.0, g: 136, b: 143)
        }
        static var redTr: UIColor {
            return UIColor(r: 255.0, g: 65.0, b: 65.0)
        }
        static var greenTR: UIColor {
            return UIColor(r: 33.0, g: 150.0, b: 83.0)
        }
    }
    
    enum View {
        static var lightRed: UIColor {
            return UIColor(r: 222.0, g: 86.0, b: 86.0)
        }
        
        static var light: UIColor {
            return UIColor(r: 250.0, g: 250.0, b: 250.0)
        }
        
        static var lightGreen: UIColor {
            return UIColor(r: 213.0, g: 189.0, b: 132.0)
        }
    }
    
    enum TransactionSign {
        static var received: UIColor {
            return UIColor(r: 43.0, g: 209.0, b: 81.0)
        }
        
        static var sent: UIColor {
            return UIColor(r: 234.0, g: 83.0, b: 83.0)
        }
    }
}
