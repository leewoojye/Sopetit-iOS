//
//  DollNameView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import SnapKit
import Lottie

final class DollNameView: UIView {
    
    // MARK: - Properties
    
    var dollNumber: Int = 0
    
    // MARK: - UI Components
    
    private let progressView = CustomProgressView(progressNum: 2)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.dollNameTitle
        label.font = .fontGuide(.head1)
        label.textColor = .Gray700
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 4)
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.dollNameSubTitle
        label.font = .fontGuide(.body4)
        label.textColor = .Gray400
        return label
    }()
    
    var lottieHello = LottieAnimationView()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = I18N.Onboarding.textfieldPlaceholder
        textField.setPlaceholderColor(.Gray200)
        textField.textAlignment = .center
        textField.textColor = .Gray700
        textField.font = .fontGuide(.body4)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.Gray200.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .SoftieWhite
        textField.becomeFirstResponder()
        return textField
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Onboarding.dollNameInfoTitle
        label.textColor = .SoftieRed
        label.font = .fontGuide(.caption1)
        label.isHidden = true
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Onboarding.dollNameButtonTitle, for: .normal)
        button.setTitleColor(.Gray300, for: .disabled)
        button.setTitleColor(.Gray000, for: .normal)
        button.setBackgroundColor(.Gray100, for: .disabled)
        button.setBackgroundColor(.SoftieMain1, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DollNameView {

    func setUI() {
        backgroundColor = .SoftieBack
        
        lottieHello.frame = bounds
        lottieHello.center = center
        lottieHello.contentMode = .scaleToFill
        lottieHello.backgroundColor = .clear
        lottieHello.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setHierarchy() {
        addSubviews(progressView, titleLabel, subTitleLabel, lottieHello, nameTextField, infoLabel, nextButton)
    }
    
    func setLayout() {
        progressView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(23)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        lottieHello.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(-40)
            $0.centerX.equalToSuperview()
            
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.width.equalTo(250)
                $0.height.equalTo(250)
            } else {
                $0.width.equalTo(302)
                $0.height.equalTo(303)
            }
        }
        
        nameTextField.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.bottom.equalTo(lottieHello.snp.bottom).offset(-10)
            } else {
                $0.bottom.equalTo(lottieHello.snp.bottom)
            }
            $0.centerX.equalToSuperview()
            $0.width.equalTo(159)
            $0.height.equalTo(40)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-SizeLiterals.Screen.screenHeight * 17 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(56)
        }
    }
    
    func setDoll(num: Int) {
        var animationName = ""
        
        switch num {
        case 0:
            animationName = "brown_hello"
        case 1:
            animationName = "gray_hello"
        case 2:
            animationName = "white_hello"
        case 3:
            animationName = "red_hello"
        default:
            break
        }
        
        lottieHello = LottieAnimationView(name: animationName)
        lottieHello.loopMode = .loop
        lottieHello.play()
        
        addSubview(lottieHello)
        lottieHello.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(-40)
            $0.centerX.equalToSuperview()
            
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.width.equalTo(250)
                $0.height.equalTo(250)
            } else {
                $0.width.equalTo(302)
                $0.height.equalTo(303)
            }
        }
        bringSubviewToFront(nameTextField)
    }
}
