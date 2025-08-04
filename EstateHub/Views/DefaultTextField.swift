//
//  DefaultTextField.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

class DefaultTextField: UITextField {
    
    private let bottomLine = CALayer()

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

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomLineFrame()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    // MARK: - Style Setup

    private func setupStyles() {
        borderStyle = .none
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 16)
        textColor = .label
        keyboardType = .emailAddress
        autocapitalizationType = .none
        autocorrectionType = .no

        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        layer.addSublayer(bottomLine)
    }

    private func updateBottomLineFrame() {
        let lineOffset: CGFloat = -2
        bottomLine.frame = CGRect(x: 0, y: bounds.height + lineOffset, width: bounds.width, height: 1)
    }
}
