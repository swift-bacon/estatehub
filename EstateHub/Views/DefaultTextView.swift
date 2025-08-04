//
//  DefaultTextView.swift
//  EstateHub
//
//  Created by Unit27 on 04/08/2025.
//
import UIKit

class DefaultTextView: UITextView {

    // MARK: - Properties

    private let bottomLine = CALayer()
    private let placeholderLabel = UILabel()
    
    var maxLength: Int?

    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    // MARK: - Init

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        commonInit()
        
        setupStyles()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        
        setupStyles()
    }
    
    convenience init(placeholder: String, _ maxLength: Int?) {
        self.init(frame: .zero, textContainer: nil)
        self.placeholder = placeholder
        self.placeholderLabel.text = placeholder
        self.maxLength = maxLength
    }

    private func commonInit() {
        delegate = self
    }
    
    // MARK: - Styling Setup

    private func setupStyles() {
        backgroundColor = .clear
        textColor = .label
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        keyboardType = .default
        autocorrectionType = .no
        autocapitalizationType = .none

        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        layer.addSublayer(bottomLine)

        placeholderLabel.textColor = .systemGray3
        placeholderLabel.font = font
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainer.lineFragmentPadding - 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textContainer.lineFragmentPadding)
        ])
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomLineFrame()
    }

    private func updateBottomLineFrame() {
        let lineOffset: CGFloat = -2
        bottomLine.frame = CGRect(x: 0, y: bounds.height + lineOffset, width: bounds.width, height: 1)
    }
}

// MARK: - UITextViewDelegate

extension DefaultTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !text.isEmpty
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !text.isEmpty
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= maxLength ?? Int.max
    }
}
