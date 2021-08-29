//
//  ExtensionUITextFiled.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit

     // MARK: - Indent text(spacing) extension
extension UITextField {
    func indentText(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: frame.minX, y: frame.minY, width: size, height: frame.height))
        self.leftViewMode = .always
    }
}
