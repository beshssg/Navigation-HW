//
//  CustomButton.swift
//  NavigationNET
//
//  Created by beshssg on 22.09.2021.
//

import UIKit

final class CustomButton: UIButton {
    init(title: String, color: UIColor, target: @escaping () -> Void) {
        newTarget = target
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let newTarget: () -> Void
    
    @objc private func buttonTapped() {
        newTarget()
    }
}
