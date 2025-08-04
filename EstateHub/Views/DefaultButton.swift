//
//  DefaultButton.swift
//  EstateHub
//
//  Created by Unit27 on 31/07/2025.
//
import UIKit

class DefaultButton: UIButton {
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    convenience init(title: String, target: Any?, action: Selector) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    // MARK: - Setup styles
    
    ///
    /// Setup styles
    ///
    private func setupStyles() {
        role = .primary
        layer.cornerRadius = 10
        clipsToBounds = true
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font.withSize(16)
        backgroundColor = UIColor.black
        tintColor = UIColor.black.withAlphaComponent(0.99)
    }
    
    // MARK: - Overrides
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1.0
        }
    }
}

