//
//  ProfileHeaderView.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    // MARK: - UIProperties:
    #if RELEASE
    public var usersData: CurrentUser? {
        didSet {
            imageAvatar.image = usersData?.user.avatar
            nameLabel.text = usersData?.user.fullName
            statusField.text = usersData?.user.status
        }
    }
    #else
    public var usersDataTest: TestUserService? {
        didSet {
            imageAvatar.image = usersDataTest?.user.avatar
            nameLabel.text = usersDataTest?.user.fullName
            statusField.text = usersDataTest?.user.status
        }
    }
    #endif
    
    var imageAvatar: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "10"))
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 90
        return imageView
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel()
       label.text = "Snake Eyes"
       label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
       label.tintColor = .black
       return label
    }()
    
    var statusField: UITextField = {
        let status = UITextField()
        status.placeholder = "Waiting for something..."
        status.font = UIFont.systemFont(ofSize: 18.5, weight: .regular)
        status.tintColor = .gray
        status.textAlignment = .left
        return status
    }()
    
    var pressButton: UIButton = {
       let button = UIButton()
       button.addTarget(self, action: #selector(statusTextChanged), for: .touchUpInside)
       button.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
       button.setTitle("Set status", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.backgroundColor = #colorLiteral(red: 0, green: 0.4780977368, blue: 0.9984350801, alpha: 1)
       button.layer.cornerRadius = 14
       button.layer.shadowOffset.width = 4
       button.layer.shadowOffset.height = 4
       button.layer.shadowRadius = 4
       button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       button.layer.shadowOpacity = 0.7
       return button
    }()
    
    var statusShowText: UITextField = {
        let status = UITextField()
        status.indentText(size: 10)
        status.placeholder = "Status..."
        status.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 2
        status.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        status.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        status.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return status
    }()
    
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: .zero)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods:
    @objc func statusTextChanged() {
        statusField.text = statusShowText.text
    }
    
    func autoLayout() {
        [imageAvatar, nameLabel, statusField, statusShowText, pressButton].forEach { addSubview($0) }
        [imageAvatar, nameLabel, statusField, statusShowText, pressButton].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        imageAvatar.snp.makeConstraints { make in
            make.height.width.equalTo(180)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(SetupConstraints.indent)
            make.leading.equalToSuperview().inset(SetupConstraints.indent)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(27)
            make.leading.equalTo(imageAvatar.snp.trailing).offset(12)
            make.trailing.equalTo(snp.trailing)
        }
        
        statusField.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalTo(-24)
        }
        
        statusShowText.snp.makeConstraints { make in
            make.top.equalTo(statusField.snp.top).inset(30)
            make.leading.equalTo(statusField.snp.leading)
            make.trailing.equalTo(-12)
            make.height.equalTo(40)
        }
        
        pressButton.snp.makeConstraints { make in
            make.top.equalTo(statusShowText.snp.top).inset(54)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(SetupConstraints.indent)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(SetupConstraints.indent)
            make.height.equalTo(50)
        }
    }
}
