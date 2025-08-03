//
//  AdvertTableViewCell.swift
//  EstateHub
//
//  Created by Unit27 on 03/08/2025.
//
import UIKit

class AdvertTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var advertImageView: UIImageView!
    @IBOutlet weak var advertTitleLabel: UILabel!
    @IBOutlet weak var advertDescriptionLabel: UILabel!
    @IBOutlet weak var advertPriceLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Layout setups
    
    private func layoutSetups() {
        
    }
    
}
