//
//  AttributedImageView.swift
//  Authorization
//
//  Created by mac on 11.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

@IBDesignable class AttributedImageView: UIImageView {
    
    // MARK: - variables
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            guard let borderColor = borderColor else {return}
            
            layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
}
