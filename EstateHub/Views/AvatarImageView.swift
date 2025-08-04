//
//  AvatarImageView.swift
//  EstateHub
//
//  Created by Unit27 on 03/08/2025.
//
import UIKit

class AvatarImageView: UIImageView {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        tintColor = .systemGray4
        image = UIImage(systemName: "person.circle")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
    func setImage(_ image: UIImage?) {
        if let image = image {
            self.image = image
        } else {
            self.image = UIImage(systemName: "person.circle")
        }
    }
}
