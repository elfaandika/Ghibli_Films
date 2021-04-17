//
//  MoviesListTableViewCell.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import UIKit

final class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleYearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8))
        coverImage.layer.cornerRadius = 25
        coverImage.backgroundColor = .secondarySystemBackground
    }
    
    func updateData(model: MoviesModel) {
        coverImage.image = UIImage(named: "Ghibli")
        titleYearLabel.text = "\(model.title) - \(model.release_date)"
        directorLabel.text = model.director
        descriptionLabel.text = model.description
    }
    
}
