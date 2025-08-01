//
//  DefaultTextField.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class DefaultTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    // MARK: - Style Setup
    
    private func setupStyles() {
        borderStyle = .roundedRect
        keyboardType = .emailAddress
        autocapitalizationType = .none
        autocorrectionType = .no
        font = UIFont.systemFont(ofSize: 16)
        backgroundColor = .systemBackground
        textColor = .label
    }
}
