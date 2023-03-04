//
//  OnboardingCollectionViewCell.swift
//  OnboardingScreenApp
//
//  Created by Aykhan Hajiyev on 04.03.23.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func configure(_ item: OnboardingModel) {
        mainImageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
