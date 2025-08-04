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
        advertImageView.layer.cornerRadius = 15
        advertImageView.clipsToBounds = false
    }
    
}
