//
//  ProfileTimerFooterView.swift
//  NavigationNET
//
//  Created by beshssg on 18.10.2021.
//

import UIKit
import SnapKit

class ProfileTimerFooterView: UIView {
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .systemGray6
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupViews()
    }

    func setupViews() {
        addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        timerLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(8)
        }
        
        configure()
    }
    
    func configure() {
        backgroundColor = .white
        alpha = 0.8
    }
}
