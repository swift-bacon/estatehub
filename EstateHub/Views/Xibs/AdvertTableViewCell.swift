//
//  AdvertTableViewCell.swift
//  EstateHub
//
//  Created by Unit27 on 03/08/2025.
//
import UIKit

class AdvertTableViewCell: UITableViewCell {
    
    // MARK: - View configuration
    
    enum ViewConfiguration: String {
        case `default` = "AdvertTableViewCell"
        var nib: UINib? {
            get {
                return UINib(nibName: self.rawValue, bundle: nil)
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var advertImageView: UIImageView!
    @IBOutlet weak var advertTitleLabel: UILabel!
    @IBOutlet weak var advertDescriptionLabel: UILabel!
    @IBOutlet weak var advertPriceLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutSetups()
    }
    
    // MARK: - Layout setups
    
    private func layoutSetups() {
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = false
        
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOpacity = 0.05
        bgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        bgView.layer.shadowRadius = 12
        
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        advertImageView.layer.cornerRadius = 15
        advertImageView.clipsToBounds = false
    }
    
}
