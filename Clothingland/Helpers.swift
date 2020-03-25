//
//  Helpers.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import Foundation
import UIKit


extension UIView {

    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints( NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary) )
    }

    func addBorder(borderColor: UIColor = UIColor.red, widthBorder: CGFloat = 1.0) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = widthBorder
    }

}


extension UITableViewCell {
    
    func releaseView() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}

extension UICollectionViewCell {
    
    func releaseView() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}

