//
//  DollNameViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

import Lottie

final class DollNameViewController: UIViewController {
    
    // MARK: - Properties
    
    var userDollName: String = ""
    var dollNum: Int = 0
    
    // MARK: - UI Components
    
    private let dollNameView = DollNameView()
    private lazy var textfield = dollNameView.nameTextField
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = dollNameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        dollNameView.nameTextField.becomeFirstResponder()
    }
}

// MARK: - Extensions

extension DollNameViewController {
    
    func setUI() {
        dollNameView.setDoll(num: dollNum)
        self.navigationController?.navigationBar.isHidden = true
    }

    func setDelegate() {
        textfield.delegate = self
    }
    
    func setAddTarget() {
        dollNameView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        if let text = textfield.text, !text.isEmpty {
            userDollName = text
        }
        let nav = ThemeSelectViewController()
        nav.doll = userDollName
        switch dollNum {
        case 0:
            nav.dollType = "BROWN"
        case 1:
            nav.dollType = "GRAY"
        case 2:
            nav.dollType = "WHITE"
        case 3:
            nav.dollType = "RED"
        default:
            break
        }
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - Network

extension DollNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let forbiddenCharacters = CharacterSet(charactersIn: I18N.Onboarding.dollSpecialText).subtracting(.decimalDigits)
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if (string.rangeOfCharacter(from: forbiddenCharacters) != nil) || string.containsEmoji {
            dollNameView.infoLabel.isHidden = false
            dollNameView.infoLabel.text = I18N.Onboarding.dollNameInfoTitle
            return false
        }
        if newText.count > 10 {
            dollNameView.infoLabel.isHidden = false
            dollNameView.infoLabel.text = I18N.Onboarding.dollNameInfoTitle2
            return false
        }
        if !currentText.isEmpty {
            dollNameView.nextButton.isEnabled = true
        }
        dollNameView.infoLabel.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
