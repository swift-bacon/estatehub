//
//  DescriptionLabel.swift
//  EstateHub
//
//  Created by Unit27 on 02/08/2025.
//
import UIKit

class DescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    convenience init(labelText: String) {
        self.init(frame: .zero)
        text = labelText
    }
    
    private func setupStyles() {
        font = .systemFont(ofSize: 16, weight: .regular)
        textColor = .black
        tintColor = UIColor.black.withAlphaComponent(0.99)
        numberOfLines = 3
    }
    
}
